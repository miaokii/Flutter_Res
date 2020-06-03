import 'package:flutter_wechat/pages/friends/firend_index_bar.dart';

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

  final ScrollController _scrollController = ScrollController();

  Widget _itemForRow(BuildContext context, int index) {
    bool _hideIndexLetter = (index - 3 > 0) &&
        (_headData[index].indexLetter != _headData[index - 1].indexLetter);
    return _FriendCell(imageUrl: _headData[index].imageUrl,
      name: _headData[index].name,
      groupTitle: _hideIndexLetter ? _headData[index].indexLetter : null,);
  }

  @override
  void initState() {
    // 排序
    friends_list.sort((a, b)=>a.indexLetter.compareTo(b.indexLetter));
    _headData.addAll(friends_list);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: <Widget>[
          Container(
            child: ListView.builder(itemBuilder: _itemForRow,
              controller: _scrollController,
              itemCount: _headData.length,
            ),
          ),
          IndexBar(
            indexBarCallback: (str) {
//              _scrollController.animateTo(Offset(0, 231), duration: Duration.zero, curve: Curves.easeIn);
              print(str);
            },
          )
        ],
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
          height: groupTitle != null ? 30 : 0,
          color: WeChatThemeColor,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Text(
                groupTitle != null ? groupTitle : '',
                style: TextStyle(
                  color: Colors.grey
                ),
              )
            ],
          ),
        ),
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
                        image: imageUrl.contains('http') ? NetworkImage(imageUrl) : AssetImage(imageUrl)
                    )
                ),
              ),
              Column(
                children: <Widget>[
                  Text(name, style: TextStyle(fontSize: 18),),
                ],
              )
//              Container(
//                child: Text(name, style: TextStyle(fontSize: 18),),
//              )
            ],
          ),
        ),
      ],
    );
  }
}