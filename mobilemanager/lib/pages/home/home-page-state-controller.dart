import 'package:flutter/material.dart';
import 'package:mobilemanager/models/add-machine-response.dart';
import 'package:mobilemanager/services/attendance-machine-service.dart';
import 'package:mobilemanager/utils/devices-info.dart';
import 'package:mobilemanager/utils/logger.dart';
import 'package:camera/camera.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import '../machine-qr-scan/machine-qr-scan.dart';
import 'home-page.dart';

class HomePageStateController {
  HomePageStateController({required this.state}) {}

  HomePageState state;

  //<editor-fold desc="Private Properties">

  //<end editor-fold>

  //<editor-fold desc="Public Properties">
  String qrResult = 'no result';
  //</editor-fold>

  //<editor-fold desc="Private Methods">

  //</editor-fold>

  //<editor-fold desc="Public Methods">
  void initState() {

  }

  void dispose() {

  }

  void navigateToMachineQrScan() async {
    var result = await Navigator.push<AddMachineResponse?>(
      state.context,
      MaterialPageRoute(builder: (context) => const MachineQrScan()),
    );

    if (result != null) {
      if (result.state == AddMachineState.SUCCESS) {
        state.showInSnackBar('Thêm máy chấm công thành công');
        if(state.mounted){
          state.setState(() {
            qrResult = result.deviceCode!;
          });
        }
      } else {
        state.showInSnackBar('Thêm máy chấm công thất bại');
      }
    }
    else{
      state.showInSnackBar('Bạn chưa thực hiện hành động thêm máy chấm công');
    }
  }
}
