import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/common/Router.dart';
import 'package:wanandroid/common/Sp.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  //}with WidgetsBindingObserver {
  String _userName;

  String _password;

  double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;

//  @override
//  void initState() {
//    super.initState();
//    WidgetsBinding.instance.addObserver(this);
//  }
//
//  @override
//  void dispose() {
//    WidgetsBinding.instance.removeObserver(this);
//    super.dispose();
//  }

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

//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) {
//    super.didChangeAppLifecycleState(state);
//    print(">>> didChangeAppLifecycleState");
//    if (AppLifecycleState.resumed == state) {
//      _userName = null;
//      _initData();
//    }
//  }

  void _initData() {
    if (null == _userName)
      Sp.getUserName((str) {
        if (null == str) {
          this._userName = "";
        } else {
          this._userName = str;
          setState(() {});
        }
      });
    if (null == _password)
      Sp.getPassword((pw) {
        this._password = pw;
      });
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildHead(context),
        isLogined()
            ? _buildMineBody()
            : EmptyHolder(
                msg: "请先登录",
              ),
      ],
    );
  }

  bool isLogined() {
    return null != _userName &&
        _userName.length >= 6 &&
        null != _password &&
        _password.length >= 6;
  }

  Widget _buildHead(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: GlobalConfig.colorPrimary),
      child: GestureDetector(
        onTap: () {
          if (isLogined())
            _showLogout(context);
          else {
            _toLogin(context);
          }
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

  void _toLogin(BuildContext context) async {
    await Router().openLogin(context);
    _userName = null;
    _initData();
  }

  Widget _buildAvatar() {
    return Center(
      child: Container(
        width: screenWidth / 3,
        height: screenWidth / 3,
        decoration: BoxDecoration(
          color: const Color(0xffffff),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
                "${Api.AVATAR_LEGO}${getUserName().hashCode.toString().substring(0, 1)}.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(new Radius.circular(500.0)),
        ),
      ),
    );
  }

  Future<Null> _showLogout(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return _buildLogout(context);
        });
  }

  Widget _buildLogout(BuildContext context) {
    return AlertDialog(
      content: Text("确定退出登录？"),
      actions: <Widget>[
        RaisedButton(
          child: Text("OK"),
          onPressed: () {
            Sp.putUserName("");
            Sp.putPassword("");
            _userName = null;
            _initData();
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          child: Text("No No No"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
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
    return (!isLogined()) ? "Login" : _userName;
  }

  Widget _buildMineBody() {
    return Text("OKOK，你已经登录啦");
  }
}
