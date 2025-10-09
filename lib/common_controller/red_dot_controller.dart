import 'package:get/get.dart';
import 'package:itrie/itrie.dart';

/// RedDotController红点系统(未读消息气泡)

class RedDotController extends GetxController {
  //存储用的前缀树
  final _iTrie = ITrie<int>.empty();
  //insert
  void insert(String key,int value) {
    _iTrie.insert(key, value);
    update();
  }
  //insert
  //modify
  void modify(String key,int value) {
    _iTrie.modify(key, (_) => value );
    update();
  }
  //remove
  void remove(String key) {
    _iTrie.remove(key);
    update();
  }
  //query
  int? get(String key) {
    return _iTrie.get(key);
    update();
  }
  //insert many
  void insertMany(List<(String,int)> kv) {
    _iTrie.insertMany(kv);
    update();
  }
  //remove many
  void removeMany(List<String> keys) {
    _iTrie.removeMany(keys);
    update();
  }

}