import 'package:mobilemanager/utils/devices-info.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'machine-qr-scan-state-controller.dart';

class MachineQrScan extends StatefulWidget {
  const MachineQrScan({Key? key}) : super(key: key);

  @override
  State<MachineQrScan> createState() => MachineQrScanState();
}

class MachineQrScanState extends State<MachineQrScan>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  MachineQrScanState() {
    controller = MachineQrScanStateController(state: this);
  }

  late MachineQrScanStateController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller.initState(this);
    controller.startQRScan();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async {
    controller.takePhoto();
  }

  @override
  Widget build(BuildContext context) {
    var camController = controller.controller;
    const blackCurtainHeight = 2; // 2/10
    const blackCurtainWidth = 18; // 9/10
    const blackCurtainTopBottom = (10 - blackCurtainHeight) ~/ 2;
    const blackCurtainLeftRight = (20 - blackCurtainWidth) ~/ 2;
    final blackCurtainColor = Colors.black.withOpacity(0.5);

    return Scaffold(
      appBar: AppBar(title: const Text("Quét QR Máy chấm công")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Visibility(
                      visible: true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: camController != null &&
                                    camController!.value.isRecordingVideo
                                ? Colors.redAccent
                                : Colors.grey,
                            width: 3.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Center(
                            child: _cameraPreviewWidget(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _blackCurTain(height: 2, totalHeight: 10, width: 18, totalWidth: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20.0, bottom: 20, left: 20, right: 20),
              child: FilledButton(
                onPressed: _takePhoto,
                child: const Text('Quét QR'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blackCurTain({required int height, required int totalHeight,
    required int width, required int totalWidth}) {
    final blackCurtainTopBottom = (totalHeight - height) ~/ 2;
    final blackCurtainLeftRight = (totalWidth - width) ~/ 2;
    final blackCurtainColor = Colors.black.withOpacity(0.5);

    return Row(
      children: [
        Expanded(
            flex: blackCurtainLeftRight,
            child: Container(
              color: blackCurtainColor,
            )),
        Expanded(
          flex: width,
          child: Column(
            children: [
              Expanded(
                  flex: blackCurtainTopBottom,
                  child: Container(
                    color: blackCurtainColor,
                  )),
              Expanded(
                flex: height,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                  flex: blackCurtainTopBottom,
                  child: Container(
                    color: blackCurtainColor,
                  )),
            ],
          ),
        ),
        Expanded(
            flex: blackCurtainLeftRight,
            child: Container(
              color: blackCurtainColor,
            )),
      ],
    );
  }

  Widget _cameraPreviewWidget() {
    var cameraController = controller.controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Mở camera lên',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => controller.pointers++,
        onPointerUp: (_) => controller.pointers--,
        child: CameraPreview(
          cameraController,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: controller.handleScaleStart,
              onScaleUpdate: controller.handleScaleUpdate,
              onTapDown: (TapDownDetails details) =>
                  controller.onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
