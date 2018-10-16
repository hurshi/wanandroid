import 'package:shared_preferences/shared_preferences.dart';

class Sp {
  static put(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static getS(String key, Function callback) async {
    SharedPreferences.getInstance().then((prefs) {
      callback(prefs.getString(key));
    });
  }

  static putUserName(String value) {
    put("username", value);
  }

  static putPassword(String value) {
    put("password", value);
  }

  static putCookie(String value) {
    put("cookie", value);
  }

  static putCookieExpires(String value) {
    put("expires", value);
  }

  static getUserName(Function callback) {
    getS("username", callback);
  }

  static getPassword(Function callback) {
    getS("password", callback);
  }

  static getCookie(Function callback) {
    getS("cookie", callback);
  }

  static getCookieExpires(Function callback) {
    getS("expires", callback);
  }
}
