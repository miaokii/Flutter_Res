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
        'self_manager': (context)=>TapBoxA(),
        'parent_manager': (context)=>ParentWidget(),
        'booth_manager': (context) => ParentWidgetC(),
        '/': (context) => HomePage()
      },
      initialRoute: '/',
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('状态管理'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Widget管理自身状态'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('self_manager');
              },
            ),
            FlatButton(
              child: Text('父Widget管理子Widget状态'),
              onPressed: () {
                Navigator.of(context).pushNamed('parent_manager');
              },
            ),
            FlatButton(
              child: Text('混合状态管理'),
              onPressed: () {
                Navigator.of(context).pushNamed('booth_manager');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// TapBoxA管理自身状态
// -------- TapBoxA --------
class TapBoxA extends StatefulWidget {
  
  TapBoxA({
    Key key
  }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TapBoxAState();
  }
}

class _TapBoxAState extends State<TapBoxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自身管理state'),
      ),
      // 手势检测widget
      body: GestureDetector(
        onTap: _handleTap,
        child: Container(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 20.0, color: Colors.white),
            textAlign: TextAlign.center,
            
          ),
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[700]
          ),
        ),
      )
    );
  }
}

// ParentWidget管理TapBoxB状态
// --------- ParentWidget ---------
class ParentWidget extends StatefulWidget {
  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 传递parent管理的状态
      child: new TapBoxB(
        active: _active,
        // 监听触摸
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

// --------- TapBoxB ----------
class TapBoxB extends StatelessWidget {
  TapBoxB({
    Key key,
    this.active: false,
    @required this.onChanged
  }): super(key: key);

  // 状态
  final bool active;
  // 点击回调 闭包
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {  
    return new GestureDetector(
      onTap: _handleTap,
      child: Scaffold(
        appBar: AppBar(
        title: Text('Parent管理state'),
      ),
      body: Container(
        child: new Text(
            active ? 'Active' : 'Inactive',
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 32.0,
              color: Colors.white
            ),
          ),
        width: 200,
        height: 200,
        decoration:  new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[700]
        )
      ),
      )
    );
  }
}

// ParentWidget
// 共同管理状态
// parent管理点击状态
// tapBoxc管理自身高亮状态
class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;
  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapBoxC(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class TapBoxC extends StatefulWidget {

  TapBoxC({
    Key key,
    this.active: false,
    @required this.onChanged
  }): super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;
  
  @override
  State<StatefulWidget> createState() {
    return _TapBoxCState();
  }
}

class _TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;

  void _higlightTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _highlightTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _highlightTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void handleTap() {
    // statefulState自身保持着widget对象的引用
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _higlightTapDown,
      onTapUp: _highlightTapUp,
      onTap: handleTap,
      onTapCancel: _highlightTapCancel,
      child: Container(
        child: new Center(
          child: new Text(widget.active ? 'active' : 'inactive',
          style: new TextStyle(fontSize: 32, color: Colors.white)
          ),
        ),
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight ? new Border.all(
            color: Colors.red[700],
            width: 10
          ) : null
        ),
      ),
    );
  }
}