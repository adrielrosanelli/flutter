import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logica/component/appController.dart';
import 'package:logica/component/entradaDados.dart';
import 'package:logica/component/qrCode.dart';

class Apresentacao extends StatefulWidget {
  @override
  _ApresentacaoState createState() => _ApresentacaoState();
}

class _ApresentacaoState extends State<Apresentacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(100, 100, 100, 0),
            elevation: 0,
            leading: FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => QrCode()));
            }, child: Icon(Icons.qr_code)),
            actions: [
              FlatButton(
                  onPressed: () {
                    if (AppController.instance.isDartTheme == false) {
                      AppController.instance.changeTheme();
                    } else if(AppController.instance.isDartTheme != false){
                      AppController.instance.changeTheme();
                    }
                  },
                  child: Icon(Icons.brightness_medium)),
            ]),
        body: Container(
          child: SingleChildScrollView(
                      child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top:70),
                  child: 
                  EntradaDados()
                  ,)
                  ]),
          ),
        ));
  }
}
