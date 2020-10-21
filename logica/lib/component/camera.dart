import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image;
  String fonte;

  Future getImage() async {
    if (fonte == 'gallery') {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print('_image: $_image');
      });
    } else {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        print('_image: $_image');
      });
    }
  }

  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(
        width: 600,
        height: 500,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(key: qrKey,
              overlay : QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: Colors.red,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300
              ),
               onQRViewCreated: _onQRViewCreate),
            ),
            Expanded(
                flex: 1,
                child: Center(
                  child: Text('Scan result: $qrText'),
                )),
            Text('Seja Bem-Vindo',
                style: TextStyle(
                  fontSize: 35,
                )),
          ],
        ),
      )
    ]));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }
}
