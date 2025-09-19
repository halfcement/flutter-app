import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/root_screen/root_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(home: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App name',
      home: RootScreen()
    );
  }
}

