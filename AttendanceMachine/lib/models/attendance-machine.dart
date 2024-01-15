import 'dart:convert';

import 'base-entity.dart';

class AttendanceMachine extends BaseEntity {
  String? managementUnitId;
  String code;
  String name;
  String? managementUnitName;

  AttendanceMachine({
    required super.id,
    required this.code,
    required this.name,
    this.managementUnitId,
    this.managementUnitName,
  });

  factory AttendanceMachine.fromJson(String json) {
    var jsonMap = jsonDecode(json);
    return AttendanceMachine.fromJsonMap(jsonMap);
  }

  factory AttendanceMachine.fromJsonMap(dynamic jsonMap) {
    return AttendanceMachine(
      id: jsonMap['id'] ?? '',
      managementUnitId: jsonMap['managementUnitId'],
      code: jsonMap['code'] ?? '',
      name: jsonMap['name'] ?? '',
      managementUnitName: jsonMap['managementUnitName'],
    );
  }

  String toJson() {
    return '{"id": "$id", '
        '"managementUnitId": "$managementUnitId", '
        '"code": "$code", '
        '"name": "$name"'
        '}';
  }
}
