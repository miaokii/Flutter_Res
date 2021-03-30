import 'package:flutter/material.dart';

class CusTextButton extends TextButton {
  CusTextButton(this.text, {
    this.onPress,
    this.textColor = Colors.black,
    this.fontSize = 14,
    this.backgroundColor,
    this.circular = 3,
  }): super(
    onPressed: onPress,
    child: Text(text, style: TextStyle(
        fontSize: fontSize
    ),),
    style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          return textColor;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) => backgroundColor),
        shape: MaterialStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(circular));
        })
    ),
  );

  String text;
  Color textColor;
  double fontSize;
  Color backgroundColor;
  double circular;
  VoidCallback onPress;
}