import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
//用于接受图形验证码的模型
CaptchaModel captchaModelFromJson(String str) => CaptchaModel.fromJson(json.decode(str));
String captchaModelToJson(CaptchaModel data) => json.encode(data.toJson());
class CaptchaModel {
  CaptchaModel({
      String? captchaId, 
      String? captchaKey, 
      int? displayX, 
      int? displayY,
      int? masterHeight, 
      Uint8List? masterImageBase64,
      int? masterWidth, 
      int? thumbHeight,
    Uint8List? thumbImageBase64,
      int? thumbSize, 
      int? thumbWidth,}){
    _captchaId = captchaId;
    _captchaKey = captchaKey;
    _displayX = displayX;
    _displayY = displayY;
    _masterHeight = masterHeight;
    _masterImageBase64 = masterImageBase64;
    _masterWidth = masterWidth;
    _thumbHeight = thumbHeight;
    _thumbImageBase64 = thumbImageBase64;
    _thumbSize = thumbSize;
    _thumbWidth = thumbWidth;
}

  CaptchaModel.fromJson(dynamic json) {
    _captchaId = json['captchaId'];
    _captchaKey = json['captchaKey'];
    _displayX = json['displayX'];
    _displayY = json['displayY'];
    _masterHeight = json['masterHeight'];
    if(json['masterImageBase64']!=null){
      _masterImageBase64 = base64Decode("${json['masterImageBase64']}".split(",")[1]) as Uint8List?;
    }
    _masterWidth = json['masterWidth'];
    _thumbHeight = json['thumbHeight'];
    if(json['thumbImageBase64']!=null) {
      _thumbImageBase64 = base64Decode("${json['thumbImageBase64']}".split(",")[1]) as Uint8List?;
    }
    _thumbSize = json['thumbSize'];
    _thumbWidth = json['thumbWidth'];
  }
  String? _captchaId;
  String? _captchaKey;
  int? _displayX;
  int? _displayY;
  int? _masterHeight;
  Uint8List? _masterImageBase64;
  int? _masterWidth;
  int? _thumbHeight;
  Uint8List? _thumbImageBase64;
  int? _thumbSize;
  int? _thumbWidth;

  String? get captchaId => _captchaId;
  String? get captchaKey => _captchaKey;
  int? get displayX => _displayX;
  int? get displayY => _displayY;
  int? get masterHeight => _masterHeight;
  Uint8List? get masterImageBase64 => _masterImageBase64;
  int? get masterWidth => _masterWidth;
  int? get thumbHeight => _thumbHeight;
  Uint8List? get thumbImageBase64 => _thumbImageBase64;
  int? get thumbSize => _thumbSize;
  int? get thumbWidth => _thumbWidth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['captchaId'] = _captchaId;
    map['captchaKey'] = _captchaKey;
    map['displayX'] = _displayX;
    map['displayY'] = _displayY;
    map['masterHeight'] = _masterHeight;
    map['masterImageBase64'] = _masterImageBase64;
    map['masterWidth'] = _masterWidth;
    map['thumbHeight'] = _thumbHeight;
    map['thumbImageBase64'] = _thumbImageBase64;
    map['thumbSize'] = _thumbSize;
    map['thumbWidth'] = _thumbWidth;
    return map;
  }

}