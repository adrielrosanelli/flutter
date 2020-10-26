import 'package:flutter/material.dart';
import 'package:logica/screen/tela.dart';
import 'package:flutter/services.dart';

class CadastroUsuario extends StatefulWidget {
  
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final formkey = GlobalKey<FormState>();

  String _nome ='', _email = '',_senha ='', _email2 ='';

  var _obscureText = true;

    void _submit() {
    formkey.currentState.save();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Apresentacao()));
    // Navigator.of(context).pushNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
              children: [
          Form(
            key:formkey,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20,90,20,8),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Qual seu nome?',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person)
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Digite um e-mail válido';
                  } else if (value.length < 3){
                    return 'Deve Conter mais de 2 letras';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onSaved:(input)=> _nome = input
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu E-mail',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.mail_outline)
              ),
              validator: (value){
                if(value.isEmpty){
                  return 'Digite Seu email';
                }else if (value.length < 10){
                  return 'Digite um e-mail válido';
                }
                return null;
              },
              onChanged:(input){
                setState(() {
              _email = input;
                  
                });
              } ,
              textInputAction:TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Repita o E-mail',
                  hintText: 'Digite o mesmo e-mail digitado acima',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.mail_outline)
              ),
              validator: (value){
                if(value != _email){
                  return 'Certifique-se de que digitou o E-mail corretamente';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 10),
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
                      onSaved: (input) => _senha = input,
                    ),
                  ),
                    FloatingActionButton(
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          _submit();
                        }
                      },
                      child: Icon(Icons.login))

          ],
        )),
      ]),
    );
  }
}