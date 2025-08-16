import 'package:aplikasi_catatan/components/regular_button.dart';
import 'package:aplikasi_catatan/components/regular_card.dart';
import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/components/regular_textfield.dart';
import 'package:aplikasi_catatan/logic/login_handler.dart';
import 'package:aplikasi_catatan/view/home.dart';
import 'package:aplikasi_catatan/view/register.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginHandler _authHandler = LoginHandler();

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final success = await _authHandler.login(email, password);

    if (success) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Berhasil')),
      );
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage()),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah')),
      );
    }                  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  RegularTextfield(
                    controller: _emailController,
                    maxLength: 50,
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
                    onPressed: (){
                      _handleLogin();
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
      ),
    );
  }
}