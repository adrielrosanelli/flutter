import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logica/screen/tela.dart';


class BoasVindas extends StatelessWidget {
  String _nome, _sobrenome;
  BoasVindas(this._nome, this._sobrenome);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset('lib/assets/avatar.png', scale: 20,),
          title:Text('$_nome $_sobrenome'),
           actions: <Widget>[
            IconButton(
              icon:Icon(Icons.arrow_back_ios),tooltip: 'Sair',
              onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Apresentacao()));

            } 
            ),
            
            
          ],
          
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
