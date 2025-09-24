import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:normal_template/apis/api_response.dart';
import 'package:normal_template/models/global_static_variable.dart';
import 'package:normal_template/models/token.dart';
import 'package:normal_template/utils/utils.dart';
import 'package:pool/pool.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:synchronized/synchronized.dart';

import '../../apis/api_path.dart';
import 'get_body_interceptor.dart';
import 'http_method.dart';

//dio请求池
class DioPoolManager {
  //单例模式
  static DioPoolManager? _instance;
  //私有化构造,防止其他地方创建实例
  DioPoolManager._internal();
  factory DioPoolManager() => instance();
  static Dio? _dio;
  static Pool? _pool;
  static final List<CancelToken> _activeCancelTokens = [];
  //全局锁
  static final Lock _tokenLock = Lock();
  //是否启用,防止取消了所有的请求之后还有请求进入队列中
  static bool _enable = true;

  //获取单例
  static DioPoolManager instance() {
      _instance ??= DioPoolManager._internal();
    return _instance!;
  }

  //初始化
  static init({int maxConcurrent = 10}) {
    _enable = true;
    _pool = Pool(maxConcurrent);
    _dio = Dio(
      BaseOptions(
        // 默认的baseUrl
        baseUrl: ApiPath.baseUrl,
        connectTimeout: Duration(seconds: 5), // 连接超时
        receiveTimeout: Duration(seconds: 3), // 接收超时
        sendTimeout: Duration(seconds: 3),
      ),
    );
    //日志拦截器
    _dio!.interceptors.add(PrettyDioLogger(
      enabled: kDebugMode,
      compact: true,
      requestHeader: true,
      requestBody: true,
      request: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ));
    //用于获取get方法的body拦截器,pretty logger不支持从get请求中获取body
    _dio!.interceptors.add(GetBodyLogger());
    //添加请求响应拦截器
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          //添加language
          options.headers["Language"] =
              PlatformDispatcher.instance.locale.languageCode;
          // 添加AUTHORIZATION
          if (!ApiPath.noAuthList.contains(options.path)) {
            var token = Token.fromJson(localStorage.getItem(authorToken));
            options.headers["Authorization"] = "Bearer ${token.authorToken}";
          }
          handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            //如果是token过期了就重新获取
            try{
              await _tokenLock.synchronized(()async{
                if (Utils.checkTokenExpired()) {
                  // 刷新令牌逻辑
                  String newToken = await Utils.refreshToken();
                  e.requestOptions.headers["Authorization"] = "Bearer $newToken";
                }
              });
              final retryResponse = await _dio!.fetch(e.requestOptions); // 重试请求
              return handler.resolve(retryResponse);
            }catch(err){
              return handler.next(e);
            }
          }
          return handler.next(e);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
      ),
    );
    //添加缓存拦截器
    // _dio!.interceptors.add(CacheInterceptor());
  }

  // 发请求的方法，url, method, data, etc.
  static Future<ApiResponse> request(
    String path, {
    String method = HttpMethod.GET,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? externalCancelToken,
  }) async {
    if (_dio == null || _pool == null) {
      init();
    }
    if (!_enable) {
      return ApiResponse(code: -1, msg: "请先初始化DioPoolManager");
    }
    // 如果外部提供了 CancelToken，就用它；否则为这个请求生成一个新的
    final cancelToken = externalCancelToken ?? CancelToken();
    _activeCancelTokens.add(cancelToken);
    // acquire 一个资源才能发请求
    final resource = await _pool?.request();
    try {
      final resp = await _dio?.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options?.copyWith(method: method) ?? Options(method: method),
        cancelToken: cancelToken,
      );
      return ApiResponse.fromJson(resp!.data);
    } catch (e) {
      // 可能是被 cancel，也可能别的错误
      var dioError = e as DioException;
      if (e.runtimeType == DioException) {
        if (dioError.type == DioExceptionType.cancel) {
          log("手动取消请求:${dioError.message}");
          return ApiResponse(code: -10001, msg: "手动取消");
        }else if(dioError.type == DioExceptionType.connectionTimeout){
          return ApiResponse(code: -10002, msg: "请求超时");
        }else{
          return ApiResponse(code: -10003, msg: "请求错误");
        }
      }else{
        rethrow;
      }

    } finally {
      // 释放资源 & 移除 cancel token
      resource?.release();
      _activeCancelTokens.remove(cancelToken);
    }
  }

  // 一键取消所有正在进行的请求
  static void cancelAll([String? reason]) {
    _enable = false;
    for (var token in List<CancelToken>.from(_activeCancelTokens)) {
      if (!token.isCancelled) {
        token.cancel(reason);
      }
    }
    // 清理列表
    _activeCancelTokens.clear();
  }

  //取消指定请求
  static void cancel(CancelToken cancelToken, [String? reason]) {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel(reason);
    }
  }
}
