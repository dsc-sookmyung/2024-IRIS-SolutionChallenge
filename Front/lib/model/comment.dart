import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int cid;
  String address;
  double latitude;
  double longitude;
  String? clothes;
  String? details;
  double? accuracy;
  List<String> images;
  String discoveredAt;
  String createdAt;
  String? updatedAt;
  bool author;

  Comment({
    required this.cid,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.clothes,
    this.details,
    this.accuracy,
    required this.images,
    required this.discoveredAt,
    required this.createdAt,
    this.updatedAt,
    required this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
