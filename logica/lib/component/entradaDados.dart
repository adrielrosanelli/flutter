import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logica/screen/boasVindas.dart';

class EntradaDados extends StatefulWidget {
  @override
  _EntradaDadosState createState() => _EntradaDadosState();
}

class _EntradaDadosState extends State<EntradaDados> {
  final formkey = GlobalKey<FormState>();
  String _nome = '', _sobrenome = '';

  void _submit() {
    formkey.currentState.save();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => BoasVindas(_nome, _sobrenome)));
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        child: Form(
            key: formkey,
            child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                    Image.asset(
                  'lib/assets/flutter.png',
                  scale: 10,
                ),
                    ]
                  ),
                  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text('Efetue o Login',
                          style: TextStyle(
                            fontSize: 30,
                          )),
                    ),
                  ],
                ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        hintText: 'Digite seu nome',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite seu nome';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (input) => _nome = input,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Sobrenome',
                        hintText: 'Digite seu sobrenome',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite seu Sobrenome';
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
                  FloatingActionButton(onPressed: (
                    
                  ){
                    if (formkey.currentState.validate()) {
                            _submit();
                          }},
                  child: Icon(Icons.login))
                ])));
  }
}
