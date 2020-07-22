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
      body: Padding(
//        padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text('Sign out'),
              onPressed: () async {
                await authBase.logoutUser();
                Navigator.of(context).pushReplacementNamed('/login');
                markUnlogged();
              },
            ),
            SizedBox(height: 60,),
            Text(
              'You are the cutest girl,\nI have ever seen.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 40,),
            Text(
              'My Lovely Girl,',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
              ),
            ),
            Text(
              'Salsabeel',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
              ),
            ),
            SizedBox(height: 40,),

            Builder(
              builder: (BuildContext context) {
                return OriginalButton(
                  bgColor: Colors.lightBlue,
                  textColor: Colors.white,
                  text: 'click me',
                  onPressed: () {
                    final snack = SnackBar(content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('I Just Love You.  ',),
                        Icon(Icons.favorite),
                      ],
                    ),
                      backgroundColor: Colors.pink,
                      behavior: SnackBarBehavior.floating,
                    );

                    Scaffold.of(context).showSnackBar(snack);
                  },
                );
              },
            ),
            SizedBox(),
          ],
        ),
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
