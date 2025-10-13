import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gocaptcha/slide_captcha.dart';
import 'package:normal_template/apis/auth_apis.dart';
import 'package:normal_template/common_controller/red_dot_controller.dart';
import 'package:normal_template/screens/root_screen/root_screen_controller.dart';
import 'package:get/get.dart';
import 'package:normal_template/test_screen.dart';

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
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>TestScreen()));
            }, child: Text("测试页面"))
          ],
        ),
      ),
    );
  }
}
