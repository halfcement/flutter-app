import 'package:flutter/material.dart';
import 'package:normal_template/screens/root_screen/root_screen_controller.dart';
import 'package:get/get.dart';

// 根 页
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageView(
          //默认不能左右滑动
          physics: const NeverScrollableScrollPhysics(),
          controller: rootScreenController.pageController,
          onPageChanged: rootScreenController.onPageChanged,
          children: rootScreenController.pages,
        ),
        bottomNavigationBar: Theme(
          //去除点击水波纹
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            onTap: rootScreenController.onTap,
            currentIndex: rootScreenController.currentPageIndex.value,
            items: rootScreenController.items,
          ),
        ),
      ),
    );
  }
}
