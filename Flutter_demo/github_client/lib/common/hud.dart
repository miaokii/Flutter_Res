import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HUD {
  static flash(String toast,
      {gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: toast,
      toastLength: toastLength,
      gravity: gravity,
      backgroundColor: Colors.black87,
      fontSize: 16
    );
  }

  /*
  * 加载视图
  * text: 提示文本
  * */
  static loading(context, [String text]) {
    text = text ?? 'Loading ...';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10
                )
              ]
            ),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(
              minHeight: 120,
              minWidth: 180
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  static void hide(context) {
    Navigator.of(context).pop();
  }
}