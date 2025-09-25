
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gocaptcha/slide_captcha.dart';
import 'package:normal_template/apis/auth_apis.dart';
import 'package:normal_template/screens/root_screen/root_screen_controller.dart';
import 'package:get/get.dart';

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
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => SlideCaptcha(
                      getCaptcha: AuthApi.getCaptcha,
                      checkCaptcha: AuthApi.checkCaptcha,
                      onSuccess: () async {
                        Get.back();
                      },
                    ),
                  );
              },
              child: Text("TEST Captcha"),
            ),
          ],
        ),
      ),
    );
  }
}
