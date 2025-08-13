import 'package:flutter/material.dart';

import '../view/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSI Notes',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}