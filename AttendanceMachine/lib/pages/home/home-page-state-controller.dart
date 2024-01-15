import 'dart:io';

import 'package:attendancemachine/models/api-response.dart';
import 'package:attendancemachine/models/attendance-machine.dart';
import 'package:attendancemachine/services/attendance-machine-service.dart';
import 'package:attendancemachine/services/attendance_log_queue_service.dart';
import 'package:attendancemachine/services/attendance_result_queue_service.dart';
import 'package:attendancemachine/services/queue_service.dart';
import 'package:attendancemachine/utils/devices-info.dart';
import 'package:attendancemachine/utils/logger.dart';
import 'package:camera/camera.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import '../../models/attendance_result.dart';
import 'home-page.dart';

class HomePageStateController {
  HomePageStateController({required this.state}) {}

  //<editor-fold desc="Private Properties">
  CameraController? controller;
  XFile? imageFile;
  XFile? videoFile;
  VideoPlayerController? videoController;
  VoidCallback? videoPlayerListener;
  bool enableAudio = true;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  late AnimationController _flashModeControlRowAnimationController;
  late Animation<double> _flashModeControlRowAnimation;

  double get minAvailableExposureOffset => _minAvailableExposureOffset;
  late AnimationController _exposureModeControlRowAnimationController;
  late Animation<double> _exposureModeControlRowAnimation;
  late AnimationController _focusModeControlRowAnimationController;
  late Animation<double> _focusModeControlRowAnimation;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

  //</editor-fold>

  //<editor-fold desc="Public Properties">
  double get maxAvailableExposureOffset => _maxAvailableExposureOffset;

  double get currentExposureOffset => _currentExposureOffset;

  AnimationController get flashModeControlRowAnimationController =>
      _flashModeControlRowAnimationController;

  Animation<double> get flashModeControlRowAnimation =>
      _flashModeControlRowAnimation;

  AnimationController get exposureModeControlRowAnimationController =>
      _exposureModeControlRowAnimationController;

  Animation<double> get exposureModeControlRowAnimation =>
      _exposureModeControlRowAnimation;

  AnimationController get focusModeControlRowAnimationController =>
      _focusModeControlRowAnimationController;

  Animation<double> get focusModeControlRowAnimation =>
      _focusModeControlRowAnimation;

  double get minAvailableZoom => _minAvailableZoom;

  double get maxAvailableZoom => _maxAvailableZoom;

  double get currentScale => _currentScale;

  double get baseScale => _baseScale;

  int get pointers => _pointers;

  void set pointers(int value) => _pointers = value;

  //</editor-fold>

  HomePageState state;
  AttendanceLogQueueService logQueueService = AttendanceLogQueueService();
  AttendanceResultQueueService resultQueueService = AttendanceResultQueueService();
  bool isCaptureBtnEnabled = false;
  bool isLogViewEnabled = false;
  List<String> logs = [];

  void initState(HomePageState state) async {
    this.state = state;

    _flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: state,
    );
    _flashModeControlRowAnimation = CurvedAnimation(
      parent: _flashModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
    _exposureModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: state,
    );
    _exposureModeControlRowAnimation = CurvedAnimation(
      parent: _exposureModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
    _focusModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: state,
    );
    _focusModeControlRowAnimation = CurvedAnimation(
      parent: _focusModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );

    startFrontCamera();

    String deviceId = "658197a0e52ed43386469ea6";
    String deviceCode = DevicesInfo.info.deviceId;

    final result = await AttendanceMachineService.instance.addMachine(deviceCode);

    if(result.status == ApiStatus.SUCCESS){
      deviceId = result.data!.id;
    }
    else{
      showInSnackBar("Đăng ký máy chấm công thất bại, vui lòng chạy lại ứng dụng.");
      return;
    }

    resultQueueService.listen(deviceId, (AttendanceResult result) async {
      String message = "Đã chấm công";
      if (result.status != "success") {
        message = "[${result.time}]: Chấm công thất bại! (status: ${result.status})";
      }
      else
      {
        message = "[${result.time}] ${result.name} (${result.employeeCode}): Đã chấm công.";
      };
      logs.add(message);
      state.setState(() {});
    }).then((value) => {
      isLogViewEnabled = true,
      state.setState(() {})
    });

    logQueueService.setup(deviceId).then((value) => {
      isCaptureBtnEnabled = true,
      state.setState(() {})
    });

  }

  void dispose() {
    _flashModeControlRowAnimationController.dispose();
    _exposureModeControlRowAnimationController.dispose();
    _focusModeControlRowAnimationController.dispose();

    logQueueService.dispose();
    resultQueueService.dispose();
  }

  Future<void> startFrontCamera() async {
    for (var camDescription in DevicesInfo.info.cameras) {
      if (camDescription.lensDirection == CameraLensDirection.front) {
        await onNewCameraSelected(camDescription);
        break;
      }
    }
  }

  void handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      return controller!.setDescription(cameraDescription);
    } else {
      return _initializeCameraController(cameraDescription);
    }
  }

  Future<void> _initializeCameraController(CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (state.mounted) {
        state.setState(() {});
      }
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
                cameraController.getMinExposureOffset().then(
                    (double value) => _minAvailableExposureOffset = value),
                cameraController
                    .getMaxExposureOffset()
                    .then((double value) => _maxAvailableExposureOffset = value)
              ]
            : <Future<Object?>>[],
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }

    if (state.mounted) {
      state.setState(() {});
    }
  }

  void showInSnackBar(String message) {
    state.showInSnackBar(message);
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void _logError(String code, String? message) {
    // ignore: avoid_print
    Logger.log(
        'Error: $code${message == null ? '' : '\nError Message: $message'}');
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> takeAttendance() async{
    isCaptureBtnEnabled = false;
    state.setState(() {});
    await controller?.prepareForVideoRecording();
    bool isComplete = true;
    int failRetry = 5;
    List<Uint8List> images = [];
    for(int i = 0; i < 5; i++){
      XFile? file = await takePicture();
      if(file == null){
        if(failRetry > 0) {
          failRetry--;
          continue;
        }
        else{
          isComplete = false;
          break;
        }
      }
      final image = await File(file.path).readAsBytes();
      images.add(image);
      await Future.delayed(const Duration(milliseconds: 200));
    }
    if (isComplete == false) {
      final now = DateTime.now();
      final time = "${now.day > 9 ? '' : '0'}${now.day}/${now.month > 9 ? '' : '0'}${now.month}/${now.year}"
          "${now.hour > 9 ? '' : '0'}${now.hour}:${now.minute > 9 ? '' : '0'}${now.minute}:${now.second > 9 ? '' : '0'}${now.second}";
      logs.add("[$time]: Chấm công thất bại! Làm ơn ghi hình lại.");
    }
    else{
      logQueueService.publish(images);
    }
    isCaptureBtnEnabled = true;
    state.setState(() {});
  }
}
