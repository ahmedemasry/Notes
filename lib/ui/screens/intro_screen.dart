import 'package:flutter/material.dart';
import 'package:login_app/ui/widgets/original_button.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(),
            Hero(
              tag: 'logoAnimation',
              child: Image.asset('assets/images/pc.png',
                height: MediaQuery.of(context).size.height*.4,
              ),
            ),
            Hero(
              tag: 'heroButton',
              child: OriginalButton(text: 'Get Started',bgColor: Colors.white,textColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
              },
              ),
            )
          ],
        ),
      ),
    );
  }
}
