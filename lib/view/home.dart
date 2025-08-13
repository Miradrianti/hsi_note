import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/view/write_note.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/icon1.png',
                width: 245,
                height: 219,
              ),
              RegularText.title('Start Your Journey'),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: RegularText.description2(
                    'Every big step start with small step. \n'
                    'Notes your first idea and start your journey!',
                ),
              ),
            ]
          ), 
        ),
      ),
      floatingActionButton:SafeArea(
        child: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WriteNote()),
            );
          },
          backgroundColor: Color.fromRGBO(57, 70, 117, 1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(80),
          ),
          child: const Icon(Icons.add, size: 30,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}