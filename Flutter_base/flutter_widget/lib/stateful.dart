import 'package:flutter/material.dart';

class _CounterDisplay extends StatelessWidget {

  const _CounterDisplay({
    Key key,
    @required this.count
  }): super(key: key);

  final int count;
  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class _CounterIncrementor extends StatelessWidget {
  _CounterIncrementor({this.onPress});
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('increment'),
      onPressed: onPress,
    );
  }
}

class _CounterReduce extends StatelessWidget {

  _CounterReduce({this.onPress});
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: onPress,
      child: Text('reduce'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CunterState();
}

class _CunterState extends State<Counter> {

  int _counter = 0;

  void _increment() {
    setState(() {
      _counter += 1;
    });
  }

  void _reduce() {
    setState(() {
      _counter -= 1;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('累加器'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: _increment),
            _CounterIncrementor(onPress: _increment),
            _CounterDisplay(count: _counter),
            _CounterReduce(onPress: _reduce),
            IconButton(icon: Icon(Icons.subtitles), onPressed: _reduce),
          ],
        )
      ),
    );
  }
}