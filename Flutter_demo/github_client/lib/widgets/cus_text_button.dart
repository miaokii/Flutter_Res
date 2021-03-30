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

// ignore: must_be_immutable
class ASImage extends Image {
  ASImage(this._assetsPath): super(image: AssetImage('assets/images/$_assetsPath'));
  String _assetsPath;
}

// ignore: must_be_immutable
class SizeAsImage extends Image {
  SizeAsImage(this._assetsPath, {this.height, this.width}):
        super(image: AssetImage('assets/images/$_assetsPath'),
      height: height,
      width: width);
  String _assetsPath;
  double width;
  double height;
}