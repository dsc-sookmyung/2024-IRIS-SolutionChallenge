import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/dio_config.dart';
import 'package:iris_flutter/config/hidden_config.dart';
import 'package:iris_flutter/model/user.dart';
import 'package:iris_flutter/repository/login_repository.dart';
import 'package:iris_flutter/utils/user_profile_utils.dart';

class LoginController extends GetxController {
  Rx<User> user = User(name: '', email: '', profile_url: '').obs;
  RxBool isLoginIng = false.obs;

  Future<void> loginGoogle() async {
    isLoginIng = true.obs;

    GoogleSignIn googleSignIn;
    googleSignIn = GoogleSignIn(serverClientId: HiddenConfig.webClientId);

    await googleSignIn.signIn().then((result) {
      result?.authentication.then((googleKey) {
        tokenLogin(result.serverAuthCode!);
      }).catchError((err) {
        log('inner error');
      });
    }).catchError((err) {
      log('error occured: $err');
    });
    await userStorage.setItem(Config.social, Config.google);
  }

  Future<void> tokenLogin(String idToken) async {
    final dio = createDioWithoutToken();

    try {
      LoginRepository loginRepository = LoginRepository(dio);
      final resp = await loginRepository.getLogin(idToken);
      // token storage에 token 저장
      final at = resp.accessToken;
      final rt = resp.refreshToken;
      log('tokenLogin resp: \n rt: ${resp.refreshToken} \n at: ${resp.accessToken} ');
      await tokenStorage.write(key: 'AccessToken', value: at);
      await tokenStorage.write(key: 'RefreshToken', value: rt);

      setUserInfo(); // 유저정보 api로부터 받은 user 정보 local storage에 저장.
    } on DioException catch (e) {
      log('Error tokenLogin ${e.response}');
      return;
    }
  }

  // 최종 로그인 -> 사용자 정보 저장
  Future<void> setUserInfo() async {
    try {
      final dio = createDio();
      LoginRepository loginRepository = LoginRepository(dio);
      // 사용자 정보 요청 API
      User resp = await loginRepository.getUserInfo();

      //local storage 에 id, email, nickName 저장
      await userStorage.setItem(Config.name, resp.name);
      await userStorage.setItem(Config.email, resp.email);
      if (resp.profile_url != null) {
        await userStorage.setItem(Config.photo, resp.profile_url);
      }

      isLoginIng = false.obs;

      Get.offAllNamed(Config.routerMain);
    } on DioException catch (e) {
      log('login $e');
      return;
    }
  }

  // 로그인 여부 확인
  Future<void> checkLogin() async {
    isLoginIng = true.obs;
    // 토근 재발급

    if (getUserEmail().isEmpty) {
      log('checkLogin - No UserEmail 로그인 상태 아님');
      // 정보 없음 = 이미 로그아웃인 상태
      // 로그인 화면으로 돌아감
      isLoginIng = false.obs;
      return;
    }

    // 로그아웃 아닌 상태
    // 1. RT 만료 x 로그인 전적
    // 2. RT 만료 O 로그인 전적
    try {
      // reissue token
      final dio = createDioWithoutToken();
      LoginRepository loginRepository = LoginRepository(dio);

      final refreshToken = await getRT();
      final resp = await loginRepository.getRefreshToken(refreshToken);

      final at = resp.accessToken;
      final rt = resp.refreshToken;

      // storage 에 새로운 token 저장
      await tokenStorage.write(key: 'AccessToken', value: at);
      await tokenStorage.write(key: 'RefreshToken', value: rt);

      setUserInfo();

      // 메인화면으로 이동
      // Get.offAllNamed(Config.routerMain);
    } on DioException catch (e) {
      log('checkLogin:: ${e.response}');

      if (e.response?.statusCode == 401) {
        log('checkLogin - 4xx번 Err 로그인 상태 아님');
        // RT 만료 외의 오류
        handleLogout();
      }

      if (e.response!.statusCode! == 499) {
        log('checkLogin - RT 만료');
        loginGoogle();
      }
      return;
    }
  }

  // 로그아웃
  void handleLogout() async {
    // 소셜 로그인 플랫폼 로그아웃
    final social = await userStorage.getItem(Config.social);
    if (social == Config.google) {
      // 구글 로그아웃
      await GoogleSignIn().signOut();
    }

    // 저장해둔 회원 정보 삭제
    await tokenStorage.delete(key: 'AccessToken');
    await tokenStorage.delete(key: 'RefreshToken');

    await userStorage.deleteItem(Config.name);
    await userStorage.deleteItem(Config.email);
    await userStorage.deleteItem(Config.photo);
    await userStorage.deleteItem(Config.social);

    // 다른 페이지에서 로그아웃 요청 -> 로그인 페이지로 이동
    // 로그인 페이지에서 로그인 여부 확인 후 로그인 상태 아니어서 로그아웃 요청 -> 페이지 이동 x
    isLoginIng.value = false;
    if (!Get.currentRoute.contains(Config.routerLogin)) {
      Get.offAllNamed(Config.routerLogin);
    }
  }
}
