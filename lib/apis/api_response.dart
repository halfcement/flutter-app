import 'dart:convert';
//请求返回结果
ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));
String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());
class ApiResponse {
  ApiResponse({
      this.code, 
      this.data, 
      this.msg,});

  ApiResponse.fromJson(dynamic json) {
    code = json['code'];
    data = json['data'];
    msg = json['msg'];
  }
  int? code;
  dynamic data;
  String? msg;

  bool get success => code==200;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['data'] = data;
    map['msg'] = msg;
    return map;
  }

}