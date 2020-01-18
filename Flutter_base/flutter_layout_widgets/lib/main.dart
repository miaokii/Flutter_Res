import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'RowColumn': (context)=>RowColumn(),
        'SpringWidget': (context)=>SpringWidget(),
        'StreamWidget': (context) => StreamWidget(),
        'StackLayoutWidget': (context) => StackLayoutWidget(),
        'progress_animation': (context) => MyHomePage(),
        'form': (context) => MyHomePage(),
        '/': (context) => MyHomePage()
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局类'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('线性布局'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('RowColumn');
              },
            ),
            FlatButton(
              child: Text('弹性布局'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('SpringWidget');
              },
            ),
            FlatButton(
              child: Text('流式布局'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('StreamWidget');
              },
            ),
            FlatButton(
              child: Text('层叠布局'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).pushNamed('StackLayoutWidget');
              },
            ),
            FlatButton(
              child: Text('表单组建'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).pushNamed('form');
              },
            ),
            FlatButton(
              child: Text('变色进度调'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('progress_animation');
              },
            )
          ],
        ),
      ),
    );
  }
}

class RowColumn extends StatefulWidget {
  State<RowColumn> createState() => _RowColumnState();
}

class _RowColumnState extends State<RowColumn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('线性布局'),
      ),
      // 垂直线性布局
      body: Column(
        // 测试Row对齐方式，排除干扰
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            // 水平方向
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hello world'),
              Text(', I am Jack')
            ],
          ),
          Row(
            // 在主轴占用控件
            mainAxisSize: MainAxisSize.min,
            // 无效，因为mainAxisSize为min
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hello world'),
              Text(', I am Jack')
            ],
          ),
          Row(
            // 布局顺序右到左
            textDirection: TextDirection.rtl,
            // 布局顺序为rtl，mainAxisAlignment从右到左布局，右为start，左为end
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('Hello world'),
              Text('I am Jack')
            ],
          ),
          // row高度为子元素中最高的高度
          Row(
            // 所以垂直方向start表示下
            crossAxisAlignment: CrossAxisAlignment.start,
            // 布局顺序默认为ltr，下到上排列，
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Text('Hello world',
              style: TextStyle(
                fontSize: 30
                ),
              ),
              Text('I am Jack')
            ],
          ),
        ],
      ),
    );
  }
}



// 弹性布局
class SpringWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('弹性布局'),
      ),
      body: Column(  
        children: <Widget>[
          // 
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 30.0,
                  color: Colors.red
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 30,
                  color: Colors.green,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              height: 100,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30,
                      color: Colors.red,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 30,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

class StreamWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('流式布局'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.red,
            child: Wrap(
              // 主轴方向间距
              spacing: 8,
              // 纵轴方向间距
              runSpacing: 4,
              // 沿主轴方向居中
              alignment: WrapAlignment.center,
              children: <Widget>[
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
                  label: Text('Hamilton'),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
                  label: Text('Lafayette'),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
                  label: Text('Mulligan'),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
                  label: Text('Laurens'),
                ),
              ],
            ),
          ),
          Flow(
            delegate: FlowColorDelegate(margin: EdgeInsets.all(14)),
            children: <Widget>[
              Container(width: 80, height: 80, color: Colors.red),
              Container(width: 80, height: 80, color: Colors.green),
              Container(width: 80, height: 80, color: Colors.blue),
              Container(width: 80, height: 80, color: Colors.yellow),
              Container(width: 80, height: 80, color: Colors.brown),
              Container(width: 80, height: 80, color: Colors.purple),
            ],
          )
        ],
      ),
    );
  }
}

class FlowColorDelegate extends FlowDelegate {

  EdgeInsets margin = EdgeInsets.zero;
  FlowColorDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    // 计算每个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        // 绘制子widget
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(double.infinity, 200);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

// 层叠布局
class StackLayoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('层叠布局'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          // 未定位的子widget沾满整个stack空间
          fit: StackFit.expand,
          children: <Widget>[
            Container(child: Text('Hello World',style: TextStyle(color: Colors.white)),
              color: Colors.red,
            ),
            Positioned(
              left: 18.0,
              child: Text('I am Jack'),
            ),
            Positioned(
              top: 18.0,
              child: Text('Your firend'),
            )
          ],
        ),
      ),
    );
  }
}