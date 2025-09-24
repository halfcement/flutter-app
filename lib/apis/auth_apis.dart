import 'dart:io';

import 'package:flutter_app_template/apis/api_path.dart';
import 'package:flutter_app_template/apis/api_response.dart';
import 'package:flutter_app_template/config/dio_config/dio_pool_manager.dart';
import 'package:flutter_app_template/config/dio_config/http_method.dart';
import 'package:localstorage/localstorage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/global_static_variable.dart';
//认证相关接口
class AuthApi {
  //私有构造函数
  static final AuthApi _instance = AuthApi._internal();

  factory AuthApi() => _instance;

  AuthApi._internal();
  //获取图形验证码
  static Future<ApiResponse> getCaptcha() async {
    return await DioPoolManager.request(
      ApiPath.appCaptchaPath,
      data: {
        "deviceUuid": localStorage.getItem(deviceUuid),
      }
    );
  }
  //校验图形验证码
  static Future<ApiResponse> checkCaptcha(
      {required String captchaId,
        required String captchaKey,
      required String captchaValue}
      ) async {
    return await DioPoolManager.request(
      method: HttpMethod.POST,
      ApiPath.captchaCheckPath,
      data: {
        "captchaId": captchaId,
        "captchaKey": captchaKey,
        "captchaValue": captchaValue,
        "deviceUuid": localStorage.getItem(deviceUuid),
      }
    );
  }
  //获取app配置
  static Future<ApiResponse> getConfig() async {
    return await DioPoolManager.request(
      method: HttpMethod.POST,
      ApiPath.appConfigPath,
      data: {
        "appId": localStorage.getItem(appId),
        "devicePlatform":Platform.isAndroid?"android":"ios",
        "deviceUuid": localStorage.getItem(deviceUuid),
      }
    );
  }

  //手机密码登录
  static Future<ApiResponse> loginByPhonePwd({
    required String phone,
    required String pwd,
    required String captchaId,
    required String captchaValue,
    required String captchaKey,
  }) async {
    var data = {
      "captchaId": captchaId,
      "captchaKey": captchaKey,
      "captchaValue": captchaValue,
      "deviceUuid": localStorage.getItem(deviceUuid),
      "password": pwd,
      "phone": phone,
    };
    return await DioPoolManager.request(
      method: HttpMethod.POST,
      ApiPath.loginByPhonePwdPath,
      data: data,
    );
  }

  //邮箱密码登录
  static Future<ApiResponse> loginByEmailPwd({
    required String email,
    required String pwd,
    required String captchaId,
    required String captchaValue,
    required String captchaKey,
  }) async {
    var data = {
      "captchaId": captchaId,
      "captchaKey": captchaKey,
      "captchaValue": captchaValue,
      "deviceUuid": localStorage.getItem(deviceUuid),
      "email": email,
      "password": pwd
    };
    return await DioPoolManager.request(
      method: HttpMethod.POST,
      ApiPath.loginByEmailPwdPath,
      data: data,
    );
  }
  //邮箱验证码登录
  static Future<ApiResponse> loginByEmailCode({
    required String email,
    required String code,
  }) async {
    var data = {
      "email": email,
      "code": code,
    };
    return await DioPoolManager.request(
      method: HttpMethod.POST,
      ApiPath.loginByEmailCodePath,
      data: data,
    );
  }
  //手机验证码登录
  static Future<ApiResponse> loginByPhoneSms({
    required String phone,
    required String code,
  }) async {
    var data = {
      "phone": phone,
      "code": code,
    };
    return await DioPoolManager.request(
      method: HttpMethod.POST,
      ApiPath.loginByPhoneCodePath,
      data: data,
    );
  }

}
