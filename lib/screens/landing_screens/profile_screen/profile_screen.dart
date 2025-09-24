import 'package:flutter/material.dart';

import '../../root_screen/root_screen_controller.dart';
//个人页面
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("PROFILE SCREEN${rootScreenController.currentPageIndex}"),
      ),
    );
  }
}
