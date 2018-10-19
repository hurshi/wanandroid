import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/common/Router.dart';
import 'package:wanandroid/common/User.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/api/CommonService.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  double _screenWidth = MediaQueryData.fromWindow(ui.window).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(GlobalConfig.mineTab),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildHead(context),
        Expanded(
          child: User().isLogin()
              ? _buildMineBody()
              : EmptyHolder(
                  msg: "要查看收藏的文章请先登录哈",
                ),
        ),
      ],
    );
  }

  Widget _buildHead(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
      color: GlobalConfig.colorPrimary,
      child: Container(
        decoration: BoxDecoration(color: GlobalConfig.colorPrimary),
        child: GestureDetector(
          onTap: () {
            if (User().isLogin())
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
      ),
    );
  }

  void _toLogin(BuildContext context) async {
    await Router().openLogin(context);
    User().refreshUserData(callback: () {
      setState(() {});
    });
  }

  Widget _buildAvatar() {
    return Center(
      child: Container(
        width: _screenWidth / 3,
        height: _screenWidth / 3,
        decoration: BoxDecoration(
          color: const Color(0xffffff),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
//                "${Api.AVATAR_GITHUB}${getUserName().hashCode.toString()}.png"),
                "${Api.AVATAR_CODING}${getUserName().hashCode % 20 + 1}.png"),
//                "${Api.AVATAR_LEGO}${getUserName().hashCode.toString().substring(0, 1)}.jpg"),
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
          elevation: 0.0,
          child: Text("OK"),
          color: Colors.transparent,
          onPressed: () {
            User().logout();
            User().refreshUserData(callback: () {
              setState(() {});
            });
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          elevation: 0.0,
          color: Colors.transparent,
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
    return (!User().isLogin()) ? "Login" : User().userName;
  }

  Widget _buildMineBody() {
    return ItemListPage(
      keepAlive: true,
      request: (page) {
        return CommonService().getCollectListData(page);
      },
    );
  }
}
