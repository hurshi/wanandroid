import 'package:flutter/material.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/mpwechat/MpWechatModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/widget/ClearableInputField.dart';
import 'package:wanandroid/common/GlobalConfig.dart';

import 'dart:async';

class MpWechatSinglePage extends StatefulWidget {
  final bool keepAlive;
  final MpWechatModel model;

  MpWechatSinglePage({this.keepAlive, this.model});

  @override
  State<StatefulWidget> createState() => _MpWechatSinglePageState();
}

class _MpWechatSinglePageState extends State<MpWechatSinglePage>
    with AutomaticKeepAliveClientMixin {
  var _controller = TextEditingController();
  String _key = "";
  ItemListPage _itemListPage;
  String loadingMsg = "搜索本公众号里面的历史文章";
  GlobalKey _headKey = GlobalKey();

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      _itemListPage?.handleScroll(
          _headKey.currentContext?.findRenderObject()?.paintBounds?.height);
    });
  }

  @override
  Widget build(BuildContext context) {
    _itemListPage = ItemListPage(
        header: Card(
          key: _headKey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          margin: EdgeInsets.all(0.0),
          elevation: 4.0,
          color: GlobalConfig.colorPrimary,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: getSearchView(),
          ),
        ),
        emptyMsg: "臣妾搜不到呀",
        request: (page) {
          return CommonService().getMpWechatListData(
              "${Api.MP_WECHAT_LIST}${widget.model.id}/$page/json?k=$_key");
        });
    return _itemListPage;
  }

  Widget getSearchView() {
    var originTheme = Theme.of(context);
    return Theme(
        data: originTheme.copyWith(
          hintColor: GlobalConfig.color_white_a80,
          textTheme: TextTheme(subhead: TextStyle(color: Colors.white)),
        ),
        child: ClearableInputField(
          hintTxt: loadingMsg,
          controller: _controller,
          autoFocus: false,
          showPrefixIcon: true,
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Colors.white, style: BorderStyle.solid),
          ),
          hintStyle: TextStyle(fontSize: 13.0),
          onchange: (str) {
            _key = str;
            _itemListPage.handleRefresh();
          },
        ));
  }
}
