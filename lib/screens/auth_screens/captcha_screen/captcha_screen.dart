import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:normal_template/apis/auth_apis.dart';
import 'package:normal_template/screens/auth_screens/captcha_screen/captcha_screen_controller.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

//图形验证页面
class CaptchaScreen extends StatelessWidget {
  const CaptchaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.put(CaptchaScreenController());
    return Obx(
      () => state.captchaModel.value.masterImageBase64 == null
          ? CupertinoActivityIndicator()
          : Center(
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        spacing: 8,
                        children: [
                          Text("请拖动滑块完成拼图", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          GestureDetector(onTap: () => Get.back(), child: Icon(CupertinoIcons.clear_circled)),
                          GestureDetector(onTap: () => state.onInit(), child: Icon(CupertinoIcons.refresh_circled)),
                        ],
                      ),
                    ),
                    Container(
                      width: state.captchaModel.value.masterWidth!.toDouble(),
                      child: Stack(
                        children: [
                          Image.memory(state.captchaModel.value.masterImageBase64!),
                          Positioned(
                            top: state.captchaModel.value.displayY!.toDouble(),
                            left: state.left.value,
                            child: Image.memory(state.captchaModel.value.thumbImageBase64!),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: state.captchaModel.value.masterWidth!.toDouble(),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(height: 50),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey.withAlpha(100),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Positioned(
                            left: state.left.value,
                            child: GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                state.left.value += details.delta.dx;
                                // 限制范围：0 到 (背景图宽度 - 滑块宽度)
                                double maxX =
                                    (state.captchaModel.value.masterWidth?.toDouble() ?? 0) -
                                    (state.captchaModel.value.thumbWidth?.toDouble() ?? 0);
                                if (state.left.value < 0) {
                                  state.left.value = 0;
                                }
                                if (state.left.value > maxX) {
                                  state.left.value = maxX;
                                }
                              },
                              onHorizontalDragEnd: (details) async{
                                state.confirm(details);
                              },
                              child: Container(
                                height: 30,
                                width: state.captchaModel.value.thumbWidth?.toDouble() ?? 0,
                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(50)),
                                child: Icon(CupertinoIcons.arrow_right, color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
