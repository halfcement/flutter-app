import 'package:flutter/cupertino.dart';
import 'package:flutter_app_template/screens/launch_screen/launch_screen.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

// 登录页控制器
class LoginScreenController extends GetxController{
  //账号
  var account = ''.obs;
  //密码
  var accountPwd = ''.obs;
  //登录按钮是否可用
  var canSubmit = false.obs;
  //邮箱验证码
  var emailCode = ''.obs;

  //发送验证码
  sendEmailCode() async{
    //TODO 发送验证码
  }
  //验证码登录
  loginByEmailCode() async{
    //TODO 密码登录
    Get.to(LaunchScreen());
  }
  //密码登录
  loginByPwd() async{
    //TODO 密码登录
  }
}