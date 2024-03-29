import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_client/common/api_type.dart';
import 'dart:io';
import '../index.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

/// 请求封装，
class NetReq {

  NetReq([this.context]) {
    _options = Options(extra: {"context": context});
  }

  static const _baseUrl = 'http://pre.cloudcook.zljtys.com/cloudcook-api/api';
  BuildContext context;
  Options _options;
  static Dio _dio = Dio(
      BaseOptions(
          baseUrl: _baseUrl,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        responseType: ResponseType.json,
        headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json, text/plain, */*'
        }
      ),
  );

  static void init() {
    // 添加缓存插件
    _dio.interceptors.add(Global.netCache);
    // 日志
    _dio.interceptors.add(LogInterceptor());
    /*
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
     */
  }

  /*
  * 账号密码登录
  * */

  Future<User> pwdLogin(String tel, String pwd) async {
    var request = await _dio.post('/user/login',
      data: {
        "password": pwd,
        "type":2,
        "username": tel
      },
      options: _options.merge(
        extra: {"noCache": true }
      )
    );

    // 登录成功后跟新公共头，此后的所有请求都会带上用户身份信息
    // dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    // 清空缓存
    Global.netCache.cache.clear();
    // 更新profile的token信息
    // Global.profile.token = basic;
    return User.fromJson(request.data);
  }

  static Future<Result> request(API apiType, {params, Method method}) async {

    if (method == Method.GET) {
      _dio.options.method = "GET";
    } else if (method == Method.POST) {
      _dio.options.method = "POST";
    }

    Response response;
    try {
      response = await _dio.request(_apiPath[apiType], data: params);
      return Result.fromJson(response.data);
    } on DioError catch (e) {
      return Result()
        ..message = e.toString()
        ..code = -100;
    }
  }
}

enum Method {GET,POST}

const Map<API, String> _apiPath = {
  API.pwdLogin: '/user/login',
  API.vCodeLogin: '/user/code/login',
  API.getVCode: '/user/send/sms/code'
};
