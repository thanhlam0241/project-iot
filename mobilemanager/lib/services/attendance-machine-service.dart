import 'dart:convert';
import 'dart:core';

import 'package:mobilemanager/models/api-response.dart';
import 'package:mobilemanager/models/attendance-machine.dart';
import 'package:mobilemanager/utils/json-mapper.dart';
import 'package:mobilemanager/utils/logger.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:mobilemanager/utils/resources.dart' as resources;

import 'authentication-service.dart';

class AttendanceMachineService {
  static final AttendanceMachineService instance = AttendanceMachineService();

  AttendanceMachineService(){}
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
        return ApiResponse
            .success(AttendanceMachine.fromJson(unicodeJsonString));
      } else {
        var msg = "";
        if (response.statusCode == 400) {
          msg = response.body;
        } else if (response.statusCode == 404) {
          msg = response.body;
        } else if (response.statusCode == 500) {
          msg = "Lỗi hệ thống";
        }
        return ApiResponse<AttendanceMachine>
            .error(msg);
      }
    }
    catch (e) {
      return ApiResponse<AttendanceMachine>
          .error('Add machine failed with error: ${e.toString()}');
    }
  }

  Future<ApiResponse<AttendanceMachine>> getMachine(String id) async {
    try{
      var response = await http.get(
        Uri.parse('$URL/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode == 200){
        var unicodeJsonString = utf8.decode(response.bodyBytes);
        return ApiResponse.success(AttendanceMachine.fromJson(unicodeJsonString));
      }
      else{
        var msg = "";
        if(response.statusCode == 400){
          msg = response.body;
        }
        else if(response.statusCode == 404){
          msg = response.body;
        }
        else if(response.statusCode == 500){
          msg = "Lỗi hệ thống";
        }
        return ApiResponse<AttendanceMachine>.error(msg);
      }
    }
    catch(e){
      return ApiResponse<AttendanceMachine>.error('Get machine failed with error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> updateMachine(AttendanceMachine machine) async {
    try{
      final requestBody = machine.toJson();
      var response = await http.put(
        Uri.parse('$URL/${machine.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );
      if(response.statusCode == 200){
        return ApiResponse.success(null);
      }
      else{
        var msg = "";
        if(response.statusCode == 400){
          msg = "Mã máy chấm công không hợp lệ";
        }
        else if(response.statusCode == 404){
          msg = "Mã máy chấm công không tồn tại";
        }
        else if(response.statusCode == 500){
          msg = "Lỗi hệ thống";
        }
        return ApiResponse<AttendanceMachine>.error(msg);
      }
    }
    catch(e){
      return ApiResponse<AttendanceMachine>.error('Update machine failed with error: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<AttendanceMachine>>> getAll() async {
    try{
      var loginInfo = await AuthenticationService.instance.getLoginInfo();
      var response = await http.get(
        Uri.parse(URL + (loginInfo == null? '' : '?managementUnitId=${loginInfo.managementUnitId}')),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode == 200){
        var unicodeJsonString = utf8.decode(response.bodyBytes);
        // var list = jsonDecode(unicodeJsonString);
        // for(var item in list){
        //   logger.d(item);
        // }
        List<AttendanceMachine> result = JsonMapper
            .parseList<AttendanceMachine>(unicodeJsonString, (e) => AttendanceMachine.fromJsonMap(e));
        return ApiResponse.success(result);
      }
      else{
        var msg = "";
        if(response.statusCode == 400){
          msg = response.body;
        }
        else if(response.statusCode == 404){
          msg = response.body;
        }
        else if(response.statusCode == 500){
          msg = "Lỗi hệ thống";
        }
        return ApiResponse<List<AttendanceMachine>>.error(msg);
      }
    }
    catch(e){
      return ApiResponse<List<AttendanceMachine>>.error('Get all machine failed with error: ${e.toString()}');
    }
  }

}