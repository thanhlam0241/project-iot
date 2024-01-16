import 'package:mobilemanager/models/attendance-machine.dart';
import 'package:mobilemanager/pages/home/home-page-state-controller.dart';
import 'package:mobilemanager/utils/devices-info.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../machine-detail/machine-detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomePageState() {
    controller = HomePageStateController(state: this);
  }

  late HomePageStateController controller;

  @override
  void initState() {
    super.initState();
    controller.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return indexWidget(context);
  }

  Widget indexWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.primary,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        )
      ),
      drawer: drawerWidget(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.navigateToMachineQrScan,
        tooltip: 'Quét QR',
        label: const Text('Quét QR'),
        icon: const Icon(Icons.qr_code_scanner),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   margin: const EdgeInsets.only(
            //       top: 20.0, bottom: 20, left: 20, right: 20),
            //   child: FilledButton(
            //     onPressed: controller.navigateToMachineQrScan,
            //     child: const Text('Chấm công'),
            //   ),
            // ),
            controller.machines.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: controller.machines.length,
                itemBuilder: (context, index) {
                  return machineInfoItem(
                      machine: controller.machines[index]);
                },
              ),
            )
                : Container(
              margin: const EdgeInsets.only(
                  top: 60.0, bottom: 20, left: 20, right: 20),
              child: const Text('Không có máy chấm công nào'),
            ),
          ],
        ),
      ),
    );
  }

  Widget machineInfoItem({required AttendanceMachine machine}) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 6),
      child: Material(
        child: ListTile(
          shape: RoundedRectangleBorder( //<-- SEE HERE
            side: const BorderSide(
                color: Color(0xfff5f5f5),
                width: 1.0,
                style: BorderStyle.solid),

            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(machine.name),
          subtitle: Text('ID: ${machine.code}'),
          tileColor: const Color(0xfff9f9f9),
          trailing: const Icon(Icons.more_vert),
          leading: CircleAvatar(
            backgroundColor: _getColorFromStatus(machine),
            child: Text(
              machine.name.isNotEmpty ? machine.name.substring(0, 1) : '_',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          onTap: () => controller.selectMachine(machine),
        ),
      ),
    );
  }

  Widget drawerWidget(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Đăng xuất'),
            onTap: () {
              controller.logout();
            },
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Color _getColorFromStatus(AttendanceMachine attendanceMachine) {
    // if(attendanceMachine.managementUnitId != null && attendanceMachine.code.isNotEmpty){
    //   return Colors.green;
    // }
    if(attendanceMachine.name.isEmpty){
      return Colors.grey;
    }
    var firstChar = attendanceMachine.name.toLowerCase().substring(0, 1);
    var num = firstChar.codeUnitAt(0) - ' '.codeUnits[0];
    var color = Colors.primaries[num % Colors.primaries.length];
    return color;
  }
}
