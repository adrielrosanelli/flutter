import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logica/component/appController.dart';
import 'package:logica/component/entradaDados.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:logica/screen/tela.dart';

class BoasVindas extends StatefulWidget {
  String nome, sobrenome;
  BoasVindas(this.nome, this.sobrenome);

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
  
  void main() async{
      final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/usuario.txt');
    file.deleteSync(recursive: true);
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
      // TODO Passar biblioteca que diminui a escrita para caber mais caracteres
      title: Text('${widget.nome} ${widget.sobrenome}'),
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
      ],
    );
  }

  // Body
  Widget _body() {
    return Center(
      child: Container(
        child: Container(
            child: Center(
          child: Text("Mensagem = Teste"),
        )),
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
                          ? NetworkImage('https://placeimg.com/640/480/people')
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
                    '${widget.nome} ${widget.sobrenome}',
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
                  main();
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Apresentacao()));
                //  Navigator.pushNamed(context, '/');
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
