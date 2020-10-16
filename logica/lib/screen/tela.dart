import 'package:flutter/material.dart';
import 'package:logica/component/entradaDados.dart';


class Apresentacao extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: const EdgeInsets.only(top:10),
          child:Image.network('https://miro.medium.com/max/1000/1*ilC2Aqp5sZd1wi0CopD1Hw.png', scale: 10,)),
          
          Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Text('Efetue o Login',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                    )),
              ),
          EntradaDados(
            
          )
        ]
      )
    );
  }
}