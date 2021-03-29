import 'package:flutter/material.dart';
import '../index.dart';

/// 跨组件共享状态，最好不要将共享状态用全局变量代替，因为组件状态是和UI相关的，状态改变时UI组件也应该
/// 会自动更新。如果时用全局变量，就要手动该处理状态变动通知，接受机制以及和组件之间的依赖关系
///
/// 使用Provider包实现跨组件共享状态
/// 需要共享的状态有用户登录，APP主题、语言等信息，这些状态改变后都要通知其依赖组件更新
/// 所以应该使用ChangeNotifierProvider，更新后的状态也应该持久化保存
/// 定义ProfileChangeNotifier基类，让共享的Model继承该类
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    // 通知Profile变更
    Global.saveProfile();
    super.notifyListeners();
  }
}

// 用户状态变更
class UserModel extends ProfileChangeNotifier {
  User get use => _profile.user;
  // 是否需要登录，如果有用户就是登录过
  bool get isLogin => _profile.user != null;

  // 用户信息发生变化，更新用户信息并通知依赖他的widgets更新
  set user(User user) {
    if (user.id != _profile.user.id) {
      _profile.lastLogin = _profile.user.id;
      _profile.user = user;
      notifyListeners();
    }
  }
}

/// APP主题更新
class ThemeModel extends ProfileChangeNotifier {
  /// 获取当前主题，如果未设置主题，使用蓝色主题
  ColorSwatch get theme =>
      Global.themes
          .firstWhere((element) => element.value == _profile.theme,
          orElse: () => Colors.blue);

  /// 主题更新后，通知依赖项，新主题立即生效
  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

/*
/// App语言状态
class LocaleModel extends ProfileChangeNotifier {
  /// 获取当前用户语言配置Locale类，如果空，则语言跟随系统语言
  Locale getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    // 标识语言环境
    // param1：语言
    // param2：国家
    return Locale(t[0], t[1]);
  }

  // 当前Locale字符串表示
  String get locale => _profile.locale;

  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}
*/
