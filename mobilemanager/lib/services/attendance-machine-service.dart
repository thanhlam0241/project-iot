import 'package:mobilemanager/models/api-response.dart';
import 'package:mobilemanager/utils/logger.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:mobilemanager/utils/resources.dart' as resources;

class AttendanceMachineService {
  static final AttendanceMachineService instance = AttendanceMachineService();

  AttendanceMachineService(){}
  static const URL = resources.MACHINE_URL;

  Future<ApiResponse<String>> addMachine(String code, String name) async {
    var response = await http.post(
      Uri.parse(URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: '{"code": "$code", "name": "$name"}',
    );
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to add machine');
    }
  }
}