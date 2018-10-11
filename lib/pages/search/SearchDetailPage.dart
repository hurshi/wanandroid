import 'package:flutter/material.dart';

import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/widget/SearchBar.dart';

class SearchDetailPage extends StatefulWidget {
  SearchDetailPage();

  @override
  State<StatefulWidget> createState() => new _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  SearchBar _searchbar;
  String _key = "";
  ItemListPage _itemListPage;
  final String loadingMsg = "Search whatever you want";

  @override
  void initState() {
    super.initState();
    _initSearchBar();
    _itemListPage = ItemListPage(
        emptyMsg: "It's empty.",
        request: (page) {
          return CommonService().getSearchListData(_key, page);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _searchbar.build(context),
      body: _itemListPage,
    );
  }

  void _initSearchBar() {
    var _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        _key = _controller.value.text;
      });
      _itemListPage.handleRefresh();
    });
    _searchbar = SearchBar(
      setState: setState,
      onSubmitted: print,
      showClearButton: true,
      closeOnSubmit: false,
      hintText: loadingMsg,
      clearOnSubmit: false,
      controller: _controller,
    );
  }
}
