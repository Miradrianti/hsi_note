import 'package:aplikasi_catatan/logic/login_handler.dart';
import 'package:aplikasi_catatan/view/home.dart';
import 'package:flutter/material.dart';

import '../view/login.dart';

class MyApp extends StatelessWidget {
  final LoginHandler _loginHandler = LoginHandler();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSI Notes',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data == true) {
            return HomePage();
          } else {
            return LoginPage();
          }
        }
      ),
      routes: {
        '/home' : (context) => HomePage(),
        '/login' : (context) => LoginPage(),
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    final user = await _loginHandler.getCurrentUser();
    return user != null;
  }
}