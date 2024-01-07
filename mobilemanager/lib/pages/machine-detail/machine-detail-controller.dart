import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilemanager/models/api-response.dart';
import 'package:mobilemanager/models/attendance-machine.dart';
import 'package:mobilemanager/pages/machine-detail/machine-detail.dart';
import 'package:mobilemanager/services/attendance-machine-service.dart';
import 'package:mobilemanager/services/authentication-service.dart';

import '../routes.dart';

class MachineDetailController {
  final MachineDetailState state;
  MachineDetailController({required this.state});

  bool nameIsEditing = false;
  String name = "";
  AttendanceMachine? machine;
  bool isDisabled = true;
  bool isLinkingWithUnit = true;
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();

  void initState() async {
    final result = await AttendanceMachineService.instance.getMachine(state.widget.machineId);
    final loginInfo = await AuthenticationService.instance.getLoginInfo();
    if(result.status == Status.SUCCESS){
      machine = result.data;
      name = machine!.name;
      isLinkingWithUnit = machine!.managementUnitId != null && machine!.managementUnitId!.isNotEmpty;
      isDisabled = loginInfo == null ||
          isLinkingWithUnit && loginInfo.managementUnitId != machine!.managementUnitId;
      if(state.mounted){
        state.setState(() {
        });
      }
    }
    else if(result.status == Status.UNAUTHORIZED){
      if(state.mounted){
        GoRouter.of(state.context).go(RouteUrls.LOGIN_URL);
      }
    }
    else{
      state.showInSnackBar(result.message);
    }
    nameController.text = name;
  }

  void dispose() {
    nameController.dispose();
  }

  void updateName() {
    nameIsEditing = !nameIsEditing;
    if(nameIsEditing){
      nameController.text = name;
      FocusScope.of(state.context).requestFocus(nameFocusNode);
    }
    else{
      machine!.name = nameController.text;
      AttendanceMachineService.instance.updateMachine(machine!)
      .then((value) {
        if(value.status == Status.SUCCESS){
          state.setState(() {
            name = nameController.text;
          });
        }
        else{
          nameController.text = name;
          machine!.name = name;
          state.showInSnackBar(value.message);
        }
      });
    }
  }

  void linkWithUnit() {
    isLinkingWithUnit = true;
    state.setState(() {
    });
    // var machine = state.widget.machine;
    // machine.isLinkingWithUnit = isLinkingWithUnit;
    // AttendanceMachineService.instance.updateMachine(machine)
    // .then((value) {
    //   if(value.status == Status.SUCCESS){
    //     state.setState(() {
    //       isLinkingWithUnit = machine.isLinkingWithUnit;
    //     });
    //   }
    //   else{
    //     machine.isLinkingWithUnit = isLinkingWithUnit;
    //     state.showInSnackBar(value.message);
    //   }
    // });
  }

  void unlinkWithUnit() {
    isLinkingWithUnit = false;
    state.setState(() {
    });
  }
}