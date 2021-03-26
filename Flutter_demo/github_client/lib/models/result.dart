import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

part 'result.g.dart';
@JsonSerializable()
class Result {
  Result();
  int code;
  Map<String, dynamic> data;
  String message;
  List datas;

  factory Result.fromJson(Map<String,dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);

}