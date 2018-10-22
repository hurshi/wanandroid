import 'dart:ui' as ui;

import 'package:banner/banner.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/homebanner/HomeBannerItemModel.dart';
import 'package:wanandroid/model/homebanner/HomeBannerModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/common/Router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/fonts/IconF.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<HomeBannerItemModel> _bannerData;
  var _topFloatBtnShowing = false;
  ItemListPage _itemListPage;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
    if (null == _itemListPage && null != _bannerData)
      _itemListPage = ItemListPage(
        header: _buildBanner(context),
        showQuickTop: (show) {
          if (_topFloatBtnShowing != show) {
            setState(() {
              _topFloatBtnShowing = show;
            });
          }
        },
        request: (page) {
          return CommonService().getArticleListData(page);
        },
      );
    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalConfig.homeTab),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(IconF.search),
            onPressed: () {
              Router().openSearch(context);
            },
          )
        ],
      ),
      body: _itemListPage,
      floatingActionButton: _topFloatBtnShowing
          ? (FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: GlobalConfig.colorPrimary,
              child: Icon(IconF.top),
              onPressed: () {
                _itemListPage?.handleScroll(0.0);
              }))
          : null,
    );
  }

  Widget _buildBanner(BuildContext context) {
    if (null == _bannerData || _bannerData.length <= 0) {
      return Center(
        child: Text("loading"),
      );
    } else {
      double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
      return Container(
        height: screenWidth * 500 / 900,
        width: screenWidth,
        child: BannerView(
          data: _bannerData,
          delayTime: 10,
          onBannerClickListener: (int index, dynamic itemData) {
            HomeBannerItemModel item = itemData;
            Router().openWeb(context, item.url, item.title);
          },
          buildShowView: (index, data) {
            return CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 0),
              fadeOutDuration: Duration(milliseconds: 0),
              imageUrl: (data as HomeBannerItemModel).imagePath,
            );
          },
        ),
      );
    }
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
}
