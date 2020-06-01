import 'friends_data.dart';
import 'package:flutter_wechat/const.dart';
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

  final List<Friend> _headData = [
    Friend(imageUrl: 'images/新的朋友.png', name: '新的朋友'),
    Friend(imageUrl: 'images/群聊.png', name: '群聊'),
    Friend(imageUrl: 'images/标签.png', name: '标签'),
    Friend(imageUrl: 'images/公众号.png', name: '公众号')
  ];

  Widget _itemForRow(BuildContext context, int index) {
    // 系统cell
    if (index < _headData.length) {
      return _FriendCell(imageAssets: _headData[index].imageUrl, name: _headData[index].name,);
    } else {
      return _FriendCell(imageUrl: friends_list[index - 4].imageUrl, name: friends_list[index - 4].name,);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,
        title: Text(
          '朋友',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Image(image: AssetImage('images/icon_friends_add.png'), width: 25,)
            ),
          )
        ],
      ),
      body: Center(
        child: ListView.builder(itemBuilder: _itemForRow,
          itemCount: _headData.length + friends_list.length,
        ),
      ),
    );
  }
}

class _FriendCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;

  const _FriendCell({Key key, this.imageUrl, this.name, this.groupTitle, this.imageAssets});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Row(
        children: <Widget>[
          // 图片
          Container(
            margin: EdgeInsets.all(10),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: imageUrl != null ? NetworkImage(imageUrl) : AssetImage(imageAssets)
                )
            ),
          ),
          Container(
            child: Text(name, style: TextStyle(fontSize: 18),),
          )
        ],
      ),
        ),
        Container(
          height: 1,
          color: WeChatThemeColor,
          child: Row(

          ),
        )
      ],
    );
  }
}