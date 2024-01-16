import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:test1/notification/notification_attendance.dart';

import '../../http_command/http_request.dart';
import '../../notification/websocket_service.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'attendance_model.dart';
export 'attendance_model.dart';

class AttendanceWidget extends StatefulWidget {
  const AttendanceWidget({Key? key}) : super(key: key);

  @override
  _AttendanceWidgetState createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget>
    with TickerProviderStateMixin {
  late AttendanceModel _model;
  String helloweek = "Hello Week";
  String hellomonth = "Hello Month";
  String id = "";
  int? WeekSessionSum;
  double? WeekLateSum;
  String? formattedWeekLateSum;
  String? formattedWeekSessionSum;

  int? MonthSessionSum;
  double? MonthLateSum;
  String? formattedMonthLateSum;
  String? formattedMonthSessionSum;
  List<Log>? logMonth;
  List<Log>? logWeek;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  Future<void> _loadData() async {
    await getApplicationDocumentsDirectory()
        .then((value) => File("${value.path}/token.xxx"))
        .then((value) => value.readAsString())
        .then((value) => {
              if (mounted)
                {
                  setState(() {
                    id = value;
                  })
                }
            });
    String firstDayWeekString = helloweek.substring(0, helloweek.indexOf("-"));
    String lastDayWeekString = helloweek.substring(helloweek.indexOf("-") + 1);
    List<String> firstDayList = firstDayWeekString.split("/");
    List<String> lastDayList = lastDayWeekString.split("/");
    int startDayWeek = int.parse(firstDayList[0]);
    int startMonthWeek = int.parse(firstDayList[1]);
    int startYearWeek = int.parse(firstDayList[2]);
    int endDayWeek = int.parse(lastDayList[0]);
    int endMonthWeek = int.parse(lastDayList[1]);
    int endYearWeek = int.parse(lastDayList[2]);
    fetchLogSummary(id, startDayWeek, startMonthWeek, startYearWeek, endDayWeek,
            endMonthWeek, endYearWeek)
        .then((value) => {
              setState(() {
                WeekSessionSum = value?.numberOfShifts;
                WeekSessionSum ??= 0;
                WeekLateSum = value?.hourLate;
                if (WeekLateSum != null) {
                  formattedWeekLateSum = WeekLateSum?.toStringAsFixed(2);
                }
              })
            });
    String firstDayMonthString = hellomonth.substring(0, hellomonth.indexOf("-"));
    String lastDayMonthString = hellomonth.substring(hellomonth.indexOf("-") + 1);
    List<String> firstDayMonthList = firstDayMonthString.split("/");
    List<String> lastDayMonthList = lastDayMonthString.split("/");
    int startDayMonth = int.parse(firstDayMonthList[0]);
    int startMonthMonth = int.parse(firstDayMonthList[1]);
    int startYearMonth = int.parse(firstDayMonthList[2]);
    int endDayMonth = int.parse(lastDayMonthList[0]);
    int endMonthMonth = int.parse(lastDayMonthList[1]);
    int endYearMonth = int.parse(lastDayMonthList[2]);
    fetchLogSummary(id, startDayMonth, startMonthMonth, startYearMonth, endDayMonth,
            endMonthMonth, endYearMonth)
        .then((value) => {
              setState(() {
                MonthSessionSum = value?.numberOfShifts;
                MonthSessionSum ??= 0;
                MonthLateSum = value?.hourLate;
                if (MonthLateSum != null) {
                  formattedMonthLateSum = MonthLateSum?.toStringAsFixed(2);
                }
              })
            });

    //Lay ban ghi cham cong tuan hien tai
    var logWeek = fetchLog(id, startDayWeek, startMonthWeek, startYearWeek,
        endDayWeek, endMonthWeek, endYearWeek);
    logWeek.then((value) => {
          if(value != null){
            setState(() {
              this.logWeek = value;
            })
          }
        });
    //Lay ban ghi cham cong thang hien tai
    var logMonth = fetchLog(id, startDayMonth, startMonthMonth, startYearMonth,
        endDayMonth, endMonthMonth, endYearMonth);
    logMonth.then((value) => {
          if(value != null){
            setState(() {
              this.logMonth = value;
            })
          }
        });
  }
  void refresh() {

    setState(() {
       helloweek = _model.WeekDateString;
       hellomonth = _model.MonthDateString;
      _loadData();
    });
  }

  void refreshNotification(String msg) {
    refresh();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendanceModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    setState(() {
      helloweek = _model.WeekDateString;
      hellomonth = _model.MonthDateString;
      _loadData();
    });
    WebSocketService.instance.addOnMessageCallback(refreshNotification);
  }

  @override
  void dispose() {
    _model.dispose();
    WebSocketService.instance.removeOnMessageCallback(refreshNotification);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          iconTheme: IconThemeData(color: FlutterFlowTheme.of(context).noColor),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 76.0,
                height: 54.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).noColor,
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    'Chấm công',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          fontSize: 24.0,
                        ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  // toprofile

                  context.pushNamed('profile');
                },
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/account_2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 4.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(0.0, 0),
                      child: TabBar(
                        labelColor: FlutterFlowTheme.of(context).primaryText,
                        unselectedLabelColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        labelStyle: FlutterFlowTheme.of(context).titleMedium,
                        unselectedLabelStyle: TextStyle(),
                        indicatorColor: FlutterFlowTheme.of(context).primary,
                        padding: EdgeInsets.all(4.0),
                        tabs: [
                          Tab(
                            text: 'Tuần',
                          ),
                          Tab(
                            text: 'Tháng',
                          ),
                        ],
                        controller: _model.tabBarController,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Thời gian thống kê',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                          Text(
                                            helloweek,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 100.0,
                                          height: 63.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .noColor,
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .noColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30.0,
                                        buttonSize: 40.0,
                                        icon: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 20.0,
                                        ),
                                        onPressed: () async {
                                          print('WeekBackButton pressed ...');
                                          // Back date of week date 1 week
                                          String currentDateWeek =
                                              _model.decreaseWeek(helloweek);

                                          String firstDayWeekString = currentDateWeek.substring(0, currentDateWeek.indexOf("-"));
                                          String lastDayWeekString = currentDateWeek.substring(currentDateWeek.indexOf("-") + 1);
                                          List<String> firstDayList = firstDayWeekString.split("/");
                                          List<String> lastDayList = lastDayWeekString.split("/");
                                          int startDayWeek = int.parse(firstDayList[0]);
                                          int startMonthWeek = int.parse(firstDayList[1]);
                                          int startYearWeek = int.parse(firstDayList[2]);
                                          int endDayWeek = int.parse(lastDayList[0]);
                                          int endMonthWeek = int.parse(lastDayList[1]);
                                          int endYearWeek = int.parse(lastDayList[2]);

                                          
                                          var logSummary = fetchLogSummary(
                                              id,
                                              startDayWeek,
                                              startMonthWeek,
                                              startYearWeek,
                                              endDayWeek,
                                              endMonthWeek,
                                              endYearWeek);
                                          logSummary.then((value) => {
                                                setState(() {
                                                  print("State tong");
                                                  WeekSessionSum =
                                                      value?.numberOfShifts;
                                                  WeekSessionSum ??= 0;
                                                  WeekLateSum = value?.hourLate;
                                                  if (WeekLateSum != null) {
                                                    formattedWeekLateSum =
                                                        WeekLateSum
                                                            ?.toStringAsFixed(
                                                                2);
                                                  }
                                                })
                                              });

                                          //Lay ban ghi cham cong tuan hien tai
                                          var logWeeks = await fetchLog(id, startDayWeek, startMonthWeek, startYearWeek,
                                              endDayWeek, endMonthWeek, endYearWeek);
                                          setState(() {
                                            helloweek = currentDateWeek;
                                            this.logWeek = logWeeks;
                                            print("State log week");
                                            print(this.logWeek);
                                          });
                                        },
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30.0,
                                        buttonSize: 40.0,
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 20.0,
                                        ),
                                        onPressed: () async {
                                          //print('WeekNextButton pressed ...');
                                          String currentWeek =
                                              _model.creaseWeek(helloweek);
                                          String firstDayWeekString = currentWeek.substring(0, currentWeek.indexOf("-"));
                                          String lastDayWeekString = currentWeek.substring(currentWeek.indexOf("-") + 1);
                                          List<String> firstDayList = firstDayWeekString.split("/");
                                          List<String> lastDayList = lastDayWeekString.split("/");
                                          int startDayWeek = int.parse(firstDayList[0]);
                                          int startMonthWeek = int.parse(firstDayList[1]);
                                          int startYearWeek = int.parse(firstDayList[2]);
                                          int endDayWeek = int.parse(lastDayList[0]);
                                          int endMonthWeek = int.parse(lastDayList[1]);
                                          int endYearWeek = int.parse(lastDayList[2]);

                                          var logSummary = fetchLogSummary(
                                              id,
                                              startDayWeek,
                                              startMonthWeek,
                                              startYearWeek,
                                              endDayWeek,
                                              endMonthWeek,
                                              endYearWeek);
logSummary.then((value) => {
                                                setState(() {
                                                  print("State tong");
                                                  WeekSessionSum =
                                                      value?.numberOfShifts;
                                                  WeekSessionSum ??= 0;
                                                  WeekLateSum = value?.hourLate;
                                                  if (WeekLateSum != null) {
                                                    formattedWeekLateSum =
                                                        WeekLateSum
                                                            ?.toStringAsFixed(
                                                                2);
                                                  }
                                                })
                                              });

                                          //Lay ban ghi cham cong tuan hien tai
                                          var logWeeks = await fetchLog(id, startDayWeek, startMonthWeek, startYearWeek,
                                              endDayWeek, endMonthWeek, endYearWeek);

                                          setState(() {
                                            helloweek = currentWeek;
                                            this.logWeek = logWeeks;
                                          });
                                          //Setup
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x25090F13),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Thống kê,',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium,
                                          ),
                                          Divider(
                                            height: 24.0,
                                            thickness: 2.0,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Text(
                                                                  'Số ca làm việc',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  WeekSessionSum
                                                                          .toString() ??
                                                                      "0",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Outfit',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Text(
                                                                  'Số giờ muộn',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  formattedWeekLateSum ??
                                                                      "0",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Outfit',
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 0.0, 0.0),
                                  child: Text(
                                    'Bản ghi chấm công',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                  ),
                                ),
                                // Generated code for this WeekListView Widget...
                                (logWeek != null && logWeek!.isNotEmpty)
                                    ? Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: logWeek!.length,
                                    itemBuilder: (BuildContext context,
                                        int logIndex) {
                                      final log = logWeek![logIndex];
                                      return machineInfoItem(log: log);
                                    },
                                  ),
                                )
                                    : Text('Không có dữ liệu'),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Thời gian thống kê',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                          Text(
                                            hellomonth,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 100.0,
                                          height: 63.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .noColor,
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .noColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30.0,
                                        buttonSize: 40.0,
                                        icon: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 20.0,
                                        ),
                                        onPressed: () async {

                                          String currentMonth = _model
                                              .decreaseMonth(hellomonth);
                                          String firstDayMonthString = currentMonth.substring(0, currentMonth.indexOf("-"));
                                          String lastDayMonthString = currentMonth.substring(currentMonth.indexOf("-") + 1);
                                          List<String> firstDayMonthList = firstDayMonthString.split("/");
                                          List<String> lastDayMonthList = lastDayMonthString.split("/");
                                          int startDayMonth = int.parse(firstDayMonthList[0]);
                                          int startMonthMonth = int.parse(firstDayMonthList[1]);
                                          int startYearMonth = int.parse(firstDayMonthList[2]);
                                          int endDayMonth = int.parse(lastDayMonthList[0]);
                                          int endMonthMonth = int.parse(lastDayMonthList[1]);
                                          int endYearMonth = int.parse(lastDayMonthList[2]);
                                          var logSummary = fetchLogSummary(
                                              id,
                                              startDayMonth,
                                              startMonthMonth,
                                              startYearMonth,
                                              endDayMonth,
                                              endMonthMonth,
                                              endYearMonth);
                                          logSummary.then((value) => {
                                                setState(() {
                                                  print("State tong");
                                                  MonthSessionSum =
                                                      value?.numberOfShifts;
                                                  MonthSessionSum ??= 0;
                                                  MonthLateSum = value?.hourLate;
                                                  if (MonthLateSum != null) {
                                                    formattedMonthLateSum =
                                                        MonthLateSum
                                                            ?.toStringAsFixed(
                                                                2);
                                                  }
                                                })
                                              });
                                          var logMonths = await fetchLog(id, startDayMonth, startMonthMonth, startYearMonth,
                                              endDayMonth, endMonthMonth, endYearMonth);
                                          setState(() {
                                            hellomonth = currentMonth;
                                            this.logMonth = logMonths;
                                          });
                                        },
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30.0,
                                        buttonSize: 40.0,
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 20.0,
                                        ),
                                        onPressed: () async {

                                          String currentMonth = _model
                                              .creaseMonth(hellomonth);
                                          String firstDayMonthString = currentMonth.substring(0, currentMonth.indexOf("-"));
                                          String lastDayMonthString = currentMonth.substring(currentMonth.indexOf("-") + 1);
                                          List<String> firstDayMonthList = firstDayMonthString.split("/");
                                          List<String> lastDayMonthList = lastDayMonthString.split("/");
                                          int startDayMonth = int.parse(firstDayMonthList[0]);
                                          int startMonthMonth = int.parse(firstDayMonthList[1]);
                                          int startYearMonth = int.parse(firstDayMonthList[2]);
                                          int endDayMonth = int.parse(lastDayMonthList[0]);
                                          int endMonthMonth = int.parse(lastDayMonthList[1]);
                                          int endYearMonth = int.parse(lastDayMonthList[2]);
                                          var logSummary = fetchLogSummary(
                                              id,
                                              startDayMonth,
                                              startMonthMonth,
                                              startYearMonth,
                                              endDayMonth,
                                              endMonthMonth,
                                              endYearMonth);
                                          logSummary.then((value) => {
                                                setState(() {
                                                  print("State tong");
                                                  MonthSessionSum =
                                                      value?.numberOfShifts;
                                                  MonthSessionSum ??= 0;
                                                  MonthLateSum = value?.hourLate;
                                                  if (MonthLateSum != null) {
                                                    formattedMonthLateSum =
                                                        MonthLateSum
                                                            ?.toStringAsFixed(
                                                                2);
                                                  }
                                                })
                                              });
                                          var logMonths = await fetchLog(id, startDayMonth, startMonthMonth, startYearMonth,
                                              endDayMonth, endMonthMonth, endYearMonth);
                                          setState(() {
                                            hellomonth = currentMonth;
                                            this.logMonth = logMonths;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x25090F13),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Thống kê,',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium,
                                          ),
                                          Divider(
                                            height: 24.0,
                                            thickness: 2.0,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Text(
                                                                  'Số ca làm việc',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  MonthSessionSum
                                                                          .toString() ??
                                                                      "0",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Outfit',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Text(
                                                                  'Số giờ muộn',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  formattedMonthLateSum ??
                                                                      "0",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Outfit',
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 0.0, 0.0),
                                  child: Text(
                                    'Bản ghi chấm công',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                  ),
                                ),
                                // Generated code for this WeekListView Widget...
                                // Generated code for this MonthListView Widget...
                                (logMonth != null && logMonth!.isNotEmpty)
                                    ? Expanded(
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          itemCount: logMonth!.length,
                                          itemBuilder: (BuildContext context,
                                              int logIndex) {
                                            final log = logMonth![logIndex];
                                            return machineInfoItem(log: log);
                                          },
                                        ),
                                      )
                                    : Text('Không có dữ liệu'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget machineInfoItem({required Log log}) {

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(log.colorView!.hashCode | 0xFF000000 & 0xFFFFFFFF ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x411D2429),
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 14),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        log.logDate!,
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Ca làm việc',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF217DC1),
                                ),
                          ),
                          Text(
                            log.shiftSessionName!,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Chấm công',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF217DC1),
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              log.logAttendance!,
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Text(
                              'Số phút muộn',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF217DC1),
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              log.shiftLate.toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
