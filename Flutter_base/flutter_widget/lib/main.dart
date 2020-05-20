import 'package:flutter/material.dart';
import 'package:flutter_widget/gestureHandle.dart';
// import 'gestureHandle.dart';
import 'material.dart';
import 'widget.dart';
import 'cupertino.dart';
import 'stateful.dart';
import 'shopping.dart';
// import 'other.dart';

void main() {
  runApp(MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User',
      theme: ThemeData.light(),
      routes: {
        '/': (context) => HomePage(),
        'Widget': (context) => WidgetPage(),
        'Material': (context) => TutorialHome(),
        'Cupertino': (context) => CupertinoPage(),
        'CustionGestrue': (context) => CustionGestruePage(),
        'Counter': (context) => Counter(),
        'Shopping': (context) => ShoppingPage()
      },
      initialRoute: '/',
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局类'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Widget'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('Widget');
              },
            ),
            FlatButton(
              child: Text('Material'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('Material');
              },
            ),
            FlatButton(
              child: Text('Cupertino components'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('Cupertino');
              },
            ),
            FlatButton(
              child: Text('CustionGestrue'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('CustionGestrue');
              },
            ),
            FlatButton(
              child: Text('Counter'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('Counter');
              },
            ),
            FlatButton(
              child: Text('Shopping'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('Shopping');
              },
            ),
          ],
        ),
      ),
    );
  }
}