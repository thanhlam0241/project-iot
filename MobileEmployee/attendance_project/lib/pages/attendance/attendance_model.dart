import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'attendance_widget.dart' show AttendanceWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AttendanceModel extends FlutterFlowModel<AttendanceWidget> {
  ///  State fields for stateful widgets in this page.

  String WeekDateString  ="";
  DateTime firstDayOfTheWeek = DateTime.now();
  DateTime lastDayOfTheWeek = DateTime.now();

  String MonthDateString = "";
  DateTime firstDayOfTheMonth = DateTime.now();
  DateTime lastDayOfTheMonth = DateTime.now();

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    // Current week of system
    DateTime now = DateTime.now();
    firstDayOfTheWeek = now.subtract(Duration(days: now.weekday - 1));
    lastDayOfTheWeek = now
        .add(Duration(days: DateTime.daysPerWeek - now.weekday));
    //Format ""dd/MM/yyyy - dd/MM/yyyy""
    String firstDayOfTheWeekString = DateFormat('dd/MM/yyyy').format(firstDayOfTheWeek);
    String lastDayOfTheWeekString = DateFormat('dd/MM/yyyy').format(lastDayOfTheWeek);
    WeekDateString = "$firstDayOfTheWeekString - $lastDayOfTheWeekString";
    // Current month of system
    firstDayOfTheMonth = DateTime(now.year, now.month, 1);
    lastDayOfTheMonth = DateTime(now.year, now.month + 1, 0);
    String firstDayOfTheMonthString = DateFormat('dd/MM/yyyy').format(firstDayOfTheMonth);
    String lastDayOfTheMonthString = DateFormat('dd/MM/yyyy').format(lastDayOfTheMonth);
    MonthDateString = "$firstDayOfTheMonthString - $lastDayOfTheMonthString";

  }

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
  }

  /// Action blocks are added here.
  String creaseWeek(String weekDateString){
    String firstDayString = weekDateString.substring(0, weekDateString.indexOf("-"));
    String lastDayString = weekDateString.substring(weekDateString.indexOf("-") + 1);
    List<String> firstDayList = firstDayString.split("/");
    List<String> lastDayList = lastDayString.split("/");
    firstDayOfTheWeek = DateTime(int.parse(firstDayList[2]), int.parse(firstDayList[1]), int.parse(firstDayList[0]));
    lastDayOfTheWeek = DateTime(int.parse(lastDayList[2]), int.parse(lastDayList[1]), int.parse(lastDayList[0]));
    firstDayOfTheWeek = firstDayOfTheWeek.add(Duration(days: 7));
    lastDayOfTheWeek = lastDayOfTheWeek.add(Duration(days: 7));
    String firstDayOfTheWeekString = DateFormat('dd/MM/yyyy').format(firstDayOfTheWeek);
    String lastDayOfTheWeekString = DateFormat('dd/MM/yyyy').format(lastDayOfTheWeek);
    WeekDateString = "$firstDayOfTheWeekString - $lastDayOfTheWeekString";
    return WeekDateString;
  }
  String decreaseWeek(String weekDateString){
    String firstDayString = weekDateString.substring(0, weekDateString.indexOf("-"));
    String lastDayString = weekDateString.substring(weekDateString.indexOf("-") + 1);
    List<String> firstDayList = firstDayString.split("/");
    List<String> lastDayList = lastDayString.split("/");
    firstDayOfTheWeek = DateTime(int.parse(firstDayList[2]), int.parse(firstDayList[1]), int.parse(firstDayList[0]));
    lastDayOfTheWeek = DateTime(int.parse(lastDayList[2]), int.parse(lastDayList[1]), int.parse(lastDayList[0]));
    firstDayOfTheWeek = firstDayOfTheWeek.subtract(Duration(days: 7));
    lastDayOfTheWeek = lastDayOfTheWeek.subtract(Duration(days: 7));
    String firstDayOfTheWeekString = DateFormat('dd/MM/yyyy').format(firstDayOfTheWeek);
    String lastDayOfTheWeekString = DateFormat('dd/MM/yyyy').format(lastDayOfTheWeek);
    WeekDateString = "$firstDayOfTheWeekString - $lastDayOfTheWeekString";
    return WeekDateString;
  }

  String creaseMonth(String monthDateString ){
    String firstDayString = monthDateString.substring(0, monthDateString.indexOf("-"));
    String lastDayString = monthDateString.substring(monthDateString.indexOf("-") + 1);
    List<String> firstDayList = firstDayString.split("/");
    List<String> lastDayList = lastDayString.split("/");
    firstDayOfTheMonth = DateTime(int.parse(firstDayList[2]), int.parse(firstDayList[1]), int.parse(firstDayList[0]));
    lastDayOfTheMonth = DateTime(int.parse(lastDayList[2]), int.parse(lastDayList[1]), int.parse(lastDayList[0]));
    firstDayOfTheMonth = DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month + 1, 1);
    lastDayOfTheMonth = DateTime(lastDayOfTheMonth.year, lastDayOfTheMonth.month + 2, 0);
    String firstDayOfTheMonthString = DateFormat('dd/MM/yyyy').format(firstDayOfTheMonth);
    String lastDayOfTheMonthString = DateFormat('dd/MM/yyyy').format(lastDayOfTheMonth);
    MonthDateString = "$firstDayOfTheMonthString - $lastDayOfTheMonthString";
    return MonthDateString;
  }

  String decreaseMonth(String monthDateString ){
    String firstDayString = monthDateString.substring(0, monthDateString.indexOf("-"));
    String lastDayString = monthDateString.substring(monthDateString.indexOf("-") + 1);
    List<String> firstDayList = firstDayString.split("/");
    List<String> lastDayList = lastDayString.split("/");
    firstDayOfTheMonth = DateTime(int.parse(firstDayList[2]), int.parse(firstDayList[1]), int.parse(firstDayList[0]));
    lastDayOfTheMonth = DateTime(int.parse(lastDayList[2]), int.parse(lastDayList[1]), int.parse(lastDayList[0]));
    firstDayOfTheMonth = DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month - 1, 1);
    lastDayOfTheMonth = DateTime(lastDayOfTheMonth.year, lastDayOfTheMonth.month, 0);
    String firstDayOfTheMonthString = DateFormat('dd/MM/yyyy').format(firstDayOfTheMonth);
    String lastDayOfTheMonthString = DateFormat('dd/MM/yyyy').format(lastDayOfTheMonth);
    MonthDateString = "$firstDayOfTheMonthString - $lastDayOfTheMonthString";
    return MonthDateString;
  }

  /// Additional helper methods are added here.
}
