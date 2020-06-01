import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/chat_page.dart';
import 'package:flutter_wechat/pages/discover/discover_page.dart';
import 'package:flutter_wechat/pages/friends/friend_page.dart';
import 'package:flutter_wechat/pages/mine_page.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RootState();
  }
}

class _RootState extends State<RootPage> {
  int _currentIndex = 2;
  List<Widget> _pages = [ChatPage(), FriendPage(), DiscoverPage(), MinePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          fixedColor: Colors.green,
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('images/tabbar_chat.png', height: 20, width: 20,),
                activeIcon: Image.asset('images/tabbar_chat_hl.png', height: 20, width: 20,),
                title: Text('微信')
            ),
            BottomNavigationBarItem(
                icon: Image.asset('images/tabbar_friends.png', height: 20, width: 20,),
                activeIcon: Image.asset('images/tabbar_friends_hl.png', height: 20, width: 20,),
                title: Text('通讯录')
            ),
            BottomNavigationBarItem(
                icon: Image.asset('images/tabbar_discover.png', height: 20, width: 20,),
                activeIcon: Image.asset('images/tabbar_discover_hl.png', height: 20, width: 20,),
                title: Text('发现')
            ),
            BottomNavigationBarItem(
                icon: Image.asset('images/tabbar_mine.png', height: 20, width: 20,),
                activeIcon: Image.asset('images/tabbar_mine_hl.png', height: 20, width: 20,),
                title: Text('我的')
            )
          ]
      ),
    );
  }
}