import 'package:attendancemachine/services/attendance-log-service.dart';
import 'package:attendancemachine/services/queue_service.dart';
import 'package:attendancemachine/utils/devices-info.dart';
import 'package:attendancemachine/utils/logger.dart';
import 'package:camera/camera.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

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
  QueueExchanger queueExchanger = QueueExchanger();

  void initState(HomePageState state) {
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

    queueExchanger.init("queue.machineLog", ExchangeType.DIRECT);
    queueExchanger.publish("hello toi la linh");
  }

  void dispose() {
    _flashModeControlRowAnimationController.dispose();
    _exposureModeControlRowAnimationController.dispose();
    _focusModeControlRowAnimationController.dispose();

    queueExchanger.dispose();
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

  Future<void> takePhoto() async{
    var imageFile = await takePicture();
    var deviceId = DevicesInfo.info.deviceId;
    var password = DevicesInfo.info.passwordManufactory;

    if(imageFile != null){
      await AttendanceLogService.instance.pushAttendanceLog(imageFile, deviceId, password);
    }
    else{
      showInSnackBar("Chấm công thất bại: Không thể chụp ảnh");
    }
  }
}
