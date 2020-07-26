import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/user.dart';

class AuthUser{

  final String uid;

  AuthUser({@required this.uid});


}

class AuthBase {

  Future<User> registerUser(String username, String password) async
  {
    AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: username, password: password);
    return User(authResult.user.uid);
  }

  Future<User> loginUser(String username, String password) async
  {
    AuthResult authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);
    if(authResult == null)
      return null;
    return User(authResult.user.uid);
  }

  Future<void> logoutUser() async
  {
    await FirebaseAuth.instance.signOut();
  }

}