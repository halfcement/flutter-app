import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_template/apis/auth_apis.dart';
import 'package:flutter_app_template/models/captcha_model.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class CaptchaScreenController extends GetxController {
    var captchaModel = CaptchaModel().obs;
    var  left = 0.0.obs;
    @override
  void onInit() async{
    super.onInit();
    captchaModel = CaptchaModel().obs;
    var res = await AuthApi.getCaptcha();
    if(res.success){
      captchaModel.value = CaptchaModel.fromJson(res.data);
      left.value = captchaModel.value.displayX!.toDouble();
    }else{
      SmartDialog.showToast(res.msg??"");
      Get.back();
    }
  }

  //认证
  confirm(DragEndDetails details)async{
    //比例
    var leftValue = (left.value).toInt();
    print("${leftValue}");
    // return;
    SmartDialog.showLoading(msg: '');
    final res = await AuthApi.checkCaptcha(
      captchaId: captchaModel.value.captchaId!,
      captchaKey: captchaModel.value.captchaKey!,
      captchaValue: "$leftValue,${captchaModel.value.displayY}",
    );
    SmartDialog.dismiss();
    if(res.success){
      Get.back();
    }else{
      SmartDialog.showToast("验证错误");
      onInit();
    }
  }
}