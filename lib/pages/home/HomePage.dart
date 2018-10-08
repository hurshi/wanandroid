import 'package:flutter/material.dart';
import 'package:wanandroid/model/HomeBannerModel.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/HomeBannerItemModel.dart';
import 'package:wanandroid/widget/BannerView.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<HomeBannerItemModel> _bannerListData;

  @override
  void initState() {
    super.initState();
    loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
    if (null == _bannerListData || _bannerListData.length <= 0) {
      return new Center(
        child: new Text("loading"),
      );
    } else
      return BannerView<HomeBannerItemModel>(
        data: _bannerListData,
        buildShowView: (index, data) {
          HomeBannerItemModel bean = data;
          return Image.network(bean.imagePath);
        },
      );
  }

  void loadBannerData() {
    CommonService().getBanner((HomeBannerModel _bean) {
      if (_bean.data.length > 0) {
        setState(() {
          _bannerListData = _bean.data;
        });
      }
    });
  }
}
