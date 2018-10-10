import 'package:flutter/material.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/homebanner/HomeBannerItemModel.dart';
import 'package:wanandroid/model/homebanner/HomeBannerModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/widget/BannerView.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<HomeBannerItemModel> _bannerData;

  @override
  void initState() {
    super.initState();
    _loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return ItemListPage(
      header: _buildBanner(),
      request: (page) {
        return CommonService().getArticleListData(page);
      },
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
