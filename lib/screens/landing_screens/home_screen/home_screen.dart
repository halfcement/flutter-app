import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/models/global_static_variable.dart';
import 'package:flutter_app_template/screens/auth_screens/captcha_screen/captcha_screen.dart';
import 'package:flutter_app_template/screens/auth_screens/captcha_screen/captcha_screen_controller.dart';
import 'package:flutter_app_template/screens/root_screen/root_screen_controller.dart';
import 'package:flutter_app_template/utils/utils.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

//首页
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String testValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME SCREEN${rootScreenController.currentPageIndex}"),
            GestureDetector(
              onTap: () async {
                showCupertinoDialog(context: context, barrierDismissible: true, builder: (_) => CaptchaScreen()).then((
                  _,
                ) {
                  Get.delete<CaptchaScreenController>();
                });
              },
              child: Text("TEST UUID"),
            ),
          ],
        ),
      ),
    );
  }
}
