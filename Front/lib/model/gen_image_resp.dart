import 'package:json_annotation/json_annotation.dart';

part 'gen_image_resp.g.dart';

@JsonSerializable()
class GenImageResp {
  String genImgUrl;
  int pid;

  GenImageResp({
    required this.genImgUrl,
    required this.pid
  });

  factory GenImageResp.fromJson(Map<String, dynamic> json) => _$GenImageRespFromJson(json);

  Map<String, dynamic> toJson() => _$GenImageRespToJson(this);
}
