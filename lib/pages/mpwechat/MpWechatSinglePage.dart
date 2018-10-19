import 'package:flutter/material.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/mpwechat/MpWechatModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/widget/ClearableInputField.dart';
import 'package:wanandroid/common/GlobalConfig.dart';

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

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void initState() {
    super.initState();
    _itemListPage = ItemListPage(
        emptyMsg: "臣妾搜不到呀",
        request: (page) {
          return CommonService().getMpWechatListData(
              "${Api.MP_WECHAT_LIST}${widget.model.id}/$page/json?k=$_key");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
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
        Expanded(
          child: _itemListPage,
        )
      ],
    );
  }

  Widget getSearchView() {
    Color fillColor = Colors.white;
    return ClearableInputField(
      hintTxt: loadingMsg,
      autoFocus: false,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      controller: _controller,
      border: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
              style: BorderStyle.none, color: fillColor, width: 0.0)),
      fillColor: fillColor,
      onchange: (str) {
        _key = str;
        _itemListPage.handleRefresh();
      },
    );
  }
}
