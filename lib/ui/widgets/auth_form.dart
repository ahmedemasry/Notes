import 'package:flutter/material.dart';
import 'package:login_app/ui/screens/auth_screen.dart';
import 'package:login_app/ui/screens/home_page.dart';
import 'package:login_app/ui/services/auth.dart';
import 'package:login_app/ui/widgets/original_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class AuthForm extends StatefulWidget {

  final AuthType authType;
  const AuthForm({Key key, @required this.authType}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

//01:41
class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  String _name; String _password;
  AuthBase authBase = AuthBase();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20   ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              validator: (value) => value.isEmpty ? 'You must enter Email' : null,
              decoration: InputDecoration(
                hintText: 'Enter Email'
              ),
              onChanged: (value) => _name = value,
            ),
            _separator(),
            TextFormField(
              validator: (value) => value.length < 6 ? 'Password must be more than 6 chars' : null,
              decoration: InputDecoration(
                hintText: 'Enter Password',
              ),
              obscureText: true,
              onChanged: (value) => _password = value,
            ),
            _separator(),
            Hero(
              tag: 'heroButton',
              child: OriginalButton(
                  bgColor: Colors.blue,
                  textColor: Colors.white,
                  text: (widget.authType==AuthType.login)?'Login':'Register',
                  onPressed: () async{
                    if(_formKey.currentState.validate())
                    {
                      if(widget.authType==AuthType.login) //Login
                        {
                          var res = await authBase.loginUser(_name, _password);
                          if(res == null)
                          {
                            final snack = SnackBar(content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Failed to login',),
                                Icon(Icons.error),
                              ],
                            ),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                            );

                            Scaffold.of(context).showSnackBar(snack);
                          }
                          print('Successful Login');

                        }
                      else //Register
                        {
                          await authBase.registerUser(_name, _password);
//                          Navigator.of(context).pushReplacementNamed('/home');
                          print('Successful Register');
                        }
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage(title: _name),));
                      markLogged(_name);
                    }
                  },
                ),
            ),
            _separator(),
            FlatButton(
              child: Text(
                  (widget.authType==AuthType.login)?'Don\'t have an account?':'You Already have an account?'
              ),
              onPressed: (){
                Navigator.of(context).pushReplacementNamed(
                    (widget.authType==AuthType.login)? '/register' : '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
  _separator(){
    return SizedBox(height: 10,);
  }
  void markLogged(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

}

