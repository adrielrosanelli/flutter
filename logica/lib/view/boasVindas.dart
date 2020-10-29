import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logica/component/appController.dart';
import 'package:logica/model/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BoasVindas extends StatefulWidget {
  
  @override
  _BoasVindasState createState() => _BoasVindasState();
}

class _BoasVindasState extends State<BoasVindas> {
  UserModel user = UserModel();
  var email;
  // get_image
  String image;
  File _image;
  String fonte;

  // _lauchURL
  String minhaUrl;
  
  @override
  void initState() {
    valores();
    super.initState();
  }

  Future valores()async{
      email = user.read();
    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
      email = user.email;
        
      });
    } );
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

      });
    } else {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;

      });
    }
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
 Future _write(String text) async {
    SharedPreferences pref = await _prefs;
    pref.setStringList('text', ['', '']);
  }

  // AppBar
  Widget appBar(context) {
    return AppBar(
      title: AutoSizeText(
        '$email',
        minFontSize: 10,
        maxFontSize: 80,
        maxLines: 1,
        style: TextStyle(
          fontSize: 80,
        ),
      ),
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
  Widget body() {
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
  Widget drawer() {
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
                  AutoSizeText(
                    '${user.email}',
                    minFontSize: 5,
                    maxFontSize: 15,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 80,
                    ),
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
                  setState(() {
                  _write('');
                  });

                  Navigator.pushNamed(context, '/');
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

  Widget bottomNavigationBar(){
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      );
      
  }
  @override
  Widget build(BuildContext context) {
    return scafold();
  }

  Widget scafold(){
    return Scaffold(
      drawer: drawer(),
      appBar: appBar(context),
      body: body(),
      bottomNavigationBar: bottomNavigationBar(),
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
