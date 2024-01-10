import 'dart:convert';

import 'package:mobilemanager/models/api-response.dart';
import 'package:http/http.dart' as http;
import 'package:mobilemanager/services/authentication-service.dart';

import '../models/user.dart';
import '../utils/resources.dart' as resources;

class UserService {
  static final UserService instance = UserService();
  static const String URL = resources.USER_URL;

  Future<ApiResponse<User>> getUser(String id) async {
    try {
      var response = await http.get(
        Uri.parse('$URL/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        var unicodeJsonStr = utf8.decode(response.bodyBytes);
        return ApiResponse.success(User.fromJson(unicodeJsonStr));
      } else {
        var msg = '';
        if (response.statusCode == 400) {
          msg = response.body;
        } else if (response.statusCode == 404) {
          msg = response.body;
        } else if (response.statusCode == 500) {
          msg = 'Lỗi hệ thống';
        }
        return ApiResponse<User>.error(msg);
      }
    } catch (e) {
      return ApiResponse<User>.error('Get user failed with error: ${e.toString()}');
    }
  }

  Future<ApiResponse<User>> getUserByUsername(String username) async {
    try {
      var response = await http.get(
        Uri.parse('${resources.GET_USER_BY_USERNAME_URL}/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        var unicodeJsonStr = utf8.decode(response.bodyBytes);
        var result = User.fromJson(unicodeJsonStr);
        return ApiResponse.success(result);
      } else {
        var msg = '';
        if (response.statusCode == 400) {
          msg = response.body;
        } else if (response.statusCode == 404) {
          msg = response.body;
        } else if (response.statusCode == 500) {
          msg = 'Lỗi hệ thống';
        }
        return ApiResponse<User>.error(msg);
      }
    } catch (e) {
      return ApiResponse<User>.error('Get user failed with error: ${e.toString()}');
    }
  }

  Future<ApiResponse<User>> getCurrentUserInfo() async {
    if(await AuthenticationService.instance.isAuthenticated()){
      var userId = (await AuthenticationService.instance.getLoginInfo())!.userId;
      var response = await getUser(userId);
      return response;
    }
    else {
      return ApiResponse<User>.unauthorized('Người dùng chưa đăng nhập');
    }
  }
}