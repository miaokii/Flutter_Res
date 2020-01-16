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
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      // 命名路由
      routes: {
        'new_page': (context) => NewRote(),
        'new_echo_nav_param': (context) => EchoRoute(),
        'new_tip': (context) {
          return TipRoute(
            orderID: ModalRoute.of(context).settings.arguments,
          );
        },
        '/': (context) => MyHomePage(
          title: 'Flutter Home',
        )
      },
      
      /* 路由生成钩子
      在路由跳转前判断条件，符合即跳转，否者跳转另一个
      场景：购物车需要登陆才能继续，如果登陆，到购物车，如果未登陆，到登陆界面
      onGenerateRoute：当打开命名路由的时候会调用
      使用 Navigator.pushNamed(...)打开命名路由时，如果路由名在路由表中已经注册，就会调用路由表中的builder函数生成组建
      如果没有注册，才会调用onGenerateRoute生成路由
      */
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          print('$routeName');
          return NewRote();
        });
      },
      // home路由
      // 设置了home路由，不再是指home参数
      initialRoute: '/',
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

            // 导航到新路由按钮1
            FlatButton(
              child: Text('Navigator.push(context, route)跳转'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push( context, 
                  MaterialPageRoute(builder: (context){
                    return NewRote();
                  },
                  // push: false present: true
                  fullscreenDialog: false)
                );
              },
            ),
            
            FlatButton(
              child: Text('Navigator.of.push跳转'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return NewRote(); 
                  })
                );
              },
            ),
            
            FlatButton(
              child: Text('带参数非命名路由跳转'),
              textColor: Colors.blue,
              onPressed: () async {
                var result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return TipRoute(
                      orderID: '22124342243',
                    );
                  })
                );
                print("路由跳转返回值：$result");
              },
            ),

            FlatButton(
              child: Text('不代参数命名路由跳转'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'new_page');
              },
            ),

            FlatButton(
              child: Text('带参数命名路由跳转'),
              textColor: Colors.blue,
              onPressed: () {
                // Navigator.pushNamed(context, 'new_echo_nav_param', arguments: '你好呀，这是通过命名路由传递的参数');
                 Navigator.of(context).pushNamed('new_tip', arguments:'3323425');
              },
            ),

            FlatButton(
              child: Text('测试 onGenerateRoute路由生成钩子'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'shopping_car');
              },
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

// 非命名路由
class TipRoute extends StatelessWidget {
  
  final String orderID;

  TipRoute({
    Key key,
    @required this.orderID,  // 接受text参数
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('订单号：$orderID'),
              RaisedButton(
                onPressed: () => Navigator.pop(context, '我是返回值'),
                child: Text('返回'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取参数
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('命名路由参数传递'),
      ),
      body: Center(
        child: Text('$args'),
      ),
    );
  }
}