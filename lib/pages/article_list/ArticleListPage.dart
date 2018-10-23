import 'dart:async';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/fonts/IconF.dart';
import 'package:wanandroid/model/article_list/ArticleItemModel.dart';
import 'package:wanandroid/model/article_list/ArticleListModel.dart';
import 'package:wanandroid/pages/article_list/ArticleItemPage.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';

typedef Future<Response> RequestData(int page);
typedef void ShowQuickTop(bool show);

class ArticleListPage extends StatefulWidget {
  final Widget header;
  final RequestData request;
  final String emptyMsg;
  final bool keepAlive;
  final ShowQuickTop showQuickTop;
  final bool selfControl;

  ArticleListPage(
      {Key key,
      this.header,
      @required this.request,
      this.emptyMsg,
      this.selfControl = true,
      this.showQuickTop,
      this.keepAlive = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ArticleListPageState();
  }
}

class ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  List<ArticleItemModel> _listData = List();

  int _listDataPage = -1;
  var _haveMoreData = true;
  double _screenHeight;
  var _topFloatBtnShowing = false;
  ListView listView;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  void handleScroll(double offset, {ScrollController controller}) {
    ((null == controller) ? _controller : controller)?.animateTo(offset,
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

    var body = NotificationListener<ScrollNotification>(
      onNotification: onScrollNotification,
      child: RefreshIndicator(
        child: listView,
        color: GlobalConfig.colorPrimary,
        onRefresh: handleRefresh,
      ),
    );
    return (null == widget.showQuickTop)
        ? Scaffold(
            resizeToAvoidBottomPadding: false,
            body: body,
            floatingActionButton: _topFloatBtnShowing
                ? (FloatingActionButton(
                    backgroundColor: Colors.white,
                    foregroundColor: GlobalConfig.colorPrimary,
                    child: Icon(IconF.top),
                    onPressed: () {
                      handleScroll(0.0);
                    }))
                : null,
          )
        : body;
  }

  bool onScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.pixels >=
        scrollNotification.metrics.maxScrollExtent) {
      _loadNextPage();
    }
    if (null == _screenHeight || _screenHeight <= 0) {
      _screenHeight = MediaQueryData.fromWindow(ui.window).size.height;
    }
    if (scrollNotification.metrics.axisDirection == AxisDirection.down &&
        _screenHeight >= 10 &&
        scrollNotification.metrics.pixels >= _screenHeight) {
      if (null != widget.showQuickTop) {
        widget.showQuickTop(true);
      } else if (!_topFloatBtnShowing) {
        if (this.mounted)
          setState(() {
            _topFloatBtnShowing = true;
          });
      }
    } else {
      if (null != widget.showQuickTop) {
        widget.showQuickTop(false);
      } else if (_topFloatBtnShowing) {
        if (this.mounted)
          setState(() {
            _topFloatBtnShowing = false;
          });
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
    return ArticleItemPage(_listData[index]);
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
    if (isLoading || !this.mounted) {
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
    if (this.mounted) setState(() {});
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
      var newList = ArticleListModel.fromJson(response.data).data.datas;
      if (null != newList && newList.length > 0) {
        _listData.addAll(newList);
      } else {
        _haveMoreData = false;
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _listData?.clear();
    super.dispose();
  }
}
