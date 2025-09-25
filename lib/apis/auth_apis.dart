import 'dart:io';

import 'package:gocaptcha/slide_captcha_end_model.dart';
import 'package:gocaptcha/slide_captcha_model.dart';
import 'package:localstorage/localstorage.dart';
import 'package:normal_template/apis/api_path.dart';
import 'package:normal_template/apis/api_response.dart';
import 'package:normal_template/config/dio_config/dio_pool_manager.dart';
import 'package:normal_template/config/dio_config/http_method.dart';

import '../models/global_static_variable.dart';
//认证相关接口
class AuthApi {
  //私有构造函数
  static final AuthApi _instance = AuthApi._internal();

  factory AuthApi() => _instance;

  AuthApi._internal();
  //获取图形验证码
  static Future<SlideCaptchaModel> getCaptcha() async {
    var res = await DioPoolManager.request(
      ApiPath.appCaptchaPath,
      data: {
        "deviceUuid": localStorage.getItem(deviceUuid),
      }
    );
    if(res.success){
      return SlideCaptchaModel.fromJson(res.data);
    }else{
      return SlideCaptchaModel();
    }
  }
  //校验图形验证码
  static Future<bool> checkCaptcha(SlideCaptchaEndModel model
      ) async {
    var res =  await DioPoolManager.request(
      method: HttpMethod.POST,
      ApiPath.captchaCheckPath,
      data: {
        "captchaId": model.captchaId,
        "captchaKey": model.captchaKey,
        "captchaValue": model.captchaValue,
        "deviceUuid": localStorage.getItem(deviceUuid),
      }
    );
    return res.success;
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
