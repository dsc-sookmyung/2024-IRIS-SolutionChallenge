import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResp {
  String grantType;
  String accessToken;
  String refreshToken;

  LoginResp({
    required this.grantType,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResp.fromJson(Map<String, dynamic> json) =>
      _$LoginRespFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRespToJson(this);
}
