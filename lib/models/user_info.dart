import 'dart:convert';
//用户信息

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));
String userInfoToJson(UserInfo data) => json.encode(data.toJson());
class UserInfo {
  UserInfo({
      String? avatar, 
      String? birthday, 
      String? countryCode, 
      int? gender, 
      int? height, 
      String? interest, 
      String? introduce, 
      int? uid, 
      String? userName, 
      int? userRole, 
      String? userSuperInviteCode, 
      int? weight,}){
    _avatar = avatar;
    _birthday = birthday;
    _countryCode = countryCode;
    _gender = gender;
    _height = height;
    _interest = interest;
    _introduce = introduce;
    _uid = uid;
    _userName = userName;
    _userRole = userRole;
    _userSuperInviteCode = userSuperInviteCode;
    _weight = weight;
}

  UserInfo.fromJson(dynamic json) {
    _avatar = json['avatar'];
    _birthday = json['birthday'];
    _countryCode = json['countryCode'];
    _gender = json['gender'];
    _height = json['height'];
    _interest = json['interest'];
    _introduce = json['introduce'];
    _uid = json['uid'];
    _userName = json['userName'];
    _userRole = json['userRole'];
    _userSuperInviteCode = json['userSuperInviteCode'];
    _weight = json['weight'];
  }
  String? _avatar;
  String? _birthday;
  String? _countryCode;
  int? _gender;
  int? _height;
  String? _interest;
  String? _introduce;
  int? _uid;
  String? _userName;
  int? _userRole;
  String? _userSuperInviteCode;
  int? _weight;

  String? get avatar => _avatar;
  String? get birthday => _birthday;
  String? get countryCode => _countryCode;
  int? get gender => _gender;
  int? get height => _height;
  String? get interest => _interest;
  String? get introduce => _introduce;
  int? get uid => _uid;
  String? get userName => _userName;
  int? get userRole => _userRole;
  String? get userSuperInviteCode => _userSuperInviteCode;
  int? get weight => _weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avatar'] = _avatar;
    map['birthday'] = _birthday;
    map['countryCode'] = _countryCode;
    map['gender'] = _gender;
    map['height'] = _height;
    map['interest'] = _interest;
    map['introduce'] = _introduce;
    map['uid'] = _uid;
    map['userName'] = _userName;
    map['userRole'] = _userRole;
    map['userSuperInviteCode'] = _userSuperInviteCode;
    map['weight'] = _weight;
    return map;
  }

}