import 'package:attendancemachine/components/barcode-view/BarcodeView.dart';
import 'package:attendancemachine/pages/home/home-page-state-controller.dart';
import 'package:attendancemachine/utils/devices-info.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  HomePageState() {
    controller = HomePageStateController(state: this);
  }

  late HomePageStateController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller.initState(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  Future<void> _capture() async {
    controller.takeAttendance();
  }

  @override
  Widget build(BuildContext context) {
    var deviceId = DevicesInfo.info.deviceId;

    var camController = controller.controller;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: true,
              child: Expanded(
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
            Container(
              margin: const EdgeInsets.only(
                  top: 20.0, bottom: 20, left: 20, right: 20),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(200, 50),
                  // padding: const EdgeInsets.all(12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: controller.isCaptureBtnEnabled ? _capture : null,
                child: controller.isCaptureBtnEnabled
                    ? const Text('Chấm công')
                    : const SizedBox(
                        width: 26,
                        height: 26,
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: BarcodeView(data: deviceId),
            ),
            Container(
              color: Colors.black,
              height: 200,
              child: ListView.builder(
                itemCount: controller.logs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Container(
                      color: Colors.black,
                      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 20, right: 20),
                      child: Text(
                        controller.logs[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
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
