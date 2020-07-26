import 'package:cloud_firestore/cloud_firestore.dart';

import 'note.dart';

class User{
  final uid;
  String name;
  int age;
//  String profilePicture;
//  List<Note> _notes;

  User(this.uid, {this.name, this.age});

  User.fromJson(Map<String, dynamic> json, this.uid) {
    name = json['name'];
    age = json['age'];
  }
//  static Future<User> getUserFromDatabase(String uid) async {
//    User user;
//    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(uid).snapshots();
//    return User.fromJson(snapshot.data, uid);
//  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    return data;
  }
//
//
//  List<Note> get notes{
//    return _notes;
//  }
//  set notes(List<Note> notes){
//    _notes = _notes = notes;
//  }
//  addNote(Note note){
//    if(_notes == null)
//      _notes = new List<Note>();
//    _notes.add(note);
//  }
//  removeNote(Note note){
//    _notes.remove(note);
//  }

}

