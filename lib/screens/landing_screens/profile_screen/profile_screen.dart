import 'package:flutter/material.dart';
//个人页面
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){

          }, child: Text("GOTOPAGE"))
        ],
      ),
    );
  }
}
