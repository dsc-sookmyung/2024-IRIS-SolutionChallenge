// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_comments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCommentsResp _$MyCommentsRespFromJson(Map<String, dynamic> json) =>
    MyCommentsResp(
      pid: json['pid'] as int,
      name: json['name'] as String,
      imgUrl: json['imgUrl'] as String,
      age: json['age'] as int,
      gender: json['gender'] as bool,
      address: json['address'] as String,
      commentList: (json['commentList'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyCommentsRespToJson(MyCommentsResp instance) =>
    <String, dynamic>{
      'pid': instance.pid,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'age': instance.age,
      'gender': instance.gender,
      'address': instance.address,
      'commentList': instance.commentList,
    };
