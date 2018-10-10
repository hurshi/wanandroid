import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wanandroid/model/homebanner/HomeBannerModel.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/homebanner/HomeBannerItemModel.dart';
import 'package:wanandroid/widget/BannerView.dart';
import 'package:wanandroid/model/homelist/HomeListModel.dart';
import 'package:wanandroid/model/homelist/HomeListDataItemModel.dart';
import 'package:wanandroid/common/GlobalConfig.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<HomeBannerItemModel> _bannerData;
  List<HomeListDataItemModel> _listData = List();
  int _listDataPage = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadBannerData();
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
          itemCount: ((null == _listData) ? 0 : _listData.length) + 2,
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildBanner();
            } else if (index - 1 >= _listData.length) {
              return _buildLoadMoreItem();
            } else {
              return _buildListViewItemLayout(index - 1);
            }
          }),
    );
  }

  Widget _buildBanner() {
    if (null == _bannerData || _bannerData.length <= 0) {
      return Center(
        child: Text("loading"),
      );
    } else
      return BannerView<HomeBannerItemModel>(
        data: _bannerData,
        delayTime: 10,
        buildShowView: (index, data) {
          return Image.network((data as HomeBannerItemModel).imagePath);
        },
      );
  }

  Widget _buildListViewItemLayout(int index) {
    if (null == _listData ||
        _listData.length <= 0 ||
        index < 0 ||
        index >= _listData.length) {
      return Container();
    }
    HomeListDataItemModel item = _listData[index];
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 2.5, 5.0, 2.5),
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: _buildListViewItem(item),
        ),
      ),
    );
  }

  Widget _buildListViewItem(HomeListDataItemModel item) {
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

  Widget _buildItemLeftSide(HomeListDataItemModel item) {
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

  void _loadBannerData() {
    CommonService().getBanner((HomeBannerModel _bean) {
      if (_bean.data.length > 0) {
        setState(() {
          _bannerData = _bean.data;
        });
      }
    });
  }

  Future<Null> _handleRefresh() async {
    _listDataPage = 0;
    _listData.clear();
    await _loadListData(_listDataPage);
  }

  Future<Null> _loadListData(int page) {
    return CommonService().getHomeListData((HomeListModel _bean) {
      if (_bean.data.datas.length > 0) {
        setState(() {
          _listData.addAll(_bean.data.datas);
        });
      }
    }, page);
  }
}
