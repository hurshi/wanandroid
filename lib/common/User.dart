import 'package:wanandroid/common/Sp.dart';

class User {
  String userName;
  String password;

  static final User _singleton = User._internal();

  factory User() {
    return _singleton;
  }

  User._internal();

  bool isLogin() {
    return null != userName &&
        userName.length >= 6 &&
        null != password &&
        password.length >= 6;
  }

  void logout() {
    Sp.putUserName(null);
    Sp.putPassword(null);
    userName = null;
    password = null;
  }

  void refreshUserData({Function callback}) {
    Sp.getPassword((pw) {
      this.password = pw;
    });
    Sp.getUserName((str) {
      this.userName = str;
      if (null != callback) {
        callback();
      }
    });
  }
}
