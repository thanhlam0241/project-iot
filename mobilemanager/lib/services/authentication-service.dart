import 'dart:convert';
import 'dart:io';

import 'package:mobilemanager/models/login-info.dart';
import 'package:http/http.dart' as http;
import 'package:mobilemanager/models/user.dart';
import 'package:mobilemanager/services/user-service.dart';
import 'package:path_provider/path_provider.dart';
import '../models/api-response.dart';
import '../utils/resources.dart' as resources;

class AuthenticationService {
  static final AuthenticationService instance = AuthenticationService();
  static const String URL = resources.AUTH_URL;
  static const String LOGIN_URL = resources.LOGIN_URL;

  AuthenticationService(){}

  LoginInfo? _currentLoginInfo;
  bool? _isLoginInfoSaved;

  Future<bool> isAuthenticated() async {
    if(_currentLoginInfo != null){
      return true;
    }

    if(_isLoginInfoSaved == null){
      _currentLoginInfo = await _getLoginInfoFromStorage();
      _isLoginInfoSaved = _currentLoginInfo != null;
    }

    return _currentLoginInfo != null;
  }

  Future<LoginInfo?> getLoginInfo() async {
    if(_currentLoginInfo != null){
      return _currentLoginInfo;
    }

    _currentLoginInfo = await _getLoginInfoFromStorage();
    _isLoginInfoSaved = _currentLoginInfo != null;
    return _currentLoginInfo;
  }

  Future<ApiResponse<LoginInfo>> login(String username, String password) async {
    try{
      var response = await http.post(
        Uri.parse(LOGIN_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: '{"username": "$username", "password": "$password"}',
      );

      var userReq = await UserService.instance.getUserByUsername(username);
      if(userReq.status != Status.SUCCESS){
        return ApiResponse<LoginInfo>.error(userReq.message);
      }
      else if(userReq.data!.role != Role.ADMIN && userReq.data!.role != Role.MANAGER){
        return ApiResponse.error("Chỉ quản lý mới có thể đăng nhập");
      }

      if(response.statusCode == 200){
        var token = jsonDecode(response.body)['token'];
        var loginInfo = LoginInfo(
            userId: userReq.data!.id,
            username: username,
            password: password,
            token: token,
            managementUnitId: userReq.data!.managementUnitId);
        _saveLoginInfoToStorage(loginInfo)
            .then((value) => _isLoginInfoSaved = true)
            .catchError((error) => _isLoginInfoSaved = false);
        _currentLoginInfo = loginInfo;
        return ApiResponse.success(loginInfo);
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
        return ApiResponse<LoginInfo>.error(msg);
      }
    }
    catch(e){
      return ApiResponse<LoginInfo>.error('Login failed with error: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    final directory = await getApplicationDocumentsDirectory();
    File file = File("${directory.path}/hello.xxx");
    if((await file.exists()) == true){
      await file.delete();
    }
    _currentLoginInfo = null;
    _isLoginInfoSaved = false;
  }

  Future<LoginInfo?> _getLoginInfoFromStorage() async{
    final directory = await getApplicationDocumentsDirectory();
    File file = File("${directory.path}/hello.xxx");
    if((await file.exists()) == false){
      return null;
    }
    var jsonStr = await file.readAsString();
    if(jsonStr.isNotEmpty){
      return LoginInfo.fromJson(jsonStr);
    }
    return null;
  }

  Future<void> _saveLoginInfoToStorage(LoginInfo loginInfo) async{
    final directory = await getApplicationDocumentsDirectory();
    File file = File("${directory.path}/hello.xxx");
    await file.writeAsString(loginInfo.toJson());
  }
}