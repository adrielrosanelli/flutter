import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logica/component/appController.dart';
import 'package:logica/component/camera.dart';

import 'package:logica/screen/tela.dart';

class BoasVindas extends StatefulWidget {

  String _nome, _sobrenome;
  BoasVindas(this._nome, this._sobrenome);


  @override
  _BoasVindasState createState() => _BoasVindasState();
}

class _BoasVindasState extends State<BoasVindas> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            'lib/assets/avatar.png',
            scale: 20,
          ),
          title: Text('${widget._nome} ${widget._sobrenome}'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (AppController.instance.isDartTheme == false) {
                  AppController.instance.changeTheme();
                } else if (AppController.instance.isDartTheme != false) {
                  AppController.instance.changeTheme();
                }
              },
              child: Icon(
                Icons.brightness_medium,
                color: Colors.white,
              ),
            ),
            IconButton(
                icon: Icon(Icons.logout),
                tooltip: 'Sair',
                onPressed: () {
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: new Text('Deseja Continuar?'),
                      content: new Text('Tem certeza que deseja Sair?'),
                      actions: [
                        new FloatingActionButton(
                          child: new Text('Sair'),
                          onPressed:(){
                            Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Apresentacao()));
                          }
                        )
                      ]
                    );
                  });
                  
                }),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              CameraScreen(),
              
            ],
          ),
        ));
  }
}