import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagem extends StatefulWidget {
  @override
  _ImagemState createState() => _ImagemState();
}

class _ImagemState extends State<Imagem> {
  File _image;
  String fonte;

  Future getImage() async {
    if (fonte == 'gallery') {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print('_image: $_image');
      });
    } else {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        print('_image: $_image');
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        
            children: [
          FlatButton(
            onPressed: (){
              getImage();
              fonte = "picture";
            },
            child: 
            Icon(Icons.camera_alt, color: Colors.pink[200])),
          FlatButton(
            onPressed: (){
              getImage();
              fonte = "gallery";
            },
            child: 
            Icon(Icons.image, color: Colors.purple)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:27.0),
            child: SizedBox(
              child: GestureDetector(
                onTap: getImage,
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.pink[50],
                  child: _image == null ? Icon(Icons.add) : Image.file(_image),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}