import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logica/screen/boasVindas.dart';
import 'package:logica/screen/cadastroUsuario.dart';

class EntradaDados extends StatefulWidget {
  @override
  _EntradaDadosState createState() => _EntradaDadosState();
}

class _EntradaDadosState extends State<EntradaDados> {
  final formkey = GlobalKey<FormState>();
  String _nome = '', _sobrenome = '';
  var _obscureText = true;

  void _submit() {
    formkey.currentState.save();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => BoasVindas(_nome, _sobrenome)));
    // Navigator.of(context).pushNamed('/home');
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
                        onSaved: (input) {
                          _nome = input;
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
                      onSaved: (input) => _sobrenome = input,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CadastroUsuario()));
                          },
                          color: Colors.blue,
                          child: Text('Cadastrar-se', style: TextStyle(color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          _submit();
                        }
                      },
                      child: Icon(Icons.login))
                ])));
  }
}
