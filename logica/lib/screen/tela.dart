import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logica/component/entradaDados.dart';

class Apresentacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                'lib/assets/flutter.png',
                scale: 10,
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text('Efetue o Login',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                )),
          ),
          EntradaDados()
        ]));
  }
}
