import 'dart:ui';

import 'package:flutter/material.dart';

class CusTextButton extends TextButton {
  CusTextButton(
    this.text, {
    this.onPress,
    this.textColor = Colors.black,
    this.fontSize = 14,
    this.backgroundColor,
    this.circular = 3,
  }) : super(
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                return textColor;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => backgroundColor),
              shape: MaterialStateProperty.resolveWith((states) {
                return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(circular));
              })),
        );

  final String text;
  final Color textColor;
  final double fontSize;
  final Color backgroundColor;
  final double circular;
  final VoidCallback onPress;
}

Image assetsImage(String name, double width, double height) {
  return Image(
      image: AssetImage('assets/images/$name'), width: width, height: height);
}
