import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:normal_template/apis/api_path.dart';
import 'package:normal_template/config/dio_config/http_method.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../models/global_static_variable.dart';
import '../models/token.dart';

class Utils {
  //单例
  static final Utils _instance = Utils._internal();

  factory Utils() => _instance;

  Utils._internal();

  //检查token过期
  static bool checkTokenExpired() {
    //检查token过期
    var tokenString = localStorage.getItem(authorToken);
    if (tokenString == null) {
      return false;
    }
    var token = Token.fromJson(tokenString);
    if (token.authorTokenExpired! <= DateTime.now().millisecondsSinceEpoch &&
        token.refreshTokenExpired! > DateTime.now().millisecondsSinceEpoch) {
      return true;
    } else {
      return false;
    }
  }

  //刷新token
  static Future<String> refreshToken() async {
    var token = Token.fromJson(localStorage.getItem(authorToken));
    var dio = Dio();
    var resp = await dio.request(
      ApiPath.refreshTokenPath,
      data: {"refreshToken": token.refreshToken},
      options: Options(method: HttpMethod.POST),
    );
    Token tokenResult = Token.fromJson(resp.data);
    //更新到缓存中
    localStorage.setItem(authorToken, jsonEncode(tokenResult.toJson()));
    return tokenResult.authorToken ?? '';
  }

  //获取本机uuid
  static Future<void> getUuid() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      localStorage.setItem(deviceUuid, androidInfo.id);
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      localStorage.setItem(deviceUuid, iosInfo.identifierForVendor ?? "");
    }
  }

  //获取包名
  static Future<void> getAppId() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    localStorage.setItem(appId, packageInfo.packageName);
  }

  //记录错误日志并写入文件
  static logRecord(FlutterErrorDetails error) async {
    if(!kDebugMode) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        final logDir = Directory('${dir.path}/error_logs');
        if (!await logDir.exists()) await logDir.create(recursive: true);
        final date = DateTime
            .now()
            .toIso8601String()
            .split('T')
            .first;
        final file = File('${logDir.path}/error_$date.txt');
        final log = StringBuffer()
          ..writeln("[${DateTime.now()}] ERROR:")..writeln(error);
        await file.writeAsString(log.toString(), mode: FileMode.append, flush: true);
      } catch (e) {
        // 防止写日志也报错，避免死循环
        if (kDebugMode) print("Failed to write error log: $e");
      }
    }
  }
  //获取包信息
  static Future<PackageInfo> getPackageInfo()async{
    return  await PackageInfo.fromPlatform();
  }
}
