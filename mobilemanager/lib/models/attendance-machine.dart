import 'dart:convert';

import 'base-entity.dart';

class AttendanceMachine extends BaseEntity {
  AttendanceMachine({
    required super.id,
    required this.managementUnitId,
    required this.code,
    required this.name,
  });

  factory AttendanceMachine.fromJson(String json) {
    var jsonMap = jsonDecode(json);
    return AttendanceMachine(
      id: jsonMap['id'],
      managementUnitId: jsonMap['managementUnitId'],
      code: jsonMap['code'],
      name: jsonMap['name'],
    );
  }

  String? managementUnitId;
  String code;
  String name;
}