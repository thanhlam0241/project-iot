import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class BarcodeView extends StatelessWidget {
  const BarcodeView({Key? key, required this.data}) : super(key: key);

  final String data;

  String buildBarcode(
      Barcode bc,
      String data,
      {
        double? width,
        double? height,
        double? fontHeight
      }) {
    /// Create the Barcode
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    // Save the image as SVG string
    return svg;
  }

  @override
  Widget build(BuildContext context) {
    var svgXml = buildBarcode(Barcode.code128(), data);
    var svgPicture = SvgPicture.string(
      svgXml,
      width: 100,
      height: 100,
    );

    return svgPicture;
  }
}