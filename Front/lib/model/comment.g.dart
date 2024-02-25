// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      cid: json['cid'] as int,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      clothes: json['clothes'] as String?,
      details: json['details'] as String?,
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      discoveredAt: json['discoveredAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      author: json['author'] as bool,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'cid': instance.cid,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'clothes': instance.clothes,
      'details': instance.details,
      'accuracy': instance.accuracy,
      'images': instance.images,
      'discoveredAt': instance.discoveredAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'author': instance.author,
    };
