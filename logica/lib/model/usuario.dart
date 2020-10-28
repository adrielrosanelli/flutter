import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String email;
  String senha;
  final formkey = GlobalKey<FormState>();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future write(String text) async {
    SharedPreferences pref = await _prefs;
    pref.setStringList('text', ['$email', '$senha']);
  }

  Future read() async {
    SharedPreferences pref = await _prefs;
    final login = pref.getStringList('text') ?? [];
    email = login[0];
    senha = login[1];
    print(email);
    print(senha);
  }

  Future<bool> doLogin() async {
    await Firebase.initializeApp();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
    } catch (e) {
      print(e.message);
    }
  }
}
