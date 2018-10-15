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
  State<StatefulWidget> createState() => _MpWechatSinglePageState();
}

class _MpWechatSinglePageState extends State<MpWechatSinglePage>
    with AutomaticKeepAliveClientMixin {
  SearchBar _searchbar;
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
    _initSearchBar();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _searchbar.build(context),
        Expanded(
          child: _itemListPage,
        )
      ],
    );
  }

  void _initSearchBar() {
    var _controller = TextEditingController();
    _controller.addListener(() {
      if (_key != _controller.value.text) {
        _key = _controller.value.text;
        _itemListPage.handleRefresh();
      }
    });
    _searchbar = SearchBar(
      setState: setState,
      onSubmitted: print,
      showClearButton: true,
      closeOnSubmit: false,
      hintText: loadingMsg,
      clearOnSubmit: false,
      elevation: 0,
      showBackButton: false,
      autoShowKeyboard: false,
      clearButtonColor: Colors.black87,
      clearButtonDisablesColor: Colors.black45,
      textColor: Colors.black,
      bgColor: Color.fromARGB(255, 250, 250, 250),
      controller: _controller,
    );
  }
}
