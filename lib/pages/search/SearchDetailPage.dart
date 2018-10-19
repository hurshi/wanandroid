import 'package:flutter/material.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/widget/BackBtn.dart';
import 'package:wanandroid/widget/ClearableInputField.dart';

class SearchDetailPage extends StatefulWidget {
  SearchDetailPage();

  @override
  State<StatefulWidget> createState() => new _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  String _key = "";
  ItemListPage _itemListPage;
  final String loadingMsg = "Search whatever you want";
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _itemListPage = ItemListPage(
        emptyMsg: "It's empty.",
        request: (page) {
          return CommonService().getSearchListData(_key, page);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _itemListPage,
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    var originTheme = Theme.of(context);
    return AppBar(
      leading: BackBtn(),
      title: Theme(
          data: originTheme.copyWith(
            hintColor: GlobalConfig.color_white_a80,
            textTheme: TextTheme(subhead: TextStyle(color: Colors.white)),
          ),
          child: ClearableInputField(
            hintTxt: loadingMsg,
            controller: _controller,
            border: InputBorder.none,
            onchange: (str) {
              _key = str;
              _itemListPage.handleRefresh();
            },
          )),
    );
  }
}
