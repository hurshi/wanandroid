import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/pages/web/Web.dart';
import 'package:wanandroid/model/list_item/BlogListModel.dart';

typedef Future<Response> RequestData(int page);

class ItemListPage extends StatefulWidget {
  final Widget header;
  final RequestData request;

  ItemListPage({this.header, this.request});

  @override
  State<StatefulWidget> createState() {
    return new _ItemListPageState();
  }
}

class _ItemListPageState extends State<ItemListPage> {
  List<BlogListDataItemModel> _listData = List();
  int _listDataPage = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadListData(_listDataPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 1) {
        _listDataPage++;
        _loadListData(_listDataPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: GlobalConfig.colorPrimary,
      onRefresh: _handleRefresh,
      child: ListView.builder(
          itemCount: ((null == _listData) ? 0 : _listData.length) +
              (null == widget.header ? 1 : 2),
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
        Web().open(context, item.link, item.title);
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
          item.title,
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

  Future<Null> _handleRefresh() async {
    _listDataPage = 0;
    _listData.clear();
    await _loadListData(_listDataPage);
  }

  Future<Null> _loadListData(int page) {
    return widget.request(page).then((response) {
      setState(() {
        _listData.addAll(BlogListModel.fromJson(response.data).data.datas);
      });
    });
  }
}
