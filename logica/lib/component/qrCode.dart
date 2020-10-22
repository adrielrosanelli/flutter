import 'package:flutter/material.dart';
import 'package:logica/component/entradaDados.dart';
import 'package:logica/screen/boasVindas.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  GlobalKey qrKey = GlobalKey();
  String qrText = "";
  
  QRViewController controller;
  String _nome,_sobrenome;


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
            // Column(
            //   children: [
            //     RaisedButton(
            //       child: Text('Entrar'),
            //       color: Colors.purple,
            //       textColor: Colors.white,
            //       onPressed: () {
            //         setState(() {
            //         convertido();
                    
                      
            //         });
            //       },
            //     ),
            //   ],
            // ),
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
  _nome = teste[0];
  _sobrenome = teste[1];
  Navigator.pushReplacement(context,
MaterialPageRoute(builder: (context) => BoasVindas(_nome,_sobrenome)));

      });
    });
  }
}
