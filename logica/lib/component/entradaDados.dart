import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logica/screen/boasVindas.dart';
import 'package:logica/screen/cadastroUsuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class EntradaDados extends StatefulWidget {
  @override
  _EntradaDadosState createState() => _EntradaDadosState();
}

class _EntradaDadosState extends State<EntradaDados> {
  final formkey = GlobalKey<FormState>();
  String email, senha;
  var _obscureText = true;
  bool _checkBox = false;
  var _recuperaValor;

  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/usuario.txt');
    await file.writeAsString(text);
  }

  Future<String> _read() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/usuario.txt');
      text = await file.readAsString();
      setState(() {
      _recuperaValor = text.split(" ");
        email = _recuperaValor[0].toString();
        senha = _recuperaValor[1].toString();
        print(email);
      print(senha);
        email.isNotEmpty && senha.isNotEmpty
            ? _submit()
            : print('Usuario ou senha invalido(s)');
      });

    } catch (e) {
      print("Couldn't read file");
    }

    return text;
  }

  @override
  void initState() {
    _read();
    super.initState();
  }

  // Envia as informações de login
  Future<void> _submit() async {
    await Firebase.initializeApp();
    formkey.currentState.save();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new BoasVindas(email)));
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Form(
            key: formkey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/assets/flutter.png',
                    scale: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text('Efetue o Login',
                        style: TextStyle(
                          fontSize: 30,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'Digite seu Email',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Digite um e-mail válido';
                          } else if (value.length < 3) {
                            return 'Deve conter mais de 2 letras';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        onSaved: (input) {
                          email = input;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Digite uma senha forte',
                        border: OutlineInputBorder(),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            )),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite uma senha válida';
                        }
                        return null;
                      },
                      onFieldSubmitted: (v) {
                        if (formkey.currentState.validate()) {
                          _submit();
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          senha = value;
                        });
                      },
                      onSaved: (input) => senha = input,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CadastroUsuario()));
                          },
                          child: Text(
                            'Cadastrar-se',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            Checkbox(
                                value: _checkBox,
                                onChanged: (value) {
                                  setState(() {
                                    _checkBox = !_checkBox;
                                    if (_checkBox == true) {
                                      _write('$email $senha');
                                      _read();
                                    }
                                  });
                                }),
                            Text('Lembrar senha')
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: () {
                            if (formkey.currentState.validate()) {
                              _submit();
                            }
                          },
                          child: Text('Entrar')),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        print('teste');
                      },
                      child: Text('Esqueci a senha'))
                ])));
  }
}
