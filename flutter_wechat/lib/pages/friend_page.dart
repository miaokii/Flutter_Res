
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FriendState();
  }
}

class _FriendState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('朋友'),
      ),
      body: Center(
        child: Text('通讯录'),
      ),
    );
  }
}