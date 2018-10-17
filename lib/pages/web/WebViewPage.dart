import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid/common/StringUtil.dart';
import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';
import 'package:wanandroid/fonts/IconF.dart';
import 'package:wanandroid/widget/BackBtn.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final BlogListDataItemModel articleBean;

  WebViewPage({this.url, this.title, this.articleBean});

  @override
  State<StatefulWidget> createState() => new _WebViewState();

  String getUrl() {
    return (!StringUtil.isNullOrEmpty(url))
        ? url
        : ((null != articleBean) ? articleBean.link : "");
  }

  String getTitle() {
    return (!StringUtil.isNullOrEmpty(title))
        ? title
        : ((null != articleBean) ? articleBean.title : "");
  }
}

class _WebViewState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
//      headers: User().getHeader(),
      url: widget.getUrl(),
      appBar: AppBar(
        title: Text(widget.getTitle()),
        leading: BackBtn(),
        actions: <Widget>[
          _buildStared(),
        ],
      ),
    );
  }

  Widget _buildStared() {
    if (null == widget.articleBean) {
      return Text("");
    } else
      return IconButton(
        icon: Icon(
          (widget.articleBean.collect) ? IconF.like_fill : IconF.like_stroke,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            widget.articleBean.collect = !widget.articleBean.collect;
          });
        },
      );
  }
}
