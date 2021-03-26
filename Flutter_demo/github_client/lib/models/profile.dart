import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "cacheConfig.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
    Profile();

    /// 当前用户
    User user;
    /// 登录token
    String token;
    /// 当前主题
    num theme;
    /// 上次登录的用户
    String lastLogin;
    CacheConfig cache;
    /// 当前语言
    String locale;
    
    factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
