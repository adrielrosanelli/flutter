import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Seja Bem-Vindo',
                  style: TextStyle(
                    fontSize: 35,
                  )),              
          FlatButton(onPressed: (){

              }, child: Icon(Icons.camera_alt_outlined))
        ]
      )
      
    );
  }
}