import 'package:flutter/material.dart';


class BoasVindas extends StatelessWidget {
  String _nome, _sobrenome;
  BoasVindas(this._nome, this._sobrenome);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.person),
          title: Text('$_nome $_sobrenome'),
          centerTitle: true,
        ),
        body: Center(
          
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text('Seja Bem-Vindo',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ));
  }
}
