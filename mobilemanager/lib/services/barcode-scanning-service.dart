import 'package:camera/camera.dart';
import 'package:flutter/painting.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

/// Barcode detected handler
/// [barcode] is the detected barcode
/// return true to continue scanning, false to stop scanning
typedef BarcodeDetectedHandler = bool Function(String barcode);

class BarcodeScanningService {
  BarcodeScanningService() {
    scanner = configureBarcodeScanner();
  }

  BarcodeScanningService.fromCamera(
      CameraController camController, BarcodeDetectedHandler handler) {
    scanner = configureBarcodeScanner();
    cameraController = camController;
    cameraController!.startImageStream((image) async {
      var inputImage = InputImage.fromBytes(
        bytes: image.planes[0].bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: InputImageRotation.rotation0deg,
          format: toInputImageFormat(image.format),
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );
      var result = await processImage(scanner, inputImage);
      if(result != ''){
        if(!handler(result)){
          cameraController!.stopImageStream();
        }
      }
    });
  }

  late BarcodeScanner scanner;
  CameraController? cameraController;

  InputImageFormat toInputImageFormat(ImageFormat format) {
    switch (format.group) {
      case ImageFormatGroup.nv21:
        return InputImageFormat.nv21;
      case ImageFormatGroup.yuv420:
        return InputImageFormat.yuv420;
      case ImageFormatGroup.jpeg:
        return InputImageFormat.yuv_420_888;
      case ImageFormatGroup.bgra8888:
        return InputImageFormat.bgra8888;
      case ImageFormatGroup.unknown:
        throw Exception('Unknown ImageFormatGroup');
    }
  }

  String textFromImage(ImageChunkEvent imageChunkEvent) {
    var inputImage = InputImage.fromFilePath(imageChunkEvent.toString());
    var result = processImage(scanner, inputImage);
    return result.toString();
  }

  BarcodeScanner configureBarcodeScanner() {
    var options = [BarcodeFormat.code128];
    var scanner = GoogleMlKit.vision.barcodeScanner(options);
    return scanner;
  }

  Future<String> processImage(
      BarcodeScanner scanner, InputImage inputImage) async {
    var results = await scanner.processImage(inputImage);
    var resultText = '';
    if(results.isNotEmpty){
      for (Barcode barcode in results) {
        final BarcodeType type = barcode.type;
        var value = barcode.displayValue;
        // switch (type) {
        //   case BarcodeType.wifi:
        //     //  # TODO: Handle this case.
        //     break;
        //   case BarcodeType.url:
        //     // # TODO: Handle this case.
        //     break;
        //   case BarcodeType.unknown:
        //     // # TODO: Handle this case.
        //     break;
        //   case BarcodeType.contactInfo:
        //     // TODO: Handle this case.
        //   case BarcodeType.email:
        //     // TODO: Handle this case.
        //   case BarcodeType.isbn:
        //     // TODO: Handle this case.
        //   case BarcodeType.phone:
        //     // TODO: Handle this case.
        //   case BarcodeType.product:
        //     // TODO: Handle this case.
        //   case BarcodeType.sms:
        //     // TODO: Handle this case.
        //   case BarcodeType.text:
        //     // TODO: Handle this case.
        //   case BarcodeType.geoCoordinates:
        //     // TODO: Handle this case.
        //   case BarcodeType.calendarEvent:
        //     // TODO: Handle this case.
        //   case BarcodeType.driverLicense:
        //     // TODO: Handle this case.
        // }
        if (value != null && value != '') {
          return value;
        }
      }
    }
    return resultText;
  }
}
