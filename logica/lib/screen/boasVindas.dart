import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logica/component/appController.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:logica/screen/tela.dart';

class BoasVindas extends StatefulWidget {
  String _nome, _sobrenome;
  BoasVindas(this._nome, this._sobrenome);

  @override
  _BoasVindasState createState() => _BoasVindasState();
}

class _BoasVindasState extends State<BoasVindas> {
  // get_image
  String image;
  File _image;
  String fonte;

  // _lauchURL
  String minhaUrl;

  // _fireBaseMessaging
  final FirebaseMessaging _fireBaseMessaging = FirebaseMessaging();
  String _message = '';

  _registerOnFirebase() {
    _fireBaseMessaging.subscribeToTopic('all');
    _fireBaseMessaging.getToken().then((token) => print(token));
  }

// Inicia os metodos
  @override
  void initState() {
    _registerOnFirebase();
    getMessage();
    super.initState();
  }

  void getMessage() {
    _fireBaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('Mensagem Recebida');
      return;
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message['notification']['body']);
      return;
    }, onLaunch: (Map<String, dynamic> message) async {
      print('Ao lançar $message');
      setState(() => _message = message['notification']['body']);
      return;
    },);
  }

  // Permite a leitura de URL
  Future<void> _launchURL() async {
    var url = minhaUrl;

    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Busca a imagem na galeria ou tira a foto.
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
      child: ListView(
        primary: false,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Container(
              child: Center(
            child: Text("Mensagem = $_message"),
          ))
        ],
      ),
    );
  }

  // Drawer
  Widget _drawer() {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(7, 30, 10, 0),
            child: SizedBox(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text('Trocar a sua Foto?'),
                          actions: [
                            FlatButton(
                              child: Icon(Icons.image),
                              onPressed: () {
                                setState(() {
                                  fonte = 'gallery';
                                  getImage();
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                            FlatButton(
                              child: Icon(Icons.camera_alt),
                              onPressed: () {
                                setState(() {
                                  fonte = 'camera';
                                  getImage();
                                  Navigator.of(context).pop();
                                });
                              },
                            )
                          ],
                        );
                      });
                },
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: _image == null
                          ? NetworkImage('https://placeimg.com/640/480/any')
                          : FileImage(_image),
                      child: _image == null
                          ? Icon(Icons.add)
                          : Image.file(
                              _image,
                              color: Color.fromRGBO(1, 1, 1, 0),
                            ),
                    ),
                  ),
                  Text(
                    '${widget._nome} ${widget._sobrenome}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ]),
              ),
            ),
          ),
          Divider(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 10, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Apresentacao()));
                },
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.logout,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "Desconectar",
                    style: TextStyle(color: Colors.blue),
                  )
                ]),
              )),
          Divider(height: 10),
          Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 10, 0),
              child: GestureDetector(
                onTap: () {},
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.book,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "Pedidos",
                    style: TextStyle(color: Colors.blue),
                  )
                ]),
              ))
        ],
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
        onPressed: () => setState(() {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text('Sobre'),
                  content: Container(
                    height: 100,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              minhaUrl = "https://github.com/adrielrosanelli";
                              _launchURL();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('lib/assets/git.png'),
                                Text(
                                  '   Meu Perfil',
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              minhaUrl =
                                  "https://github.com/adrielrosanelli/flutter";
                              _launchURL();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('lib/assets/git.png'),
                                Text('   Repositório ')
                              ],
                            ),
                          ),
                        ]),
                  ),
                );
              });
        }),
        tooltip: 'Sobre',
        child: Icon(Icons.grade),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
