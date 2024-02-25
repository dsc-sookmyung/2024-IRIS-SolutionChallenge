import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/view/page/form/post_form/post_form_page.dart';
import 'package:iris_flutter/view/page/login/login_page.dart';
import 'package:iris_flutter/view/page/main/main_page.dart';
import 'package:iris_flutter/view/page/my_page/my_page.dart';
import 'package:iris_flutter/view/page/post/post_page.dart';
import 'package:iris_flutter/view/page/form/comment_form/comment_form_page.dart';
import 'package:localstorage/localstorage.dart';

// token 저장하는 secure storage
FlutterSecureStorage tokenStorage = const FlutterSecureStorage();
// 회원 정보 저장하는 local storage: id, email, nickName
LocalStorage userStorage = LocalStorage('user');

class Config {
  // gender
  static bool man = false;
  static bool woman = true;

  String getGenderText(bool gender) {
    return gender == Config.woman ? '여자' : '남자';
  }

  // info, comment form
  static int maxImagesLength = 3;

  // Google Map zoom
  static double minZoom = 16;
  static double maxZoom = 19;
  static double initZoom = 17;

  static int filterCriteria = 60;

  static final routers = [
    GetPage(
        name: routerLogin,
        page: () => const LoginPage(),
        transition: Transition.noTransition),
    GetPage(
        name: routerMain,
        page: () => const MainPage(),
        transition: Transition.noTransition),
    GetPage(
        name: routerPostForm,
        page: () => const PostFormPage(),
        transition: Transition.noTransition),
    GetPage(
        name: routerPost,
        page: () => const PostPage(),
        transition: Transition.noTransition),
    GetPage(
        name: routerCommentForm,
        page: () => const CommentFormPage(),
        transition: Transition.noTransition),
    GetPage(
        name: routerMyPage,
        page: () => const MyPage(),
        transition: Transition.noTransition),
  ];
  // routers name
  static String routerLogin = '/login';
  static String routerMain = '/main';
  static String routerPostForm = '/post_form';
  static String routerPost = '/post';
  static String routerCommentForm = '/comment_form';
  static String routerMyPage = '/my_page';

  // storage 이름
  static String email = 'email';
  static String name = 'name';
  static String photo = 'photo';
  static String social = 'social';
  static String google = 'google';
}
