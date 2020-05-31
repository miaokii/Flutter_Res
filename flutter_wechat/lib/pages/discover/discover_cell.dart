import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/discover/discover_child_page.dart';

class DiscoverCell extends StatefulWidget {
  final String title;
  final String subTitle;
  final String imageName;
  final String subImageName;

  DiscoverCell({
    this.imageName,
    this.title,
    this.subTitle,
    this.subImageName
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DiscoverState();
  }
}

class _DiscoverState extends State<DiscoverCell> {
  bool _highLight = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context){
            return DiscoverChildPage(title: widget.title,);
          })
        );
      },
      onTapCancel: (){
        setState(() {
          _highLight = false;
        });
      },
      onTapUp: (detail){
        setState(() {
          _highLight = false;
        });
      },
      onTapDown: (down){
        setState(() {
          _highLight = true;
        });
      },
      child: Container(
          color: _highLight ? Colors.grey[300] : Colors.white,
          height: 54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // left
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Image(image: AssetImage(widget.imageName), width: 20,),
                    SizedBox(width: 15,),
                    Text(widget.title),
                  ],
                ),
              ),
              // right
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    widget.subTitle != null ? Text(widget.subTitle) : Text(''),
                    SizedBox(width: 10,),
                    widget.subImageName != null ? Image(image: AssetImage(widget.subImageName), width: 10,): Container(),
                    SizedBox(width: 10,),
                    Image(image: AssetImage('images/icon_right.png'), width: 15,)
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}