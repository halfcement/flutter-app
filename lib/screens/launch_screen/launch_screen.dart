import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: Text('启动页'),
      ),
    );
  }
}
