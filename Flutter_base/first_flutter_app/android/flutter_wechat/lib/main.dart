import 'package:flutter/material.dart';
import 'package:flutter_wechat/const.dart';
import 'package:flutter_wechat/root_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // 高亮颜色
        highlightColor: Color.fromARGB(1, 0, 0, 0),
        // 水波纹颜色
        splashColor: Color.fromARGB(1, 0, 0, 0),
        cardColor: Colors.black87
      ),
      home: RootPage(),
    );
  }
}
