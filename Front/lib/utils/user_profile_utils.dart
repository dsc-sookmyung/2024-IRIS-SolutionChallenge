import 'package:iris_flutter/config/config.dart';

String getUserDisplayName() {
  return userStorage.getItem(Config.name) ?? '';
}

String getUserEmail() {
  return userStorage.getItem(Config.email) ?? '';
}

String getUserPhoto() {
  return userStorage.getItem(Config.photo) ?? '';
}

Future<String> getAT() async {
  return await tokenStorage.read(key: 'AccessToken') ?? '';
}

Future<String> getRT() async {
  return await tokenStorage.read(key: 'RefreshToken') ?? '';
}
