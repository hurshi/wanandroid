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
    _searchbar = SearchBar(
      setState: setState,
      onSubmitted: print,
      showClearButton: true,
      closeOnSubmit: false,
      hintText: loadingMsg,
      clearOnSubmit: false,
      onChanged: (String s) {
        setState(() {
          _key = s;
        });
        print(">>> onChanged --------------");
        _itemListPage.handleRefresh();
      },
    );

    _itemListPage = ItemListPage(request: (page) {
      print(">>> --------------  refresh body");
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
}
