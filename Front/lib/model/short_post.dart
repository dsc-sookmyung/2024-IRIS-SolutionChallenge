import 'package:json_annotation/json_annotation.dart';

part 'short_post.g.dart';

@JsonSerializable()
class ShortPost {
  int pid;
  String imgUrl;
  String name;
  bool gender;
  int age;
  String address;
  double latitude;
  double longitude;
  String disappearedAt;
  String createdAt;
  String updatedAt;
  bool bookmarked;
  bool author;

  ShortPost({
    required this.pid,
    required this.imgUrl,
    required this.name,
    required this.gender,
    required this.age,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.disappearedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.bookmarked,
    required this.author,
  });

  factory ShortPost.fromJson(Map<String, dynamic> json) => _$ShortPostFromJson(json);

  Map<String, dynamic> toJson() => _$ShortPostToJson(this);
}