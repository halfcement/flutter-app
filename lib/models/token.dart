import 'dart:convert';
//token
Token tokenFromJson(String str) => Token.fromJson(json.decode(str));
String tokenToJson(Token data) => json.encode(data.toJson());
class Token {
  Token({
      this.authorToken, 
      this.authorTokenExpired, 
      this.refreshToken, 
      this.refreshTokenExpired, 
      this.uid,});

  Token.fromJson(dynamic json) {
    authorToken = json['authorToken'];
    authorTokenExpired = json['authorTokenExpired'];
    refreshToken = json['refreshToken'];
    refreshTokenExpired = json['refreshTokenExpired'];
    uid = json['uid'];
  }
  String? authorToken;
  int? authorTokenExpired;
  String? refreshToken;
  int? refreshTokenExpired;
  int? uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['authorToken'] = authorToken;
    map['authorTokenExpired'] = authorTokenExpired;
    map['refreshToken'] = refreshToken;
    map['refreshTokenExpired'] = refreshTokenExpired;
    map['uid'] = uid;
    return map;
  }

}