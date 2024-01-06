import 'package:attendancemachine/models/api-response.dart';
import 'package:attendancemachine/utils/logger.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class AttendanceLogService {
  static final AttendanceLogService instance = AttendanceLogService();

  AttendanceLogService(){}
  static const URL = "http://localhost:8080/api/attendance-log";
  Future<ApiResponse<void>> pushAttendanceLog(XFile file, String deviceCode, String password) async {
    try{
      var rep = await http.post(Uri.parse(URL), body: {
        "deviceCode": deviceCode,
        "password": password,
        "image": file
      });
      if(rep.statusCode == 200){
        return ApiResponse.success(null);
      }else{
        return ApiResponse.error(rep.body);
      }
    }catch(e){
      return ApiResponse.error(e.toString());
    }
  }
}