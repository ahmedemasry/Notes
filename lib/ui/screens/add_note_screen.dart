import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/note.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/ui/screens/home_page.dart';
import 'package:login_app/ui/widgets/original_button.dart';

class AddNoteScreen extends StatefulWidget {
  String uid;
  Note note;
  AddNoteScreen(this.uid, this.note);
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();


  @override
  Widget build(BuildContext context) {
    title.text = widget.note.title;
    subtitle.text = widget.note.subTitle;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20   ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: title,
                  validator: (value) => value.isEmpty ? "Required value" : null,
                  decoration: InputDecoration(hintText: 'Enter Note Title'),
//                  onChanged: (value) => widget.note.title = value,
                  onChanged: (value) => widget.note.title = title.text,
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: subtitle,
                  decoration: InputDecoration(hintText: 'Description'),
//                  onChanged: (value) => _age = int.parse(value),
                  onChanged: (value) => widget.note.subTitle = subtitle.text,
                ),
                SizedBox(height: 10,),
                OriginalButton(
                    text: widget.note.title==null?"Add":"Save",textColor: Colors.white, bgColor: Colors.blue,
                    onPressed:(){
                      if(_formKey.currentState.validate())
                      {
                        Firestore.instance.collection('users').document(widget.uid).collection('notes').document(widget.note.id).setData(widget.note.toJson());
//                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(uid: widget.uid,),));
                      Navigator.pop(context);
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
