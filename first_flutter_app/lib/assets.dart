import 'dart:async' show Future ;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// 加载资源
Future<String> loadAsset() async {
  return await rootBundle.loadString('imags/config.json');
}

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('imags/nodata.png')
        )
      ),
    );
  }
}