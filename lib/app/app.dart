import 'package:aplikasi_catatan/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../view/home.dart';
import '../view/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HSI Notes',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state.status == LoginStatus.success) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
    );
  }
}
