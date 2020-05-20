import 'package:flutter/material.dart';

class WidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          MyAppBar(title: Text('我是自定义Bar', textAlign: TextAlign.center,)),
          Expanded(child: Center(
            child: Text('Hello')
          ))
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {

  MyAppBar({
    Key key,
    @required this.title
  }): super(key: key);

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Colors.blue[500],
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation Bar',
            onPressed: (){
              Navigator.of(context).pop(null);
            },
          ),
          Expanded(child: title, flex: 1,),
          Expanded(child: Text('可以添加第二个bar', textAlign: TextAlign.center,), flex: 1,),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null)
        ]
      ),
    );
  }
}