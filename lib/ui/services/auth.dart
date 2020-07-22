import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User{

  final String uid;

  User({@required this.uid});

}

class AuthBase {

  Future<void> registerUser(String username, String password) async
  {
    AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: username, password: password);
    return User(uid: authResult.user.uid);
  }

  Future<User> loginUser(String username, String password) async
  {
    AuthResult authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);
    if(authResult == null)
      return null;
    return User(uid: authResult.user.uid);
  }

  Future<void> logoutUser() async
  {
    await FirebaseAuth.instance.signOut();
  }

}