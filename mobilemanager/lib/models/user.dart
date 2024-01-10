import 'dart:convert';

class User {
  String id;
  String username;
  String fullName;
  String code;
  Role role;
  bool active;
  String managementUnitId;
  String managementUnitName;

  User({required this.id, required this.username, required this.fullName,
    required this.code, required this.role, required this.active,
    required this.managementUnitId, required this.managementUnitName});

  factory User.fromJson(String jsonStr) {
    var json = jsonDecode(jsonStr);
    return User(
      id: json['id'],
      username: json['username'],
      fullName: json['fullName'],
      code: json['code'],
      role: _fromStringToRole(json['role']),
      active: json['active'],
      managementUnitId: json['managementUnitId'],
      managementUnitName: json['managementUnitName'],
    );
  }

  String toJson() {
    return '{"id": "$id", '
        '"username": "$username", '
        '"fullName": "$fullName", '
        '"code": "$code", '
        '"role": ${role.index}, '
        '"active": $active, '
        '"managementUnitId": "$managementUnitId", '
        '"managementUnitName": "$managementUnitName"}';
  }

  static Role _fromStringToRole(String roleStr) {
    roleStr = roleStr.toUpperCase();
    switch(roleStr) {
      case "ADMIN":
        return Role.ADMIN;
      case "MANAGER":
        return Role.MANAGER;
      case "EMPLOYEE":
        return Role.EMPLOYEE;
      default:
        return Role.EMPLOYEE;
    }
  }
}

enum Role {
  ADMIN,
  MANAGER,
  EMPLOYEE
}

