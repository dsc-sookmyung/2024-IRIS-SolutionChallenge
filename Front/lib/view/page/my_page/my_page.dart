import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/utils/user_profile_utils.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/login/login_controller.dart';
import 'package:iris_flutter/view/page/my_page/bookmark_post.dart';
import 'package:iris_flutter/view/page/my_page/my_posts.dart';
import 'package:iris_flutter/view/page/my_page/my_comments.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final controller = Get.find<LoginController>();

    return Scaffold(
        appBar: customAppBar(title: "마이페이지"),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  onTap: () {
                    // 사용자 사진 변경?;
                  },
                  leading: CircleAvatar(
                    backgroundImage: getUserPhoto() != ''
                        ? NetworkImage(getUserPhoto())
                        : const AssetImage('assets/images/logo.png')
                            as ImageProvider,
                  ),
                  title: getUserDisplayName() != ''
                      ? Text(getUserDisplayName())
                      : const Text(
                          "사용자 이름을 등록해주세요.",
                          style: TextStyle(color: Colors.grey),
                        ),
                  subtitle: getUserEmail() != ''
                      ? Text(getUserEmail())
                      : const Text(" "),
                ),
                const Padding(padding: CustomPadding.regularBottom),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "글 관리",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 6),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  onTap: () {
                    Get.to(() => const MyPosts());
                  },
                  leading: Icon(
                    Icons.people,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  title: const Text("작성한 실종 정보"),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  onTap: () {
                    Get.to(() => const MyComments());
                  },
                  leading: const Icon(Icons.chat),
                  title: const Text("작성한 제보 댓글"),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  onTap: () {
                    Get.to(() => const BookmarkPost());
                  },
                  leading: const Icon(Icons.bookmark),
                  title: const Text("북마크한 실종 정보"),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "앱 설정",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 6),
                // SwitchListTile(
                //   title: const Text("알림"),
                //   value: isSwitched,
                //   tileColor: Theme.of(context).colorScheme.surfaceVariant,
                //   shape: const RoundedRectangleBorder(
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(15),
                //           topRight: Radius.circular(15))),
                //   onChanged: (value) {
                //     setState(() {
                //       isSwitched = value;
                //       print(isSwitched);
                //     });
                //   },
                //   secondary: const Icon(Icons.notifications),
                // ),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  onTap: () {
                    controller.handleLogout();
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  leading: const Icon(Icons.logout),
                  title: const Text("로그아웃"),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceVariant,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  onTap: () {
                    print("탈퇴하기");
                  },
                  leading: const Icon(Icons.person_off_rounded),
                  title: const Text("탈퇴하기"),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                )
              ]),
        ));
  }
}
