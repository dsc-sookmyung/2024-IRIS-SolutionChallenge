// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      pid: json['pid'] as int,
      name: json['name'] as String,
      gender: json['gender'] as bool,
      age: json['age'] as int,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      clothes: json['clothes'] as String,
      details: json['details'] as String?,
      bookmarked: json['bookmarked'] as bool,
      disappearedAt: json['disappearedAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      genImage: json['genImage'] as String,
      author: json['author'] as bool,
      genRepresent: json['genRepresent'] as bool,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'pid': instance.pid,
      'name': instance.name,
      'gender': instance.gender,
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'clothes': instance.clothes,
      'details': instance.details,
      'bookmarked': instance.bookmarked,
      'disappearedAt': instance.disappearedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'images': instance.images,
      'genImage': instance.genImage,
      'author': instance.author,
      'genRepresent': instance.genRepresent,
    };
