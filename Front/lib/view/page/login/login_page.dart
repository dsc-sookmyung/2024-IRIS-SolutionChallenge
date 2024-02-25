import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/view/controller/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = Get.put(LoginController());
  Future<void> _initCheckLogin() async {
    // 로그인 여부 확인
    await Get.find<LoginController>().checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _initCheckLogin(),
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Stack(
                children: [
                  Padding(
                    padding: CustomPadding.pageInsets,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "로그인/회원가입",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ]),
                          const SizedBox(
                            height: 48,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            height: 200,
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                controller.loginGoogle();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                      'http://pngimg.com/uploads/google/google_PNG19635.png',
                                      fit: BoxFit.fitHeight),
                                  const SizedBox(width: 6),
                                  const Text(
                                    "구글로 로그인하기",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Offstage(
                      offstage: !controller
                          .isLoginIng.value, // isLoginIng이 false면 감춰~
                      child: const Stack(children: <Widget>[
                        //다시 stack
                        Opacity(
                          //뿌옇게~
                          opacity: 0.5,
                          child: ModalBarrier(
                              dismissible: false, color: Colors.black), //클릭 못하게
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ]),
                    ),
                  )
                ],
              );
            }));
  }
}
