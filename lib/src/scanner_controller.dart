import 'package:flutter/services.dart';

import 'scannedImage.dart';

class DocumentScannerController {
  /// platform chanel id
  static const String methodChannelIdentifier = 'camera_document_scanner';

  /// document scanned callback
  void Function(ScannedImage)? _onScannedDocument;

  /// platform communication channel
  MethodChannel? _channel;

  /// on platform view created
  void onPlatformViewCreated(int id) {
    print("Platform created $id");
    _channel = MethodChannel("$methodChannelIdentifier");
    _channel!.setMethodCallHandler(_onPlatformMessage);
  }

  /// handler for platform messages
  Future _onPlatformMessage(MethodCall call) async {
    print("New method call ${call.method}");
    if (call.method == "onPictureTaken") {
      Map<String, dynamic> argsAsMap = Map<String, dynamic>.from(call.arguments);

      ScannedImage? scannedImage = ScannedImage.fromMap(argsAsMap);
      _onScannedDocument?.call(scannedImage);
    }
  }

  /// add scanned document lsitener
  void addDocumentScannedListener(void Function(ScannedImage) onScannedDocument) {
    this._onScannedDocument = onScannedDocument;
  }

  /// function to take image
  void takePicture() {}

  /// dispose camera resources here
  void dispose() {}
}
