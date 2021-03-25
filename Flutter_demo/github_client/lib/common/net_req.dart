import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'dart:convert';
import 'dart:io';
import '../index.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';


/// 请求封装，
class NetReq {

  NetReq([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
  static Dio dio = Dio(
      BaseOptions(
          baseUrl: 'http://api.github.com/',
          headers: {
            HttpHeaders
                .acceptHeader: "application/vnd.github.squirrel-girl-preview,"
                "application/vnd.github.symmetra-preview+json"
          }
      )
  );

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Global.netCache);
    // 设置用户token，可能为null，代表未登录
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    // 在调试模式下要抓包，使用代理，禁用HTTPS证书校验
    if (!Global.isRealse) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 10.1.10.250:8888";
        };
        // 代理工具会提供一个抓包的自签名证书，可能会通不过证书校验，所以禁用
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }
  Future<User> login(String login, String pwd) async {
    String basic = 'Basic' + base64.encode(utf8.encode('$login:$pwd'));
    var r = await dio.get("/user/$login",
        options: _options.merge(headers: {
          HttpHeaders.authorizationHeader: basic
        },
            extra: {
              "noCache": true
            })
    );

    // 登录成功后跟新公共头，此后的所有请求都会带上用户身份信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    // 清空缓存
    Global.netCache.cache.clear();
    // 更新profile的token信息
    Global.profile.token = basic;
    return User.fromJson(r.data);
  }
}