
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('Push widget'),
          textColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ConterWidget(
                  intValue: 2,
                );
              })
            );
          },
        ),
      ),
    );
  }
}

class ConterWidget extends StatefulWidget {
  const ConterWidget({
    Key key,
    this.intValue: 0
  });

  final int intValue ;
  
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<ConterWidget> {
  int _counter;
  // static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _counter = widget.intValue;
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Increase'),
        backgroundColor: Colors.pinkAccent,
      ),
      // key: _globalKey,
      body: Center(
        child: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
            child: Text('$_counter'),
            color: Colors.red,
            textColor: Colors.white,
            onPressed:()=>setState(()=> ++_counter,
              )
            ),
            RaisedButton(
              onPressed: (){
                
                ScaffoldState _state = context.findAncestorStateOfType();
                // var _state = Scaffold.of(context);
                // ScaffoldState _state = _globalKey.currentState;
                _state.showSnackBar(
                  SnackBar(
                    content: Text('我是SnackBar'),
                  )
                );
              },
              child: Text('弹出SnackBar提示框'),
            ),
            FlatButton(
              child: Text('Cupertino组建'),
              onPressed: () {

                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return CupertinoTestRoute();
                }));

                // Navigator.of(context).push(
                //   CupertinoPageRoute(builder: (context) {
                //     return CupertinoTestRoute();
                //   })
                // );
              },
            )
            ],
          );
        },)
      ),
    );
  }

  @override
  void didUpdateWidget(ConterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }
  
  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('despose');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}

/* fluter widget生命周期
flutter: initState
flutter: didChangeDependencies
flutter: build
flutter: deactivate
flutter: despose
*/

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cuperino Widget'),
      ),
      child: Center(
        child: CupertinoButton(
          child: Text('CupertinoButton'),
          color: CupertinoColors.activeBlue,
          onPressed: () {},
        ),
      ),
    );
  }
}