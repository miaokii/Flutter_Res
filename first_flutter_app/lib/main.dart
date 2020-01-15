import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// 根视图（weight，万物皆是weight）
class MyApp extends StatelessWidget {
  @override
  // 构建页面调用，描述如何构建页面（组合、拼装等）
  Widget build(BuildContext context) {
    // Material库提供，设置应用名称，主题，语言，路由等
    return MaterialApp(
      // 应用名称
      title: 'Flutter Demo',
      // 主题
      theme: ThemeData(
        // 导航栏颜色
        primarySwatch: Colors.blue,
      ),
      // 首页
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// 首页
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 计数器，保存+点击次数的状态
  int _counter = 0;

  void _incrementCounter() {
    // 通知Flutter有状态发生改变，flutter接收到通知后，执行build方法根据新的状态绘制界面
    setState(() {
      _counter++;
    });
  }

  @override
  // setState调用后都会调用build方法
  Widget build(BuildContext context) {
    // 手脚架框架，提供导航栏，标题和主屏幕组建树
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // center组建将自组建中心对齐
      body: Center(
        // 将子组建沿屏幕依次垂直排列
        child: Column(
          // 垂直剧中显示
          mainAxisAlignment: MainAxisAlignment.center,
          // 子空间数组
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            // 添加一个跳转新界面的button
            FlatButton(
              onPressed: (){
                // 导航到新路由
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context){
                    return NewRote();
                  },
                  fullscreenDialog: true)
                  );
              }, 
              child: Text('open new route'),
              textColor: Colors.blue,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

/*
路由定义页面之间的跳转，也就是导航管理，无论在那个平台，导航管理都会维护一个路由栈，push新打开一个页面，pop关闭页面
*/ 

class NewRote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Rote'),
      ),
      body: Center(
        child: Text('This is new rote'),
      ),
    );
  }
}


