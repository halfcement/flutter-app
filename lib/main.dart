import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:normal_template/config/translations.dart';
import 'package:normal_template/models/global_static_variable.dart';
import 'package:normal_template/screens/auth_screens/login_screen/login_screen.dart';
import 'package:normal_template/screens/root_screen/root_screen_controller.dart';

import 'common_controller/user_controller.dart';
import 'screens/root_screen/root_screen.dart';
import 'utils/utils.dart';

//初始化配置
Future<void> initConfig()async{
  FlutterError.onError = (error) async => Utils.logRecord(error);
  //缓存工具初始化
  await initLocalStorage();
  //存储设备唯一标识
  await Utils.getUuid();
  //存储设备唯一标识
  await Utils.getAppId();
  //创建用户信息状态管理控制器
  Get.put(UserInfoController());
  //创建底部导航栏状态管理控制器
  Get.put(RootScreenController());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initConfig();
  //判断是否登录
  var userToken = localStorage.getItem(authorToken);
  //还可以判断是否是第一次使用,版本号是否匹配等操作
  runApp(
    GetMaterialApp(
      //自定义翻译
      translations: LocalTranslation(),
      //默认系统语言
      locale: PlatformDispatcher.instance.locale,
      // 添加一个回调语言选项，以备上面指定的语言翻译不存在
      fallbackLocale: Locale('en', 'US'),
      //支持的语言
      supportedLocales: const [
        Locale('en', 'US'), // 英文
        Locale('zh', 'CN'), // 中文
      ],
      // 添加 Flutter 内置的本地化代理
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //toast+dialog
      builder: FlutterSmartDialog.init(),
      //未登录跳转登录页,已登录去根 页
      home: userToken != null ? LoginScreen() : RootScreen(),
    ),
  );
}
