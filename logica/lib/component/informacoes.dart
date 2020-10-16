import 'package:flutter/material.dart';
class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final formkey = GlobalKey <FormState> ();
  String _nome = '', _sobrenome = '';


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
            key:formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Digite seu nome',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person),
                ),
                onSaved: (input) => _nome = input,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Sobrenome',
                  hintText: 'Digite seu sobrenome',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person),
                ),
                onSaved: (input) => _sobrenome = input,
              ),
        FloatingActionButton(
            onPressed: _submit,
            tooltip: 'Enviar',
            child: (Icon(Icons.send)))])
            
          ),
    );
  }
    void _submit(){
    formkey.currentState.save();
    print(_nome);
    print(_sobrenome);

  }
}