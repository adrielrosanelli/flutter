import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logica/model/usuario.dart';

class EntradaDados extends StatefulWidget {
  @override
  _EntradaDadosState createState() => _EntradaDadosState();
}

class _EntradaDadosState extends State<EntradaDados> {
  UserModel user = UserModel();
  final formkey = GlobalKey<FormState>();
  var _obscureText = true;
  bool _checkBox = false;

  Future loginAutomatico() async {
    Future.delayed(Duration(seconds: 3), () {
      user.email.isNotEmpty && user.senha.isNotEmpty
          ? Navigator.pushNamed(context, '/home')
          : print('Usuario ou senha invalido(s)');
    });
  }

  @override
  void initState() {
    user.read();
    loginAutomatico();
    super.initState();
  }

  // Envia as informações de login

  @override
  Widget build(BuildContext context) {
          return  _container();
  }

  Widget _container() {
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
                          user.email = value;
                        });
                      },
                      onSaved: (input) {
                        user.email = input;
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
                        formkey.currentState.save();
                        user.doLogin();
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        user.senha = value;
                      });
                    },
                    onSaved: (input) => user.senha = input,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: FlatButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, '/cadastro');
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
                                    user.write('${user.email} ${user.senha}');
                                    user.read();
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
                        onPressed: () async {
                          if (formkey.currentState.validate()) {
                            formkey.currentState.save();
                            await user.doLogin();
                            await Navigator.pushNamed(context, '/home');
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
              ])),
    );
  }


}
