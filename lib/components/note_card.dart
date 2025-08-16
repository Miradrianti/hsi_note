import 'package:aplikasi_catatan/model/note.dart';
import 'package:flutter/material.dart';

class NotesCard extends StatefulWidget {
  final void Function(Note)? onTap;

  const NotesCard({
    super.key,
    this.onTap,
  });

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  List<Note> notes = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: notes.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Belum ada catatan tersimpan',
                style: TextStyle(
                  fontSize: 16, 
                  color: Colors.grey
                )
              ),
            ),
          )
          : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), 
            separatorBuilder: (_,__) => const Divider(height: 1,), 
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => widget.onTap?.call(note),
              );
            },
          )
      )
    );
  }
}