import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_app/ui/widgets/auth_form.dart';

enum AuthType {login, register}

class AuthScreen extends StatelessWidget {
  final AuthType authType;
  const AuthScreen({Key key, this.authType}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.5,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(MediaQuery.of(context).size.height*.1),
                    bottomLeft: Radius.circular(MediaQuery.of(context).size.height*.1),
                  ),
//                  color:Colors.blue
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Hello!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight:FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Hero(
                      tag: 'logoAnimation',
                      child: Image.asset(
                        'assets/images/pc.png',
                        height: MediaQuery.of(context).size.height*.35,
                      ),
                    ),

                  ],
                ),
              ),
              AuthForm(authType: authType),
            ],
          ),
        )
    );
  }
}
