import 'dart:async';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';
import 'package:wanandroid/model/list_item/BlogListModel.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';

import 'BlogArticleItem.dart';

typedef Future<Response> RequestData(int page);
typedef void ShowQuickTop(bool show);

class ItemListPage extends StatefulWidget {
  final Widget header;
  final RequestData request;
  final String emptyMsg;
  final bool keepAlive;
  final ShowQuickTop showQuickTop;
  final bool selfControl;

  _ItemListPageState _itemListPageState;

  ItemListPage(
      {this.header,
      @required this.request,
      this.emptyMsg,
      this.selfControl = true,
      this.showQuickTop,
      this.keepAlive = false});

  void handleRefresh() {
    _itemListPageState.handleRefresh();
  }

  void handleScroll(double offset, {ScrollController controller}) {
    _itemListPageState?.handleScroll(offset, controller);
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
  var _haveMoreData = true;
  double _screenHeight;

  ListView listView;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  void handleScroll(double offset, ScrollController cer) {
    ((null == cer) ? _controller : cer)?.animateTo(offset,
        duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    var itemCount = ((null == _listData) ? 0 : _listData.length) +
        (null == widget.header ? 0 : 1) +
        (_haveMoreData ? 1 : 0);
    if (itemCount <= 0) {
      return EmptyHolder(
        msg: (widget.emptyMsg == null)
            ? (_haveMoreData ? "loading" : "not found")
            : widget.emptyMsg,
      );
    }
    listView = ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: itemCount,
        controller: getControllerForListView(),
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
        });

    return NotificationListener<ScrollNotification>(
      onNotification: onScrollNotification,
      child: RefreshIndicator(
        child: listView,
        color: GlobalConfig.colorPrimary,
        onRefresh: handleRefresh,
      ),
    );
  }

  bool onScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.pixels >=
        scrollNotification.metrics.maxScrollExtent) {
      _loadNextPage();
    }
    if (null != widget.showQuickTop) {
      if (null == _screenHeight || _screenHeight <= 0) {
        _screenHeight = MediaQueryData.fromWindow(ui.window).size.height;
      }
      if (scrollNotification.metrics.axisDirection == AxisDirection.down &&
          _screenHeight >= 10 &&
          scrollNotification.metrics.pixels >= _screenHeight) {
        widget.showQuickTop(true);
      } else {
        widget.showQuickTop(false);
      }
    }
    return false;
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

  bool isLoading = false;

  Future<Null> _loadNextPage() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    _listDataPage++;
    var result = await _loadListData(_listDataPage);
    //至少加载8个，如果初始化加载不足，则加载下一页,如果使用递归的话需要考虑中止操作
    if (_listData.length < 8) {
      _listDataPage++;
      result = await _loadListData(_listDataPage);
    }
    setState(() {});
    isLoading = false;
    return result;
  }

  ScrollController _controller;

  ScrollController getControllerForListView() {
    if (widget.selfControl) {
      if (null == _controller) _controller = ScrollController();
      return _controller;
    } else {
      return null;
    }
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
