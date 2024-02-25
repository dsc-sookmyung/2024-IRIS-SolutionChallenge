import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  int pid;
  String name;
  bool gender;
  int age;
  int? height;
  int? weight;
  String address;
  double latitude;
  double longitude;
  String clothes;
  String? details;
  bool bookmarked;
  String disappearedAt;
  String createdAt;
  String? updatedAt;
  List<String> images;
  String genImage;
  bool author;
  bool genRepresent;

  Post({
    required this.pid,
    required this.name,
    required this.gender,
    required this.age,
    this.height,
    this.weight,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.clothes,
    this.details,
    required this.bookmarked,
    required this.disappearedAt,
    required this.createdAt,
    this.updatedAt,
    required this.images,
    required this.genImage,
    required this.author,
    required this.genRepresent,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
