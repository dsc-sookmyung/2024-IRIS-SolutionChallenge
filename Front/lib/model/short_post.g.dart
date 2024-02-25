// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortPost _$ShortPostFromJson(Map<String, dynamic> json) => ShortPost(
      pid: json['pid'] as int,
      imgUrl: json['imgUrl'] as String,
      name: json['name'] as String,
      gender: json['gender'] as bool,
      age: json['age'] as int,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      disappearedAt: json['disappearedAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      bookmarked: json['bookmarked'] as bool,
      author: json['author'] as bool,
    );

Map<String, dynamic> _$ShortPostToJson(ShortPost instance) => <String, dynamic>{
      'pid': instance.pid,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'gender': instance.gender,
      'age': instance.age,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'disappearedAt': instance.disappearedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'bookmarked': instance.bookmarked,
      'author': instance.author,
    };
