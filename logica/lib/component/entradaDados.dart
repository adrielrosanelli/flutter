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

    print(_nome);
    print(_sobrenome);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BoasVindas(_nome, _sobrenome)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: formkey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        _submit();
                      }
                    },
                    child: (Icon(Icons.send)),
                  ),
                )
              ])),
    );
  }
}
