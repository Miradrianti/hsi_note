import 'package:aplikasi_catatan/components/regular_button.dart';
import 'package:aplikasi_catatan/components/regular_card.dart';
import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/components/regular_textfield.dart';
import 'package:aplikasi_catatan/view/home.dart';
import 'package:aplikasi_catatan/view/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    maxLength: 50,
                    hintText: 'example@mail.com',),
                  SizedBox(height: 16,),
                  RegularText('Password'),
                  SizedBox(height: 8,),
                  RegularTextfield.pass(hintText: "********"),
                  SizedBox(height: 8,),
                  RegularText(''),
                  SizedBox(height: 40,),
                  RegularButton.filled(
                    'Login', 
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
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