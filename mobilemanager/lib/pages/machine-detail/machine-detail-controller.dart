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

  void linkWithUnit() async {
    state.setState(() {
      isDisabled = true;
    });
    final loginInfo = await AuthenticationService.instance.getLoginInfo();
    isDisabled = false;
    if(loginInfo == null){
      state.showInSnackBar("Bạn cần đăng nhập để liên kết");
      if(state.mounted){
        state.setState(() {});
      }
      return;
    }
    if(machine == null){
      if(state.mounted){
        state.setState(() {});
      }
      return;
    }

    machine!.managementUnitId = loginInfo.managementUnitId;
    final result = await AttendanceMachineService.instance.updateMachine(machine!);
    if(result.status == Status.SUCCESS){
      isLinkingWithUnit = true;
    }
    else{
      machine!.managementUnitId = null;
      state.showInSnackBar(result.message);
    }

    if(state.mounted){
      state.setState(() {
        isDisabled = false;
      });
    }
  }

  void unlinkWithUnit() async {
    state.setState(() {
      isDisabled = true;
    });

    final loginInfo = await AuthenticationService.instance.getLoginInfo();
    isDisabled = false;
    if(loginInfo == null){
      state.showInSnackBar("Bạn cần đăng nhập để hủy liên kết");
      if(state.mounted){
        state.setState(() {});
      }
      return;
    }
    if(machine == null){
      if(state.mounted){
        state.setState(() {});
      }
      return;
    }

    machine!.managementUnitId = null;
    final result = await AttendanceMachineService.instance.updateMachine(machine!);
    if(result.status == Status.SUCCESS){
      isLinkingWithUnit = false;
    }
    else{
      machine!.managementUnitId = loginInfo.managementUnitId;
      state.showInSnackBar(result.message);
    }

    state.setState(() {
      isDisabled = false;
    });
  }
}