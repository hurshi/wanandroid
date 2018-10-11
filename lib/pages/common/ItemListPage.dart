import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';
import 'package:wanandroid/model/list_item/BlogListModel.dart';
import 'package:wanandroid/common/Router.dart';
import 'package:wanandroid/widget/Loading.dart';

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
  bool get wantKeepAlive {
    print(">>> wantKeepAlive");
    return widget.keepAlive;
  }

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
      return Loading(
        msg: (widget.emptyMsg == null)
            ? (_haveMoreData ? "loading" : "not found")
            : widget.emptyMsg,
      );
    }
    return RefreshIndicator(
      color: GlobalConfig.colorPrimary,
      onRefresh: handleRefresh,
      child: ListView.builder(
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
              return _buildListViewItemLayout(context, index - 1);
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
    BlogListDataItemModel item = _listData[index];
    return GestureDetector(
      onTap: () {
        Router().openWeb(context, item.link, item.title);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 2.5, 5.0, 2.5),
        child: Card(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
            child: _buildListViewItem(item),
          ),
        ),
      ),
    );
  }

  Widget _buildListViewItem(BlogListDataItemModel item) {
    var widget = (null != item.envelopePic && item.envelopePic.isNotEmpty)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: _buildItemLeftSide(item),
              ),
              Container(
                width: 30.0,
                child: Image.network(item.envelopePic),
              )
            ],
          )
        : _buildItemLeftSide(item);

    return widget;
  }

  Widget _buildItemLeftSide(BlogListDataItemModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
          child: Text(item.author),
        ),
        Text(
          //去掉html中的高亮
          item.title.replaceAll(RegExp("(<em[^>]*>)|(</em>)"), ""),
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
          child: Text("${item.niceDate}  ${item.superChapterName}"),
        )
      ],
    );
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
