import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilemanager/models/add-machine-response.dart';
import 'package:mobilemanager/models/api-response.dart';
import 'package:mobilemanager/pages/routes.dart';
import 'package:mobilemanager/services/attendance-machine-service.dart';
import 'package:mobilemanager/services/authentication-service.dart';
import 'package:mobilemanager/utils/devices-info.dart';
import 'package:mobilemanager/utils/logger.dart';
import 'package:camera/camera.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import '../../models/attendance-machine.dart';
import '../machine-qr-scan/machine-qr-scan.dart';
import 'home-page.dart';

class HomePageStateController {
  HomePageStateController({required this.state}) {}

  HomePageState state;

  //<editor-fold desc="Private Properties">

  //<end editor-fold>

  //<editor-fold desc="Public Properties">
  String qrResult = 'no result';
  List<AttendanceMachine> machines = [];
  //</editor-fold>

  //<editor-fold desc="Private Methods">

  //</editor-fold>

  //<editor-fold desc="Public Methods">
  Future<void> initState() async {
    await refreshData();
  }

  void dispose() {

  }

  Future<void> refreshData() async {
    var result = await AttendanceMachineService.instance.getAll();
    if (result.status == Status.SUCCESS) {
      if(state.mounted){
        state.setState(() {
          machines = result.data!;
        });
      }
    }
    else if(result.status == Status.UNAUTHORIZED){
      if(state.mounted){
        GoRouter.of(state.context).go(RouteUrls.LOGIN_URL);
      }
    }
    else {
      if(state.mounted){
        state.showInSnackBar(result.message);
      }
    }
  }

  void navigateToMachineQrScan() async {
    var result = await GoRouter.of(state.context).push<AddMachineResponse?>(RouteUrls.MACHINE_QR_SCAN_URL);

    if (result == null) {
      state.showInSnackBar('Bạn chưa thực hiện hành động thêm máy chấm công');
      return;
    }
    if (result.state != AddMachineState.SUCCESS || result.deviceCode == null || result.deviceCode!.isEmpty) {
      state.showInSnackBar('Thêm máy chấm công thất bại, vui lòng quét lại');
      return;
    }

    var machineResult = await AttendanceMachineService.instance.addMachine(result.deviceCode!);
    if (machineResult.status == Status.SUCCESS) {
      selectMachine(machineResult.data!);
    }
    else if(machineResult.status == Status.UNAUTHORIZED){
      if(state.mounted){
        GoRouter.of(state.context).go(RouteUrls.LOGIN_URL);
      }
    }
    else {
      state.showInSnackBar(machineResult.message);
    }
  }

  void selectMachine(AttendanceMachine machine) {
    GoRouter.of(state.context).push(
        RouteUrls.MACHINE_DETAIL_URL.replaceFirst(':id', machine.id)
    ).then((value) => refreshData());
  }

  void logout() async {
    await AuthenticationService.instance.logout();
    if(state.mounted){
      GoRouter.of(state.context).go(RouteUrls.LOGIN_URL);
    }
  }
}
