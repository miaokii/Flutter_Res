
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_client/index.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  Widget _buildHome() {
    UserModel user = Provider.of<UserModel>(context);
    if (!user.isLogin) {
      // 未登录
      return Center(
        child: FlatButton(
          child: Text('Login'),
          onPressed: ()=>Navigator.of(context).pushNamed('login'),
        ),
      );
    }
    // 已经登录，展示列表项目
    else {
      return Center(
        child: Text('已经登录'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github'),
      ),
      body: _buildHome(),
    );
  }
}