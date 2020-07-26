
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/note.dart';
import 'package:login_app/ui/screens/add_note_screen.dart';

class NotesListView extends StatelessWidget {
  final uid;
  NotesListView(this.uid);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('users').document(uid).collection('notes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        if (snapshot.data.documents==null) return CircularProgressIndicator();
        int notesCount = snapshot.data.documents.length;
        return ListView.builder(
          itemCount: notesCount,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data.documents[index];
            final note = Note.fromJson(document.data);
            return ListTile(
                title: Text( note.title),
                subtitle: Text(note.subTitle ?? ""),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddNoteScreen(uid, note))),
            );
        },);
      }
    );
  }
}
