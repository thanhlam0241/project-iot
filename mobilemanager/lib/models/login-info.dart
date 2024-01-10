import 'dart:convert';

class LoginInfo {
  final String userId;
  final String username;
  final String password;
  final String token;
  final String managementUnitId;

  LoginInfo({required this.userId, required this.username, required this.password, required this.token, required this.managementUnitId});

  factory LoginInfo.fromJson(String jsonStr) {
    var json = jsonDecode(jsonStr);
    return LoginInfo(
      username: json['username'],
      password: json['password'],
      token: json['token'],
      managementUnitId: json['managementUnitId'],
      userId: json['userId'],
    );
  }

  String toJson() {
    return '{"username": "$username", '
        '"userId": "$userId", '
        '"password": "$password", '
        '"token": "$token", '
        '"managementUnitId": "$managementUnitId"}';
  }
}