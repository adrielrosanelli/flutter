import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  GlobalKey qrKey = GlobalKey();
  String qrText = "";

  QRViewController controller;
  String _nome;
  String _sobrenome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Column(children: [
      SizedBox(
        width: 600,
        height: 500,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                  key: qrKey,
                  overlay: QrScannerOverlayShape(
                      borderRadius: 10,
                      borderColor: Colors.red,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 300),
                  onQRViewCreated: _onQRViewCreate),
            ),
            Text('Scan result: $qrText'),
            Text('Nome: $_nome'),
            Text('Sobrenome: $_sobrenome'),
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

        var teste = qrText.split(" ");
        print(teste);
        _nome = teste[0];
        _sobrenome = teste[1];

        if(teste[0] != null && teste[1] != null){
          print('Antes do sobrenome $_sobrenome');
        
        print('depois do sobrenome');
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => BoasVindas(_nome, _sobrenome)));

        }else{
          print('reprovou no teste');
        }

        
      });
    });
  }
}
