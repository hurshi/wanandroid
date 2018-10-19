import 'package:flutter/material.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/mpwechat/MpWechatModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/widget/ClearableInputField.dart';

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
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          child: getSearchView(),
        ),
        Expanded(
          child: _itemListPage,
        )
      ],
    );
  }

  Widget getSearchView() {
    return ClearableInputField(
      hintTxt: loadingMsg,
      controller: _controller,
      border: InputBorder.none,
      onchange: (str) {
        _key = str;
        _itemListPage.handleRefresh();
      },
    );
  }
}
