
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_client/index.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  final _pages = [
    HomePage(),
    OrderPage(),
    HomePage(),
    HomePage(),
  ];
  int _currentIndex = 0;

  void _changeCurrentIndex(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List items = [['home','首页'],['order', '订单'], ['statistics', '统计'], ['mine', '我的']];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: items.map((e) {
          final item = BottomNavigationBarItem(
              icon: SizeAsImage('${e[0]}.png', height: 24, width: 24,),
              activeIcon: SizeAsImage('${e[0]}_selected.png', height: 24, width: 24,),
              label: e[1]);
          return item;
        }).toList(),
        type: BottomNavigationBarType.fixed,
        fixedColor: mainColor,
        currentIndex: _currentIndex,
        onTap: _changeCurrentIndex,
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
      ),
      body: _pages[_currentIndex],
    );
  }
}