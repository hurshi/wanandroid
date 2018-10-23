import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/pages/Application.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '玩安卓',
      theme: ThemeData(
        fontFamily: "noto",
        primaryColor: GlobalConfig.colorPrimary,
      ),
      home: ApplicationPage(),
    );
  }
}
