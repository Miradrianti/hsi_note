import 'package:aplikasi_catatan/bloc/login_bloc.dart';
import 'package:aplikasi_catatan/bloc/login_event.dart';
import 'package:aplikasi_catatan/components/regular_button.dart';
import 'package:aplikasi_catatan/components/regular_card.dart';
import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/components/regular_textfield.dart';
import 'package:aplikasi_catatan/view/home.dart';
import 'package:aplikasi_catatan/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_state.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Login gagal")),
            );
          }
        },
        builder: (context, state) {
          if (state.status == LoginStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
      
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RegularCard(
                    children: [
                      RegularText.title("Let's Login"),
                      SizedBox(height: 16,),
                      RegularText.description('And notes your idea'),
                      SizedBox(height: 32,),
                      RegularText('Email Address'),
                      SizedBox(height: 8,),
                      RegularTextfield.text(
                        controller: _emailController,
                        hintText: 'example@mail.com',),
                      SizedBox(height: 16,),
                      RegularText('Password'),
                      SizedBox(height: 8,),
                      RegularTextfield.pass(
                        controller: _passwordController,
                        hintText: "********"
                      ),
                      SizedBox(height: 8,),
                      RegularText(''),
                      SizedBox(height: 40,),
                      RegularButton.filled(
                        'Login', 
                        onPressed: () {
                          context.read<LoginBloc>().add(LoginSubmitted(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          ));
                        },
                      ),
                      SizedBox(height: 16,),
                      
                      RegularButton.text(
                        'Don’t have any account? Register here', 
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    )
  );
  }
}