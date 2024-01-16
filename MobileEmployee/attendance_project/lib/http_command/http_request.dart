import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:test1/utils/resource.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser(String id) async {
  final response = await http.get(Uri.parse(Resource.BASE_URL + '/api/v1/user/' + id));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    const utf8Decoder = Utf8Decoder(allowMalformed: true);
    final decodedBytes = utf8Decoder.convert(response.bodyBytes);
    final decodedString = decodedBytes.toString();
    User user = User.fromJson(jsonDecode(decodedString) as Map<String, dynamic>);
    print(user.fullName);
    return user;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


Future<AuthenticationLogin?> fetchAuthenticationLogin(String username, String password) async {
  final response = await http.post(Uri.parse(Resource.BASE_URL + '/api/v1/auth/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
    'username': username,
    'password': password,
  }));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    const utf8Decoder = Utf8Decoder(allowMalformed: true);
    final decodedBytes = utf8Decoder.convert(response.bodyBytes);
    final decodedString = decodedBytes.toString();
    AuthenticationLogin authenticationLogin = AuthenticationLogin.fromJson(jsonDecode(decodedString) as Map<String, dynamic>);
    print(authenticationLogin.user!.id);
    //create a file and write the token to it
    // Create a file and write the token to it
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/token.xxx'); // Replace 'token.txt' with your desired file name
    await file.writeAsString(authenticationLogin.user!.id ?? '');

    print(authenticationLogin);


    return authenticationLogin;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return null;
  }
}

Future<LogSummary?> fetchLogSummary(String id, int startDay, int startMonth, int startYear,
    int endDay, int endMonth, int endYear) async {
  // final response = await http.get(Uri.parse('${Resource.BASE_URL}/api/v1/attendance/log/$id/day-between?startDay=$startDay&startMonth=$startMonth&startYear=$startYear&endDay=$endDay&endMonth=$endMonth&endYear=$endYear'));

  DateTime startDate = DateTime(startYear, startMonth, startDay);
  DateTime endDate = DateTime(endYear, endMonth, endDay);
  String startDateFormat = DateFormat('yyyy-MM-dd').format(startDate);
  String endDateFormat = DateFormat('yyyy-MM-dd').format(endDate);
  print(startDateFormat);
  print(endDateFormat);
  final response = await http.get(Uri.parse('${Resource.BASE_URL}/api/v1/attendance/statistic/$id/between?start=$startDateFormat&end=$endDateFormat'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    const utf8Decoder = Utf8Decoder(allowMalformed: true);
    final decodedBytes = utf8Decoder.convert(response.bodyBytes);
    final decodedString = decodedBytes.toString();
    LogSummary logSummary = LogSummary.fromJson(jsonDecode(decodedString) as Map<String, dynamic>);
    return logSummary;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Goi log summary fail");
    return null;
  }
}

Future<List<Log>?> fetchLog(String id, int startDay, int startMonth, int startYear,
    int endDay, int endMonth, int endYear) async {
  print('${Resource.BASE_URL}/api/v1/attendance/log/$id/day-between?startDay=$startDay&startMonth=$startMonth&startYear=$startYear&endDay=$endDay&endMonth=$endMonth&endYear=$endYear');
  final response = await http.get(Uri.parse('${Resource.BASE_URL}/api/v1/attendance/log/$id/day-between?startDay=$startDay&startMonth=$startMonth&startYear=$startYear&endDay=$endDay&endMonth=$endMonth&endYear=$endYear'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    const utf8Decoder = Utf8Decoder(allowMalformed: true);
    final decodedBytes = utf8Decoder.convert(response.bodyBytes);
    final decodedString = decodedBytes.toString();
    List<dynamic> list = jsonDecode(decodedString) as List<dynamic>;
    List<Log> logs = list.map((e) => Log.fromJson(e)).toList();
    print("Goi log");
    print(logs);
    return logs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return null;
  }
}


class AuthenticationLogin {
  String? token;
  User? user;

  AuthenticationLogin({this.token, this.user});

  AuthenticationLogin.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? fullName;
  String? code;
  String? role;
  bool? active;

  User(
      {this.id,
        this.username,
        this.fullName,
        this.code,
        this.role,
        this.active});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    code = json['code'];
    role = json['role'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['code'] = this.code;
    data['role'] = this.role;
    data['active'] = this.active;
    return data;
  }
}


class LogSummary {
  int? numberOfShifts;
  double? hourLate;

  LogSummary(
      {this.numberOfShifts,
        this.hourLate});

  LogSummary.fromJson(Map<String, dynamic> json) {
    numberOfShifts = json['numberOfShifts'];
    hourLate = json['numberMinutesLate']/60;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberOfShifts'] = numberOfShifts;
    data['hourLate'] = hourLate;
    return data;
  }
}

class Log {
  int? year;
  int? month;
  int? day;
  int? hour;
  String? shiftSessionName;
  String? logDate;
  String? logAttendance;
  double? shiftLate;
  String? colorView;


  Log(
      {this.year,
        this.month,
        this.day,
        this.hour,
        this.shiftSessionName,
        this.logDate,
        this.logAttendance,
        this.shiftLate});

  Log.fromJson(Map<String, dynamic> json) {
    var times = json['time'];
    year = times[0];
    month = times[1];
    day = times[2];
    hour = times[3];
    DateTime date = DateTime(year!, month!, day!);
    logDate = DateFormat('dd/MM/yyyy').format(date);
    if(hour! < 12){
      shiftSessionName = "Sáng";
    }else{
      shiftSessionName = "Chiều";
    }
    if(json['shift'] == "NONE"){
      logAttendance = "Không";
      colorView = "#FFF";
    }else{
      logAttendance = "Có";
      colorView = "#E87979";
    }
    shiftLate = json['minutesLate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    data['hour'] = hour;
    data['shiftSessionName'] = shiftSessionName;
    data['shiftLate'] = shiftLate;
    data['logDate'] = logDate;
    data['logAttendance'] = logAttendance;
    return data;
  }
}


