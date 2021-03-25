import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../index.dart';
import 'dart:async';

// 全局主题
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

/// 全局变量
class Global {
  /// 持久化成存储对象
  static SharedPreferences _prefs;
  /// 用户信息
  static Profile profile = Profile();
  /// 缓存插件
  static NetCache netCache = NetCache();
  /// 主题列表
  static List<MaterialColor> get themes => _themes;
  /// release环境
  static bool get isRealse => bool.fromEnvironment('dart.vm.product');

  /// 初始化全局信息，在App启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;
  }
  /// 持久化profile信息
  static saveProfile() {
    _prefs.setString("profile", jsonEncode(profile.toJson()));
  }
}

