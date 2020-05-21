import 'package:flutter/material.dart';
import 'package:flutter_widget/gestureHandle.dart';
import 'gestureHandle.dart';
import 'material.dart';
import 'widget.dart';
import 'cupertino.dart';
import 'stateful.dart';
import 'shopping.dart';
import 'sceneryLayout.dart';

void main() {
  runApp(MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: MyApp(),
  ));
}

class RouteModel {
  RouteModel({this.name, this.route, this.routeWidget});
  String name;
  String route;
  Widget routeWidget;
}

class MyApp extends StatelessWidget {

  final List<RouteModel> _demos = [
    RouteModel(name: '自定义appbar', route: 'Widget', routeWidget: WidgetPage()),
    RouteModel(name: 'MaterialApp', route: 'Material', routeWidget: TutorialHome()),
    RouteModel(name: 'Cupertino Components', route: 'Cupertino', routeWidget: CupertinoPage()),
    RouteModel(name: 'Custom Gesture', route: 'CustionGestrue', routeWidget: CustionGestruePage()),
    RouteModel(name: 'Counter计数器', route: 'Counter', routeWidget: Counter()),
    RouteModel(name: 'Shopping', route: 'Shopping', routeWidget: ShoppingPage()),
    RouteModel(name: '风景页布局', route: 'Scenery', routeWidget: SceneryPage()),
  ];

  @override
  Widget build(BuildContext context) {
    final ros = Map<String, WidgetBuilder>();
    _demos.forEach((element) {
      ros[element.route] = (context) => element.routeWidget;
    });
    ros['/'] = (context) => HomePage(demos: _demos);
    return MaterialApp(
      title: 'User',
      theme: ThemeData.light(),
      routes: ros,
      initialRoute: '/',
    );
  }
}

class HomePage extends StatelessWidget {
  
  HomePage({this.demos});
  final List<RouteModel> demos; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户界面demos'),
      ),
      body: ListView(
        children: demos.map((RouteModel ele){
          return ListTile(
            title: Text(ele.name),
            onTap: (){
              print(ele.route);
              Navigator.of(context).pushNamed(ele.route);
            },
          );
        }).toList(),
      )
    );
  }
}