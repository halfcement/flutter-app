import 'package:flutter/material.dart';
import 'package:flutter_app_template/screens/root_screen/root_screen_state.dart';
import 'package:get/get.dart';
// 根 页
class RootScreen extends StatelessWidget{
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.put(RootScreenState());
    return Scaffold(
      /// TODO 删除如下代码
     body: Obx(()=> Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text("${state.counter}"),
             ElevatedButton(onPressed: (){
               state.counter++;
             }, child: Icon(Icons.add))
           ],
         ),
       ),
     ),
    );
  }
}
