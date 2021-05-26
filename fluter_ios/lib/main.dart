

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

const methodChannel = const MethodChannel('flutter_native_iOS');

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static Future<dynamic> tokNative(String method, {Map params}) async {
    if (params == null) {
      return await methodChannel.invokeMethod(method);
    } else {
      return await methodChannel.invokeMethod(method, params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextButton(
                child: Text(
                  'push iOS',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  tokNative('flutter_push_to_iOS', params: {"tel": "18821233322"})
                    ..then((value) {
                      print(value);
                    });
                  print("push");
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.red)),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                child: Text(
                  'present iOS',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  tokNative('flutter_present_to_iOS', params: {"name": "zhangfei"})
                    ..then((value) {
                      print(value);
                    });
                  print("presentpresent");
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.red)),
              ),
            ],
          ),
        ));
  }
}
