import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/common/Router.dart';
import 'package:wanandroid/common/User.dart';
import 'package:wanandroid/pages/article_list/ArticleListPage.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';
import 'package:wanandroid/widget/QuickTopFloatBtn.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  double _screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
  GlobalKey<QuickTopFloatBtnState> _quickTopFloatBtnKey = new GlobalKey();
  ArticleListPage _itemListPage;
  GlobalKey<ArticleListPageState> _itemListPageKey = new GlobalKey();
  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = FixedExtentScrollController();
    return Scaffold(
      body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: _screenWidth * 2 / 3,
                forceElevated: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: _buildHead(context),
                    title: Text(getUserName())),
              ),
            ];
          },
          body: User().isLogin()
              ? _buildMineBody()
              : EmptyHolder(
                  msg: "要查看收藏的文章请先登录哈",
                )),
      floatingActionButton: QuickTopFloatBtn(
        key: _quickTopFloatBtnKey,
        onPressed: () {
          _itemListPageKey.currentState
              ?.handleScroll(0.0, controller: _controller);
        },
      ),
    );
  }

  Widget _buildHead(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: GlobalConfig.colorPrimary),
      child: GestureDetector(
        onTap: () {
          if (User().isLogin())
            _showLogout(context);
          else {
            _toLogin(context);
          }
        },
        child: _buildAvatar(),
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
          textColor: GlobalConfig.colorPrimary,
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
          textColor: GlobalConfig.colorPrimary,
          child: Text("No No No"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  String getUserName() {
    return (!User().isLogin()) ? "Login" : User().userName;
  }

  Widget _buildMineBody() {
    if (null == _itemListPage) {
      _itemListPage = ArticleListPage(
        key: _itemListPageKey,
        keepAlive: true,
        selfControl: false,
        showQuickTop: (show) {
          _quickTopFloatBtnKey.currentState.refreshVisible(show);
        },
        request: (page) {
          return CommonService().getCollectListData(page);
        },
      );
    }
    return _itemListPage;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
