import 'package:flutter/material.dart';
import 'package:login_app/ui/services/auth.dart';
import 'package:login_app/ui/widgets/original_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final myController = TextEditingController();
  final AuthBase authBase = AuthBase();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text(widget.title)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),

    );
  }

  void markUnlogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
  }
}
