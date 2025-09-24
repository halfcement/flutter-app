import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/models/global_static_variable.dart';
import 'package:flutter_app_template/screens/auth_screens/login_screen/login_screen.dart';
import 'package:flutter_app_template/screens/root_screen/root_screen.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

import 'launch_screen_controller.dart';

//启动页,用于做一些初始化操作
class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LaunchScreenController());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        //这里通常放闪屏页
        child: Container(
          child: Text('启动页'),
        ),
      ),
    );
  }
}
