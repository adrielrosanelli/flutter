import 'package:flutter/material.dart';
import 'package:logica/component/appController.dart';
import 'package:logica/screen/cadastroUsuario.dart';
import './screen/tela.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutterado',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: AppController.instance.isDartTheme
                ? Brightness.dark
                : Brightness.light,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Apresentacao(),
          initialRoute: '/',
          routes: {
            // '/': (context)=> Apresentacao(),
            // '/home': (context)=> BoasVindas('oi','ola'),
          },
        
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Center(
          child: Column(
            children: <Widget>[],
          ),
        ));
  }
}
