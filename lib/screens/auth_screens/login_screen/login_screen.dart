import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:normal_template/common_controller/user_controller.dart';
import 'package:normal_template/models/user_info.dart';

// 登录页面
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: TextEditingController(),
            ),
            Obx(()=> Text("${userInfoController.userInfo.toJson()}")),
            ElevatedButton(onPressed: (){
              userInfoController.userInfo.value = UserInfo(userName: "JOJO");
            }, child: Text("hello".tr))
          ],
        ),
      ),
    );
  }
}
