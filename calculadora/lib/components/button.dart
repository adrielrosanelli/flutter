import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const BLACK = Color.fromRGBO(82, 82, 82, 1);
  static const DEFAULT = Colors.grey;
  static const OPERATION = Colors.orange;

  final String text;
  final bool big;
  final Color color;
  final void Function(String) cb;

  Button({
    @required this.text,
    this.big = false,
    this.color = DEFAULT,
    @required this.cb
  });
  Button.big({
    @required this.text,
    this.big = true,
    this.color = DEFAULT,
    @required this.cb
  });
  Button.operation({
    @required this.text,
    this.big = false,
    this.color = OPERATION,
    @required this.cb
  });
  Button.black({
    @required this.text,
    this.big = false,
    this.color = BLACK,
    @required this.cb
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: RaisedButton(
        color: this.color,
        child: Text(text, style: TextStyle(
          color: Colors.white,
          fontSize: 35) ),
        onPressed: ()=>cb(text),
      ),
    );
  }
}