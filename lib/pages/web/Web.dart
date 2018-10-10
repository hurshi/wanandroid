import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'WebViewPage.dart';

class Web {
  open(BuildContext context, String url, String title) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new FadeTransition(
              opacity:
                  new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
        pageBuilder: (BuildContext context, _, __) {
          return WebViewPage(url, title);
        }));
  }

  Widget _buildAppbar(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
//        CupertinoActivityIndicator(),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
