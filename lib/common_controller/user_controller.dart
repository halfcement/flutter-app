import 'dart:convert';

import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

import '../models/user_info.dart';
//创建全局用户controller
final userInfoController = Get.find<UserInfoController>();
//用户信息共享
class UserInfoController extends GetxController{
  //用户信息
  var userInfo = Rx<UserInfo?>(null);
  //设置用户信息
  setUserInfo({required String userId,required Map<String,dynamic> info}){
    userInfo.value = UserInfo.fromJson(info);
  }
  //清空用户信息
  clearUserInfo(){
    userInfo.value = null;
  }
}