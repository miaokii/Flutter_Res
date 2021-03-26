// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] as Map<String, dynamic> ?? {}
    ..datas = json['data'] as List ?? [];
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  Map<String, dynamic> json = {
    'code': instance.code,
    'message': instance.message,
  };

  if (instance.data.isNotEmpty) {
    json['data'] = instance.data;
  } else if (instance.datas.isNotEmpty) {
    json['data'] = instance.datas;
  }
  return json;
}
