import 'package:flutter/material.dart';
import 'package:logica/component/entradaDados.dart';
import 'package:logica/model/usuario.dart';
import 'package:logica/view/boasVindas.dart';
import 'package:logica/view/tela.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  UserModel user = UserModel();

  GlobalKey qrKey = GlobalKey();
  String qrText = "";

  QRViewController controller;

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
                Text('Nome: ${user.email}'),
                Text('Sobrenome: ${user.senha}'),
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
        user.email = teste[0];
        user.senha = teste[1];

        if (teste[0] != null && teste[1] != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BoasVindas()));
        } else {
          print('reprovou no teste');
        }
      });
    });
  }
}
