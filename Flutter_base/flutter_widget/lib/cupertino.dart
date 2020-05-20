

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            backgroundColor: Colors.pink,
            middle: Text('Cupertino Page'),
            automaticallyImplyMiddle: true,
          ),
          child: Center(
            child: Column(children: <Widget>[
              CupertinoButton(
                child: Text('Tap me'),
                color: Colors.purple,
                onPressed: () {
                  showCupertinoDialog(context: context, builder: (context){
                    return CupertinoAlertDialog(
                      title: Text('提示'),
                      content: Container(
                        child: Text('您的操作有误，请重新尝试'),
                        ),
                      actions: <Widget>[
                        CupertinoDialogAction(child: Text('取消'), isDefaultAction: true, onPressed: (){
                          print('object');
                          Navigator.of(context).pop();
                          }
                        )
                      ],
                    );
                  });
                }
              )
            ]
          ),
        )
      )
    );
  }
}
