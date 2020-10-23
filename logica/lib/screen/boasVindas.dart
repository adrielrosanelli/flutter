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

// AppBar
  Widget _appBar(context) {
    return AppBar(
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: new Text('Deseja Continuar?'),
                        content: new Text('Tem certeza que deseja Sair?'),
                        actions: [
                          new FloatingActionButton(
                              child: new Text('Sair'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Apresentacao()));
                              })
                        ]);
                  });
            }),
      ],
    );
  }

// Body
  Widget _body() {
    return Center(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: FlatButton(
                onPressed: () {
                  fonte = "gallery";
                  getImage();
                  
                },
                child: Icon(
                  Icons.image,
                  size: 50,
                )),
            color: Color(0xfff18A86F),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: FlatButton(
                onPressed: () {
                  fonte = "picture";
                  getImage();
                },
                child: Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.white,
                )),
            color: Color(0xfff18A86F),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Sound of screams but the'),
            color: Color(0xfff18A86F),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Who scream'),
            color: Color(0xfff18A86F),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Revolution is coming...'),
            color: Color(0xfff18A86F),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Revolution, they...'),
            color: Color(0xfff18A86F),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Revolution is coming...'),
            color: Color(0xfff18A86F),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Revolution, they...'),
            color: Color(0xfff18A86F),
          ),
        ],
      ),
    );
  }
// Drawer
  Widget _drawer(){
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(7,30,10,0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
                          child: Row(
                children:[
                IconButton(icon: _image == null? Icon(Icons.people_outlined) : Image.file(_image, fit: BoxFit.fill,), onPressed: null),
                Text('${widget._nome} ${widget._sobrenome}')
                ] 
              ),
            ),
          )
        ]
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      appBar: _appBar(context),

      body: _body(),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
