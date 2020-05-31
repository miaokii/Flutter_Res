import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/discover/discover_cell.dart';

class DiscoverPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DiscoverState();
  }
}

class _DiscoverState extends State<DiscoverPage> {
  Color _themeColor = Colors.grey[100];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeColor,
        // 安卓属性
        centerTitle: true,
        title: Text('发现',),
        elevation: 0.0,
      ),
      body: Container(
        color: _themeColor,
        child: ListView(
          children: <Widget>[
            DiscoverCell(title: '朋友圈', imageName: 'images/朋友圈.png',),
            SizedBox(height: 10,),
            DiscoverCell(title: '扫一扫', imageName: 'images/扫一扫.png',),
            // 分割线
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 1,
                )
              ],
            ),
            DiscoverCell(title: '摇一摇', imageName: 'images/摇一摇.png',),
            SizedBox(height: 10,),
            DiscoverCell(title: '搜一搜', imageName: 'images/搜一搜 2.png'),
            SizedBox(height: 10),
            DiscoverCell(title: '附近的人', imageName: 'images/附近的人icon.png'),
            SizedBox(height: 10,),
            DiscoverCell(
              title: '购物',
              imageName: 'images/购物.png',
              subTitle: '618限时特价',
              subImageName: 'images/badge.png',
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 1,
                )
              ],
            ),
            DiscoverCell(title: '游戏', imageName: 'images/游戏.png',),
            SizedBox(height: 10),
            DiscoverCell(title: '小程序', imageName: 'images/小程序.png',)
          ],
        )
      )
    );
  }
}