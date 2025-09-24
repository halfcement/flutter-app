import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../landing_screens/home_screen/home_screen.dart';
import '../landing_screens/profile_screen/profile_screen.dart';

//状态管理类
final rootScreenController = Get.find<RootScreenController>();
class RootScreenController extends GetxController{
  //当前页面索引
  var currentPageIndex = 0.obs;

  //pageView监听
  onPageChanged(int index){
    currentPageIndex.value = index;
  }
  //底部导航栏点击
  onTap(int index){
    pageController.jumpToPage(index);
  }
  //pageView控制器
  var pageController = PageController();
  //配置底部导航栏,根据自己需要添加
  var items = [
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.center_focus_strong),label: "Center"),
    BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
  ];
  //配置落地页,根据自己需要添加
  var pages = [
    HomeScreen(),
    Center(
      child: Text("CENTER SCREEN"),
    ),
    ProfileScreen(),
  ];
}