import 'package:flutter/material.dart';

class CustionGestruePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手势处理'),
      ),
      body: Center(
        child: _MyButton(),
      ),
    );
    
  }
}

class _MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('taped button');
      },
      child: Container(
        width: 100,
        height: 36,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.lightGreen
        ),
        child: Center(
          child: Text('Engage')
        ),
      ),
    );

  }
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       print('MyButton was tapped!');
  //     },
  //     child: Container(
  //       height: 36.0,
  //       padding: const EdgeInsets.all(8.0),
  //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(5.0),
  //         color: Colors.lightGreen[500],
  //       ),
  //       child: Center(
  //         child: Text('Engage'),
  //       ),
  //     ),
  //   );
  // }
}