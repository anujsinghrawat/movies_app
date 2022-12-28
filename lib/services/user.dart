import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/widgets/home.dart';
import 'package:movies_app/widgets/login_page.dart';

class User {
    static bool flag = false;
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      flag= true;
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginWidget()));
      flag = false;
    }
  }
}
