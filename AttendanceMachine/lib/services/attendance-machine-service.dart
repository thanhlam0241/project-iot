import 'dart:convert';
import 'dart:core';

import '../models/api-response.dart';
import '../models/attendance-machine.dart';
import '../utils/json-mapper.dart';
import '../utils/logger.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import '../utils/resources.dart' as resources;

class AttendanceMachineService {
  static final AttendanceMachineService instance = AttendanceMachineService();

  AttendanceMachineService() {}
  static const URL = resources.MACHINE_URL;

  Future<ApiResponse<AttendanceMachine>> addMachine(String code) async {
    try {
      var response = await http.patch(
        Uri.parse(URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: '{"code": "$code"}',
      );
      if (response.statusCode == 200) {
        var unicodeJsonString = utf8.decode(response.bodyBytes);
        return ApiResponse.success(
            AttendanceMachine.fromJson(unicodeJsonString));
      } else {
        var msg = "";
        if (response.statusCode == 400) {
          msg = response.body;
        } else if (response.statusCode == 404) {
          msg = response.body;
        } else if (response.statusCode == 500) {
          msg = "Lỗi hệ thống";
        }
        return ApiResponse<AttendanceMachine>.error(msg);
      }
    } catch (e) {
      return ApiResponse<AttendanceMachine>.error(
          'Add machine failed with error: ${e.toString()}');
    }
  }

  Future<ApiResponse<AttendanceMachine>> getMachine(String id) async {
    try {
      var response = await http.get(
        Uri.parse('$URL/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        var unicodeJsonString = utf8.decode(response.bodyBytes);
        return ApiResponse.success(
            AttendanceMachine.fromJson(unicodeJsonString));
      } else {
        var msg = "";
        if (response.statusCode == 400) {
          msg = response.body;
        } else if (response.statusCode == 404) {
          msg = response.body;
        } else if (response.statusCode == 500) {
          msg = "Lỗi hệ thống";
        }
        return ApiResponse<AttendanceMachine>.error(msg);
      }
    } catch (e) {
      return ApiResponse<AttendanceMachine>.error(
          'Get machine failed with error: ${e.toString()}');
    }
  }
}
