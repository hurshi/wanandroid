import 'dart:ui' as ui;

import 'package:banner/banner.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/homebanner/HomeBannerItemModel.dart';
import 'package:wanandroid/model/homebanner/HomeBannerModel.dart';
import 'package:wanandroid/pages/common/ArticleListPage.dart';
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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
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
      body: ArticleListPage(
        header: _buildBanner(context),
        request: (page) {
          return CommonService().getArticleListData(page);
        },
      ),
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
