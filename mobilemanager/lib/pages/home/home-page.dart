import 'package:mobilemanager/models/attendance-machine.dart';
import 'package:mobilemanager/pages/home/home-page-state-controller.dart';
import 'package:mobilemanager/utils/devices-info.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomePageState(){
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20, left: 20, right: 20),
              child: FilledButton(
                onPressed: controller.navigateToMachineQrScan,
                child: const Text('Chấm công'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20, left: 20, right: 20),
              child: Text(controller.qrResult),
            ),
          ],
        ),
      ),
    );
  }

  Widget machineInfoItem({required AttendanceMachine machine}){
    return Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 20, left: 20, right: 20),
      child: Column(
        children: [
          Text(machine.name),
          Text(machine.code),
        ],
      ),
    );
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
