// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {

  Result res = Result();
  res.code = json['code'] as num;
  res.message = json['message'] as String;
  if (json['data'] is Map) {
    res.data = json['data'] as Map<String, dynamic> ?? {};
  } else if (json['data'] is List) {
    res.datas = json['data'] as List ?? [];
  }
  return res;
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
