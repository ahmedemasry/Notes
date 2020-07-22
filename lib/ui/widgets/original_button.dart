import 'package:flutter/material.dart';

class OriginalButton extends StatelessWidget {
  final onPressed;
  final text;
  final textColor;
  final bgColor;

  const OriginalButton({Key key, this.onPressed, this.text, this.textColor, this.bgColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 45,
      width: double.infinity,
      child: RaisedButton(
        child: Text(text,
        style: TextStyle(color: textColor),
        ),
        color: bgColor,
        onPressed: onPressed,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

      ),
    );
  }
}
