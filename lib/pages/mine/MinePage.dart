import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/common/Sp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/common/Router.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  String _userName = "";
  String _password = "";
  double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;

  @override
  Widget build(BuildContext context) {
    _initData();
    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalConfig.mineTab),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  void _initData() {
    Sp.getS("userName", (str) {
      this._userName = str;
      setState(() {});
    });
    Sp.getS("password", (pw) {
      this._password = pw;
    });
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildHead(context),
      ],
    );
//    return Center(
//      child: Text("我"),
//    );
  }

  bool isLogined() {
    return _userName.length > 0 && _password.length > 0;
  }

  Widget _buildHead(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: GlobalConfig.colorPrimary),
      child: GestureDetector(
        onTap: () {
          Router().openLogin(context);
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
              child: _buildAvatar(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: _buildUserName(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: CircleAvatar(
        radius: screenWidth / 6,
        backgroundColor: Colors.white,
        child: SvgPicture.network(
          "${Api.AVATAR_MALE}${getUserName().hashCode}.svg",
          width: screenWidth / 3,
          height: screenWidth / 3,
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return Center(
      child: Text(
        getUserName(),
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.white, fontSize: 30.0),
      ),
    );
  }

  String getUserName() {
    return null == _userName ? "Login" : _userName;
  }
}
