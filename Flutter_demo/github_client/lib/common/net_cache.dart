import 'dart:collection';
import 'dart:html';

import 'package:dio/dio.dart'
    '';
import 'package:github_client/common/global.dart';
/// github在国内速度较慢，使用缓存策略
/// 将请求的url作为key，对请求的返回值在一个指定时间段内进行缓存
/// 另设置最大缓存数，当超过最大缓存数移除最早的一条缓存
/// 同时也要提供一个针对特定接口或请求决定是否缓存的机制用于指定
/// 那些请求需要缓存，比如登录接口就不能缓存，下拉刷新时也不能缓存
///
///
class CacheObject {

  CacheObject(this.response)
    :timeStamp = DateTime.now().millisecondsSinceEpoch;

  // 创建缓存时间
  int timeStamp;
  Response response;

  @override
  bool operator ==(Object other) {
    return response.hashCode == other.hashCode;
  }

  // 缓存的key
  int get hashCode => response.realUri.hashCode;
}

/// RequestOptions中的extra可以添加自定义字段
/// 手动添加两个字段
///   refresh bool 为true表示本次请求不缓存，但新的请求依然会缓存
///   noCache bool 本次请求禁用缓存，请求结果也不会被缓存
/// 实现缓存策略，可以直接通过拦截器实现
class NetCache extends Interceptor {
  /// 确保迭代器顺序和对象插入的时间顺序一致，使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  Future onRequest(RequestOptions options) {
    if (!Global.profile.cache.enable) return super.onRequest(options);
    // 下啦刷新
    bool refresh = options.extra["refresh"] == true;
    // 如果是下拉刷新，先删除相关缓存
    if (refresh) {
      // 如果是列表，只要url中包含当前path的缓存全部删除
      if (options.extra["list"] == true) {
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        delete(options.uri.toString());
      }
      return super.onRequest(options);
    }

    if (options.extra["noCache"] != true &&
      options.method.toLowerCase() == "get") {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        // 缓存未过期，返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 < Global.profile.cache.maxAge) {
          return super.onRequest(cache[key].response.request);
        } else {
          cache.remove(key);
        }
      }
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) {
    return super.onError(err);
  }

  @override
  Future onResponse(Response response) {
    if (Global.profile.cache.enable) {

    }
    return super.onResponse(response);
  }

  void _saveCache(Response object) {
    RequestOptions options = object.request;
    if (options.extra["noCache"] != true &&
      options.method.toLowerCase() == "get") {
      // 如果缓存超过最大限制，移除最先的一条
      if (cache.length == Global.profile.cache.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}

