import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatState();
  }
}

class _ChatState extends State<ChatPage> {

  List<Chat> _datas = [];
  bool _timeout = false;

  @override
  void initState() {
    print('chat 的 init进入');
    super.initState();
    _getDatas().then((value){
      print('数据已经获取');
      if (_timeout) {

      } else {
        setState(() {
          _datas = value;
        });
      }
    }).catchError((error){
      print('发生错误$error');
    }).whenComplete((){
      print('请求完毕');
    }).timeout(Duration(seconds: 15))
    .catchError((timeout){
      _timeout = true;
      print('超时输出$timeout');
    });
  }

  Future<List<Chat>> _getDatas() async {
    final response = await http.get('http://rap2.taobao.org:38080/app/mock/256911/api/chat/list');
    if (response.statusCode == 200) {
      // 获取响应数据
      Map body = json.decode(response.body);
      // 转模型数组 map中遍历的结果需要返回出去
      List<Chat> chatList = body['chat_list'].map<Chat>((item){
        return Chat.fromjson(item);
      }).toList();
      return chatList;
    } else {
      throw Exception('statusCode: ${response.statusCode}');
    }
  }

   Widget _buildPopupMenuItem(String imageAsset, String title) {
    return PopupMenuItem(
       child: Row(
         children: <Widget>[
           Container(
             margin: EdgeInsets.only(left: 5),
             child: Image(image: AssetImage(imageAsset), width: 20,),
           ),
           Container(
             margin: EdgeInsets.only(left: 10),
               child: Text(title, style: TextStyle(color: Colors.white),)
           ),
         ],
       ),
     );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('微信', style: TextStyle(color: Colors.black,)),
        backgroundColor: WeChatThemeColor,
        actions: <Widget>[
          PopupMenuButton(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.add, color: Colors.black,),
            ),
            offset: Offset(0, 60),
            // List<PopupMenuEntry<T>> Function(BuildContext context)
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: _buildPopupMenuItem("images/发起群聊.png", '发起群聊'),
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem("images/添加朋友.png", '添加朋友'),
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem("images/扫一扫1.png", '扫一扫')
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem("images/收付款.png", '收付款')
                )];
            },
          )
        ],
      ),
      body: Container(
        child: _datas.length == 0 ? Text('正在加载...'):
            ListView.builder(itemBuilder: (context, index){
              Chat item = _datas[index];
              return ListTile(
                    title: Text(item.name),
                    subtitle: Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(right: 10),
                      height: 25,
                      child: Text(item.message,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: NetworkImage(item.imageUrl)
                        ),
                      ),
                    ),
                  );
            },
            itemCount: _datas.length)
//        child: FutureBuilder(
//          future: getDatas(),
//          // Widget Function(BuildContext context, AsyncSnapshot<T> snapshot);
//          builder: (BuildContext context, AsyncSnapshot snapshot){
//            print('data:${snapshot.data}');
//            print('data:${snapshot.connectionState}');
//            // 正在加载
//            if (snapshot.connectionState == ConnectionState.waiting) {
//              return Center(
//                child: Text('Loading...'),
//              );
//            } else {
//              return ListView(
//                children: snapshot.data.map<Widget>((Chat item){
//                  return ListTile(
//                    title: Text(item.name),
//                    subtitle: Text(item.message),
//                    leading: Container(
//                      width: 40,
//                      height: 40,
//                      child: Image(
//                        image: NetworkImage(item.imageUrl),
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                  );
//                }).toList()
//              );
//            }
//          },
//        )
//        child: ListView.builder(itemBuilder: (context, index)){
      )
    );
  }
}

class Chat {
  final String name;
  final String message;
  final String imageUrl;
  Chat({this.name, this.message, this.imageUrl});

  // 通过map直接转对象
  // 工厂方法/工厂构造函数/不直接创建对象
  factory Chat.fromjson(Map json) {
    return Chat(
      name: json['name'],
      message: json['message'],
        imageUrl: json['imageUrl']
    );
  }
}

/*
* final chat = {
      'name':'张三',
      'message': '吃了吗'
    };

    // map转json
    final chatJson = json.encode(chat);
    print(chat);
    print(chatJson);
    // json转map
    final newChat = json.decode(chatJson);
    print(newChat);
* */