import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/ui/screens/home_page.dart';
import 'package:login_app/ui/widgets/original_button.dart';

class UserInfoScreen extends StatefulWidget {
  String uid;
  UserInfoScreen(this.uid);
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();


  String _name;
  int _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20   ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) => value.isEmpty ? "Required value" : null,
                    decoration: InputDecoration(hintText: 'Enter Your Name'),
                    onChanged: (value) => _name = value,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) => int.parse(value, onError: (e)=>null) == null ? "Enter Valid Age" : null,
                    decoration: InputDecoration(hintText: 'Enter Your Age'),
                    onChanged: (value) => _age = int.parse(value),
                  ),
                  SizedBox(height: 10,),
                  OriginalButton(
                    text: 'Save',textColor: Colors.white, bgColor: Colors.blue,
                    onPressed:(){
                      if(_formKey.currentState.validate())
                        {
                          User user = User(widget.uid,name: _name, age: _age);
                          Firestore.instance.collection('users').document(widget.uid).setData(user.toJson());
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(uid: widget.uid,),));
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
