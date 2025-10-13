import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:normal_template/common_controller/red_dot_controller.dart';
import 'package:badges/badges.dart' as badges;
//用于测试的页面,自行删除

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: GetBuilder<RedDotController>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 30),
              badges.Badge(
                badgeContent: Text(controller.getAll().toString(),style: TextStyle(color: Colors.white),),
                child: Text('消息总数'),
              ),
              Row(children: [Text('聊天列表总数${controller.getChildren('messageBubbleList')}')]),
              Row(children: [Text('系统消息总数${controller.getChildren('messageSystem')}')]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.modify('messageBubbleList', 1);
                    },
                    child: Text('聊天列表+1'),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.remove('messageBubbleList');
                    },
                    child: Text('清空聊天列表'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.modify('messageSystem', 1);
                    },
                    child: Text('系统消息+1'),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.remove('messageSystem');
                    },
                    child: Text('清空系统消息'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
