import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/pages/Application.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '玩安卓',
      theme: new ThemeData(
        primarySwatch: GloableConfig.colorPrimary,
      ),
      home: new ApplicationPage(),
    );
  }
}
