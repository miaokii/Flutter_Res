import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/index.dart';

// 全局主题
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  // static NetCache netCache = NetCache();
  // 主题列表
  static List<MaterialColor> get themes => _themes;
  // release环境
  static bool get isRealse => bool.fromEnvironment('dart.vm.product');

  // 初始化全局信息，在App启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {

      }
    }
  }
}

