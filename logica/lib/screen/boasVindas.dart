import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logica/component/appController.dart';

import 'package:logica/screen/tela.dart';

class BoasVindas extends StatefulWidget {

  String _nome, _sobrenome;
  BoasVindas(this._nome, this._sobrenome);


  @override
  _BoasVindasState createState() => _BoasVindasState();
}

class _BoasVindasState extends State<BoasVindas> {
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            child:
            _image == null ? Icon(Icons.add) : Image.file(_image),
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
          // TODO Criar grid com botões.
          child: GridView.count(
  primary: false,
  padding: const EdgeInsets.all(20),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  crossAxisCount: 2,
  children: <Widget>[
    Container(
      padding: const EdgeInsets.all(8),
      child: FlatButton(onPressed: (){
        getImage();
        fonte = "picture";
      },
        child: Icon(Icons.image, size: 50, color: Colors.white,)),
      color: Colors.blue,
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: FlatButton(onPressed: (){
        getImage();
        fonte = "gallery";
      },
        child: Icon(Icons.camera_alt, size: 50, color: Colors.white,)),
      color: Colors.blue,
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Sound of screams but the'),
      color: Colors.blue,
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Who scream'),
      color: Colors.blue,
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Revolution is coming...'),
      color: Colors.blue,
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Revolution, they...'),
      color: Colors.blue,
    ),
  ],
),
        ));
  }
}