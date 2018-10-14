import 'package:flutter/material.dart';
import 'package:wanandroid/model/mpwechat/MpWechatModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/widget/SearchBar.dart';
import 'package:wanandroid/api/CommonService.dart';

class MpWechatSinglePage extends StatefulWidget {
  final bool keepAlive;
  final MpWechatModel model;

  MpWechatSinglePage({this.keepAlive, this.model});

  @override
  State<StatefulWidget> createState() {
    return _MpWechatSinglePageState();
  }
}

class _MpWechatSinglePageState extends State<MpWechatSinglePage>
    with AutomaticKeepAliveClientMixin {
  String _key = "";
  ItemListPage _itemListPage;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void initState() {
    super.initState();
    _itemListPage = ItemListPage(
//      header: _buildSearchView(_itemListPage, _key),
      keepAlive: widget.keepAlive,
      request: (page) {
        print(">>> call request page=$page key=$_key");
        return CommonService().getMpWechatListData(
            "${Api.MP_WECHAT_LIST}${widget.model.id}/$page/json?k=$_key");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSearchView(context),
        Expanded(
          child: _itemListPage,
        )
      ],
    );
  }

  Widget _buildSearchView(BuildContext context) {
//    var _controller = TextEditingController();
//    _controller.addListener(() {
//      _key = _controller.value.text;
//      _itemListPage.handleRefresh();
//    });
    return SearchBar(
      setState: setState,
      onSubmitted: print,
      showClearButton: true,
      closeOnSubmit: false,
      textColor: Colors.black,
      hintText: "搜索本公众号内的文章",
      clearOnSubmit: false,
      showBackButton: false,
      bgColor: Colors.white,
      clearButtonColor: Colors.black87,
      clearButtonDisablesColor: Colors.black45,
      autoShowKeyboard: false,
//      controller: _controller,
    ).build(context);
  }
}
