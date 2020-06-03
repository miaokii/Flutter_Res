import 'package:flutter/material.dart';

import '../../const.dart';

class IndexBar extends StatefulWidget {
  final Function(String str) indexBarCallback;

  IndexBar({this.indexBarCallback});

  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexBar> {
  List<String> _words = ['🔍','⭐️', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
  Color _bkColor = Color.fromRGBO(1, 1, 1, 0);
  Color _textColor = Colors.grey;

  double _indicatorY = 0;
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  void setState(fn) {
    // TODO: implement setState
  }

  int _drag(BuildContext context, Offset offset) {
    // 坐标系转换
    RenderBox box = context.findRenderObject();
    // 相对于当前部件的坐标的y
    double y = box.globalToLocal(offset).dy;
    // 算字符串高度
    var itemHeight = ScreenHeight(context) / 2 / _words.length;
    // 算出选中的item
    int index = y ~/ itemHeight;
    if (index >= 0 && index < _words.length) {
      widget.indexBarCallback(_words[index]);
      return index;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    // 索引条内容
    List<Widget> words = [];
    for (int i = 0; i < _words.length; i++) {
      words.add(
          Expanded(
              child: Text(_words[i], style: TextStyle(color: _textColor),))
      );
    }
    return Positioned(
      right: 0,
      height: ScreenHeight(context) / 2,
      top: ScreenHeight(context)/8,
      width: 100,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment(0, _indicatorY),
            width: 100,
            child: Stack(
              alignment: Alignment(-0.2, 0),
              children: <Widget>[
                Image(image: AssetImage('images/气泡.png'), width: 60,),
                Text(_indicatorText,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                  ),)
              ],
            )
          ),
          GestureDetector(
            child: Container(
              color: _bkColor,
              child: Column(
                children: words,
              ),
            ),
            onVerticalDragDown: (DragDownDetails details){
              int index = _drag(context, details.globalPosition);
              setState(() {
                _bkColor = Color.fromRGBO(1, 1, 1, 0.5);
                _textColor = Colors.black;
                _indicatorText = _words[index];
                _indicatorY = 2.2 / _words.length * index - 1.1;
                _indicatorHidden = false;
              });
            },
            onVerticalDragEnd: (DragEndDetails details){
              setState(() {
                _bkColor = Color.fromRGBO(1, 1, 1, 0);
                _textColor = Colors.grey;
                _indicatorHidden = true;
              });
            },
            onVerticalDragUpdate: (DragUpdateDetails details){
              int index = _drag(context, details.globalPosition);
              setState(() {
                _indicatorText = _words[index];
                _indicatorY = 2.2 / _words.length * index - 1.1;
                _indicatorHidden = false;
              });
            },
          )
        ],
      )
    );
  }
}