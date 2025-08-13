import 'package:aplikasi_catatan/components/app_bar.dart';
import 'package:flutter/material.dart';

class WriteNote extends StatefulWidget {
  const WriteNote({super.key});

  @override
  State<WriteNote> createState() => _WriteNoteState();
}

class _WriteNoteState extends State<WriteNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.simple('back'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: TextField(
          //controller: ,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Mulai tulis ...",
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ), 
          child: const Icon(Icons.more_horiz,)
        )
      ),
    );
  }
}