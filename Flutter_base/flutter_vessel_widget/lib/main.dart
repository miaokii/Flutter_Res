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
        'chicun': (context)=>SizeWidget(),
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
              child: Text('尺寸限制'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('chicun');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SizeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('尺寸限制容器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          runSpacing: 5,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                // 最小高度
                minHeight: 50,
              ),
              child: Container(
                height: 5,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: Container(
                height: 5,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]]),
              borderRadius: BorderRadius.circular(4),
              boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black54,offset: Offset(2, 2), blurRadius: 4)
                ]
              ),
              child: Padding( padding: EdgeInsets.symmetric( horizontal: 80, vertical: 18 ),
                child: Text('Login', style: TextStyle( color: Colors.white )),
              ),
            ),
            Container(
              color: Colors.black,
              child: Transform(
                // 相对于坐标系原点的对齐方式
                alignment: Alignment.topLeft,
                // 沿Y轴倾斜0.3度
                transform: Matrix4.skewY(0.1),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.deepOrange,
                  child: const Text('Apartment for rent'),
                ),
              ),
            ),
            Container(
              // 外容器填充
              margin: EdgeInsets.only(top: 50, left: 120),
              // 卡片大小
              constraints: BoxConstraints.tightFor(width: 200, height: 150),
              // 背景装饰
              decoration: BoxDecoration(
                // 径向渐变
                gradient: RadialGradient(
                  colors: [Colors.red, Colors.orange],
                  center: Alignment.topLeft,
                  radius: .98
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(2, 2),
                    blurRadius: 4
                  )
                ],
                borderRadius: BorderRadius.circular(5)
              ),
              transform: Matrix4.rotationZ(.2),
              alignment: Alignment.center,
              child: Text('520',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            )
          ],
        )
      ),
    );
  }
}