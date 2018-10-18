import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';
import 'package:wanandroid/model/list_item/BlogListModel.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';

import 'BlogArticleItem.dart';

typedef Future<Response> RequestData(int page);

class ItemListPage extends StatefulWidget {
  final Widget header;
  final RequestData request;
  final String emptyMsg;
  final bool keepAlive;

  _ItemListPageState _itemListPageState;

  ItemListPage(
      {this.header,
      @required this.request,
      this.emptyMsg,
      this.keepAlive = false});

  void handleRefresh() {
    _itemListPageState.handleRefresh();
  }

  @override
  State<StatefulWidget> createState() {
    _itemListPageState = _ItemListPageState();
    return _itemListPageState;
  }
}

class _ItemListPageState extends State<ItemListPage>
    with AutomaticKeepAliveClientMixin {
  List<BlogListDataItemModel> _listData = List();
  int _listDataPage = -1;
  ScrollController _scrollController = ScrollController();
  var _haveMoreData = true;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void initState() {
    super.initState();
    _loadNextPage();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 1) {
        _loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_listData.length <= (_haveMoreData ? 1 : 0)) {
      return EmptyHolder(
        msg: (widget.emptyMsg == null)
            ? (_haveMoreData ? "loading" : "not found")
            : widget.emptyMsg,
      );
    }
    return RefreshIndicator(
      color: GlobalConfig.colorPrimary,
      onRefresh: handleRefresh,
      child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: ((null == _listData) ? 0 : _listData.length) +
              (null == widget.header ? 0 : 1) +
              (_haveMoreData ? 1 : 0),
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index == 0 && null != widget.header) {
              return widget.header;
            } else if (index - (null == widget.header ? 0 : 1) >=
                _listData.length) {
              return _buildLoadMoreItem();
            } else {
              return _buildListViewItemLayout(
                  context, index - (null == widget.header ? 0 : 1));
            }
          }),
    );
  }

  Widget _buildListViewItemLayout(BuildContext context, int index) {
    if (null == _listData ||
        _listData.length <= 0 ||
        index < 0 ||
        index >= _listData.length) {
      return Container();
    }
    return BlogArticleItem(_listData[index]);
  }

  Widget _buildLoadMoreItem() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("loading ..."),
      ),
    );
  }

  Future<Null> handleRefresh() async {
    _listDataPage = -1;
    _listData.clear();
    await _loadNextPage();
  }

  Future<Null> _loadNextPage() async {
    _listDataPage++;
    var result = await _loadListData(_listDataPage);
    //至少加载8个，如果初始化加载不足，则加载下一页,如果使用递归的话需要考虑中止操作
    if (_listData.length < 8) {
      _listDataPage++;
      result = await _loadListData(_listDataPage);
    }
    setState(() {});
    return result;
  }

  Future<Null> _loadListData(int page) {
    _haveMoreData = true;
    return widget.request(page).then((response) {
      var newList = BlogListModel.fromJson(response.data).data.datas;
      if (null != newList && newList.length > 0) {
        _listData.addAll(newList);
      } else {
        _haveMoreData = false;
      }
    });
  }
}
