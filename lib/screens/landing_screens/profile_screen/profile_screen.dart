import 'package:flutter/material.dart';
import 'package:normal_template/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../root_screen/root_screen_controller.dart';
//个人页面
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(future: Utils.getPackageInfo(), builder: (context,snapshot){
          const String buildNumber = String.fromEnvironment(
            'FLUTTER_BUILD_NUMBER',
            defaultValue: '0',
          );
          return Text("PROFILE SCREEN${buildNumber}");
        }),
      ),
    );
  }
}
