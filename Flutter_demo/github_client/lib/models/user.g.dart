part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
     ..token = json['token'] as String
     ..id = json['id'] as String
     ..tel = json['tel'] as String
     ..aeskay = json['aeskay'] as String
     ..name = json['name'] as String
     ..photo = json['photo'] as String
     ..role = json['role'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'token': instance.token,
  'id': instance.id,
  'tel': instance.tel,
  'aeskay': instance.aeskay,
  'name': instance.name,
  'photo': instance.photo,
  'role': instance.role
};
