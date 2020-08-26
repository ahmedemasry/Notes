import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/ui/screens/auth_screen.dart';
import 'package:login_app/ui/screens/home_page.dart';
import 'package:login_app/ui/screens/intro_screen.dart';
import 'package:login_app/ui/widgets/auth_form.dart';
import 'package:login_app/ui/widgets/original_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


/*
To Do List
- Notification for Note before its dueDate
- Save the user's device token.
- Notification When the user enters from a different devices
- Note Image

 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  String logged = prefs.getString('name');
  runApp(MyApp(logged: await isLogged(),));
}

final storage = new FlutterSecureStorage();

class MyApp extends StatelessWidget {

  final logged;

  const MyApp({Key key, this.logged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
git

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xfff2f9fe),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(25),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue[400]),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      home: logged != null
          ? MyHomePage(uid: logged)
          : IntroScreen(),
      routes: {
        '/intro': (context) => IntroScreen(),
        '/login': (context) => AuthScreen(authType: AuthType.login,),
        '/register': (context) => AuthScreen(authType: AuthType.register,),
      },
    );
  }
}

Future<String> isLogged() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('uid');
}
