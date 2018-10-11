import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:wanandroid/pages/web/WebViewPage.dart';
import 'package:wanandroid/pages/search/SearchDetailPage.dart';

class Router {
  openWeb(BuildContext context, String url, String title) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        transitionsBuilder: _transitionsBuilder,
        pageBuilder: (BuildContext context, _, __) {
          return WebViewPage(url, title);
        }));
  }

  openSearch(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        transitionsBuilder: _transitionsBuilder,
        pageBuilder: (BuildContext context, _, __) {
          return SearchDetailPage();
        }));
  }

  Widget _transitionsBuilder(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
      opacity: animation,
      child: new FadeTransition(
        opacity: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: child,
      ),
    );
  }
}
