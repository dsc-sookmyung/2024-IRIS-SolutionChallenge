import 'package:iris_flutter/model/login_response.dart';
import 'package:iris_flutter/model/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'login_repository.g.dart';

@RestApi()
abstract class LoginRepository {
  factory LoginRepository(Dio dio, {String baseUrl}) = _LoginRepository;

  @GET('/auth/refresh')
  Future<LoginResp> getRefreshToken(
      @Header('refreshToken') String refreshToken);

  @GET('/auth/google/callback')
  Future<LoginResp> getLogin(@Query('code') String code);

  @GET('/member')
  Future<User> getUserInfo();
}
