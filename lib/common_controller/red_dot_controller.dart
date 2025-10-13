import 'package:get/get.dart';
import 'package:itrie/itrie.dart';

/// RedDotController红点系统(未读消息气泡)

class RedDotController extends GetxController {
  //存储用的前缀树
  var iTrie = ITrie<int>.empty();

  //增加
  void _insert(String key, int value) {
    if (get(key) + value > 0) {
      iTrie = iTrie.insert(key, value);
      update();
    }
  }

  //增加指定节点数值
  void modify(String key, int value) {
    if (get(key) == 0) {
      _insert(key, value);
      return;
    }
    iTrie = iTrie.modify(key, (v) {
      if (v + value < 0) {
        return 0;
      } else {
        return v + value;
      }
    });
    update();
  }

  //删除指定节点
  void remove(String key) {
    iTrie = iTrie.remove(key);
    update();
  }
  //清空所有节点数值
  void clear() {
    iTrie = ITrie<int>.empty();
    update();
  }
  //删除其子节点
  void removeChildren(String prefix) {
    iTrie = iTrie.keysWithPrefix(prefix).fold(iTrie, (a, b) => a.remove(b));
    update();
  }

  //获取指定节点的值
  int get(String key) {
    return iTrie.get(key) ?? 0;
  }
  //获取所有节点值
  int getAll() {
    return iTrie.values.fold(0, (a,b)=>a+b);
  }
  //获取子节点所有值
  int getChildren(String prefix) {
    return iTrie.valuesWithPrefix(prefix).fold(0, (a, b) => a + b);
  }
  ///其他方法根据自己需要自行添加
}
