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
// StatefulWidget有状态的组建
// 可以拥有状态，状态在Weight的声明周期是可变的，
// Stateful widget至少由两个类组成：
//    StatefulWidget类
//    State类，StatefulWidget类本身不可变，但是state类的状态在weiget的生命周期可能变化
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
