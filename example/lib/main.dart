import 'dart:io';

import 'package:flutter/material.dart';

import 'package:document_scanner/document_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File scannedDocument;
  Future<PermissionStatus> cameraPermissionFuture;

  ///
  DocumentScannerController controller;

  @override
  void initState() {
    super.initState();
    cameraPermissionFuture = Permission.camera.request();
    controller = DocumentScannerController();
    controller.addDocumentScannedListener((scannedImage) {
      print("document : " + scannedImage.croppedImage);

      setState(() {
        scannedDocument = scannedImage.getScannedDocumentAsFile();
        // imageLocation = image;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: FutureBuilder<PermissionStatus>(
            future: cameraPermissionFuture,
            builder: (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.isGranted)
                  return Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: scannedDocument != null
                                ? Image(
                                    image: FileImage(scannedDocument),
                                  )
                                : DocumentScannerCameraView(
                                    controller: this.controller,
                                  ),
                          ),
                        ],
                      ),
                      scannedDocument != null
                          ? Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: ElevatedButton(
                                  child: Text("retry"),
                                  onPressed: () {
                                    setState(() {
                                      scannedDocument = null;
                                    });
                                  }),
                            )
                          : Container(),
                    ],
                  );
                else
                  return Center(
                    child: Text("camera permission denied"),
                  );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
