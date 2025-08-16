import 'package:aplikasi_catatan/components/top_bar.dart';
import 'package:aplikasi_catatan/components/regular_button.dart';
import 'package:aplikasi_catatan/components/regular_card.dart';
import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/view/home.dart';
import 'package:aplikasi_catatan/view/login.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.simple('back'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RegularCard(
              children: [
                RegularText.title("Register"),
                SizedBox(height: 16,),
                RegularText.description('And start taking notes'),
                SizedBox(height: 32,),

                RegularText('Full Name'),
                SizedBox(height: 8,),
                // RegularTextfield(
                //   maxLength: 50,
                //   hintText: 'Example: John Doe',),
                SizedBox(height: 16,),

                RegularText('Email Adsress'),
                SizedBox(height: 8,),
                // RegularTextfield(
                //   maxLength: 50,
                //   hintText: 'Example: johndoe@gmail.com',),
                SizedBox(height: 16,),

                RegularText('Password'),
                SizedBox(height: 8,),
                // RegularTextfield.pass(hintText: "********"),
                
                SizedBox(height: 40,),
                RegularButton.filled(
                  'Register', 
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
                SizedBox(height: 16,),
                RegularButton.text(
                  'Don’t have any account? Login here', 
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
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
}