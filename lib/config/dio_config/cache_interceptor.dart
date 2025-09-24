//缓存拦截器
import 'package:dio/dio.dart';

class CacheInterceptor extends Interceptor {
  final _cache = <Uri,Response>{};
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_cache.containsKey(options.uri)) {
      return handler.resolve(_cache[options.uri]!); // 返回缓存数据
    }
    return handler.next(options);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _cache[response.requestOptions.uri] = response; // 缓存响应
    return handler.next(response);
  }
}