import 'package:flutter/material.dart';

class SceneryPage extends StatefulWidget {
  @override
  State<SceneryPage> createState() {
    return SceneryState();
  }
}

class SceneryState extends State<SceneryPage> {
  // 返回一个操作按钮
  Column _handleButtonWidget(Color color, IconData icon, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color,),
        /* 1、将文本放入container中，设置margin实现距离其他组件的间距 */
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // 标题栏
    Widget titleSection = Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          // 文本列占据大部分空间
          Expanded(
            /* 1、将Colum放置于Expanded中，可以拉伸到expanded中左右剩余空间 */
            child: Column(
              // 从起始位置布局
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /* 2、将文本放入container中可以增加内间距 */
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500]
                  )
                )
              ],
            )
          ),
          _FavoriteWidget()
        ],
      ),
    );

    Color primaryColor = Theme.of(context).primaryColor;
    Widget handleSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _handleButtonWidget(primaryColor, Icons.call, 'CALL'),
          _handleButtonWidget(primaryColor, Icons.near_me, 'ROUTE'),
          _handleButtonWidget(primaryColor, Icons.share, 'SHARE')
        ],
      ),
    );

    Widget describeSection = Container(
      padding: EdgeInsets.all(38),
      child: Text(
        '''
        Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: Stack(
       children: <Widget>[
         Positioned(
           child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: <Widget>[
              Image.asset(
                'images/timg.jpeg',
                height: 240,
                width: 600,
                fit: BoxFit.cover,
              ),
              titleSection,
              handleSection,
              describeSection,
            ],
          ),
         ),
         Positioned(
           top: 40,
           left: 20,
           width: 40,
           height: 40,
           child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: (){
                 Navigator.of(context).pop(null);
              }
            ),
         ),
       ], 
      )
    );
  }
}

class _FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteStated();
  }

}

class _FavoriteStated extends State<_FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 40;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: Icon(_isFavorited ? Icons.star : Icons.star_border),
            color: Colors.red,
            onPressed: (){
              setState(() {
                _isFavorited = !_isFavorited;
                _favoriteCount += _isFavorited ? 1 : -1;
              });
            }),
        ),
        SizedBox(
          width: 18,
          child: Text('$_favoriteCount'),
        )
      ],
    );
  }
}