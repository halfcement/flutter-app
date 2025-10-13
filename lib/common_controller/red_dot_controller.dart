import 'package:get/get.dart';
import 'package:itrie/itrie.dart';

/// RedDotController红点系统(未读消息气泡)

class RedDotController extends GetxController {
  //存储用的前缀树
  var iTrie = ITrie<int>.empty();
  //insert
  void insert(String key,int value) {
    if(get(key)+value>0) {
      iTrie = iTrie.insert(key, value);
      update();
    }
  }
  //modify
  void modify(String key,int value) {
    if(get(key) == 0) {
      insert(key, value);
      return;
    }
    iTrie = iTrie.modify(key, (v){
      if(v+value<0){
        return 0;
      }else{
        return v+value;
      }
    });
    update();
  }
  //remove
  void remove(String key) {
    iTrie.remove(key);
    update();
  }
  //query
  int get(String key) {
    return iTrie.get(key)??0;
  }
  //insert many
  void insertMany(List<(String,int)> kv) {
    iTrie = iTrie.insertMany(kv);
    update();
  }
  //remove many
  void removeMany(List<String> keys) {
    iTrie = iTrie.removeMany(keys);
    update();
  }

}