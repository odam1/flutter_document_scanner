import 'dart:io' show Platform;

import 'package:document_scanner/src/scanner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 

class DocumentScannerCameraView extends StatefulWidget {
  final DocumentScannerController controller; 

  // final bool documentAnimation;
  // final String overlayColor;
  // final int detectionCountBeforeCapture;
  // final int detectionRefreshRateInMS;
  // final bool enableTorch;
  // final bool useFrontCam;
  // final double brightness;
  // final double saturation;
  // final double contrast;
  // final double quality;
  // final bool useBase64;
  // final bool saveInAppDocument;
  // final bool captureMultiple;
  // final bool manualOnly;
  // final bool noGrayScale;

  DocumentScannerCameraView({
    Key? key,
    required this.controller, 
    // this.documentAnimation,
    // this.overlayColor,
    // this.detectionCountBeforeCapture,
    // this.detectionRefreshRateInMS,
    // this.enableTorch,
    // this.useFrontCam,
    // this.brightness,
    // this.saturation,
    // this.contrast,
    // this.quality,
    // this.useBase64,
    // this.saveInAppDocument,
    // this.captureMultiple,
    // this.manualOnly,
    // this.noGrayScale,
  }) : super(key: key); 

  @override
  _DocumentScannerCameraViewState createState() => _DocumentScannerCameraViewState();
}

class _DocumentScannerCameraViewState extends State<DocumentScannerCameraView> {
  @override
  void initState() { 
    super.initState();
  }


  Map<String, dynamic> _getParams() {
    // Map<String, dynamic> allParams = {
    //   "documentAnimation": widget.documentAnimation,
    //   "overlayColor": widget.overlayColor,
    //   "detectionCountBeforeCapture": widget.detectionCountBeforeCapture,
    //   "enableTorch": widget.enableTorch,
    //   "manualOnly": widget.manualOnly,
    //   "noGrayScale": widget.noGrayScale,
    //   "brightness": widget.brightness,
    //   "contrast": widget.contrast,
    //   "saturation": widget.saturation,
    // };

    // Map<String, dynamic> nonNullParams = {};
    // allParams.forEach((key, value) {
    //   if (value != null) {
    //     nonNullParams.addAll({key: value});
    //   }
    // });

    // return nonNullParams;
    return {};
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        key: UniqueKey(),
        viewType: DocumentScannerController.methodChannelIdentifier ,
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: _getParams(),
        onPlatformViewCreated: widget.controller.onPlatformViewCreated,
      );
    } else if (Platform.isIOS) { 
      return UiKitView(
        key: UniqueKey(),
        viewType: DocumentScannerController.methodChannelIdentifier,
        creationParams: _getParams(),
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: widget.controller.onPlatformViewCreated,
      );
    } else {
      throw ("Current Platform is not supported");
    }
  }
}
