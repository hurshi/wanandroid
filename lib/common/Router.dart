import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:wanandroid/pages/web/WebViewPage.dart';
import 'package:wanandroid/pages/search/SearchDetailPage.dart';
import 'package:wanandroid/pages/login/LoginPage.dart';
import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';

class Router {
  openWeb(BuildContext context, String url, String title) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionsBuilder: _transitionsBuilder,
        pageBuilder: (BuildContext context, _, __) {
          return WebViewPage(url: url, title: title);
        }));
  }

  openArticle(BuildContext context, BlogListDataItemModel item) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionsBuilder: _transitionsBuilder,
        pageBuilder: (BuildContext context, _, __) {
          return WebViewPage(
            articleBean: item,
          );
        }));
  }

  openSearch(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionsBuilder: _transitionsBuilder,
        pageBuilder: (BuildContext context, _, __) {
          return SearchDetailPage();
        }));
  }

  Future<PageRouteBuilder> openLogin(BuildContext context) {
    return Navigator.of(context).push(PageRouteBuilder(
        transitionsBuilder: _transitionsBuilder,
        pageBuilder: (BuildContext context, _, __) {
          return LoginPage();
        }));
  }

  back(BuildContext context) {
    Navigator.of(context).pop();
  }

  Widget _transitionsBuilder(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: child,
      ),
    );
  }
}
