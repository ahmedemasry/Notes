import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/note.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/ui/screens/add_note_screen.dart';
import 'package:login_app/ui/screens/auth_screen.dart';
import 'package:login_app/ui/services/auth.dart';
import 'package:login_app/ui/widgets/notes_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.uid}) : super(key: key);


  final String uid;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  final AuthBase authBase = AuthBase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.keyboard_return),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen(authType: AuthType.login,),));
              markUnlogged();
            },
          )
        ],
        title: StreamBuilder<Object>(
          stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
            // ignore: unnecessary_statements
            DocumentSnapshot documentSnapshot = snapshot.data;
            switch(snapshot.connectionState)
            {
              case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
              default: return Center(child: Text(documentSnapshot.data['name']),);

            }
            return Center(child: Text(snapshot.data));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNoteScreen(widget.uid, Note()),));
          },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
      body: Center(
        child: NotesListView(widget.uid),
      ),
    );
  }

  void markUnlogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
  }
}
