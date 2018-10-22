import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/model/tree/TreeModel.dart';
import 'package:wanandroid/model/tree/TreeRootModel.dart';
import 'package:wanandroid/model/tree/TreeSecondModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';

class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TreePageState();
  }
}

class _TreePageState extends State<TreePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  double _screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
  TreeModel _treeModel;
  TabController tabControllerOutter;
  Map<int, TabController> tabControllerInnerMaps = Map();
  TreeRootModel _currentTreeRootModel;

  @override
  void initState() {
    super.initState();
    _loadTreeList();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTitle(),
      body: _buildBody(_currentTreeRootModel),
    );
  }

  AppBar _appbar;

  AppBar _buildTitle() {
    if (null == _appbar && null != _treeModel)
      _appbar = AppBar(
        title: Text(GlobalConfig.treeTab),
        centerTitle: true,
        bottom: PreferredSize(
          child: _buildTitleTabs(),
          preferredSize: Size(_screenWidth, kToolbarHeight * 2),
        ),
      );
    return _appbar;
  }

  Widget _buildTitleTabs() {
    if (null == _treeModel) {
      return EmptyHolder(
        msg: "Loading",
      );
    }
    tabControllerOutter =
        TabController(length: _treeModel?.data?.length, vsync: this);
    tabControllerOutter.addListener(() {
      setState(() {
        _currentTreeRootModel = _treeModel.data[tabControllerOutter.index];
      });
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          child: TabBar(
            controller: tabControllerOutter,
            labelColor: Colors.white,
            isScrollable: true,
            unselectedLabelColor: GlobalConfig.color_white_a80,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.only(bottom: 2.0),
            indicatorWeight: 1.0,
            indicatorColor: Colors.white,
            tabs: _buildRootTabs(),
          ),
          width: _screenWidth,
          height: kToolbarHeight,
        ),
        SizedBox(
          child: TabBarView(
            children: _buildSecondTitle(),
            controller: tabControllerOutter,
          ),
          width: _screenWidth,
          height: kToolbarHeight,
        ),
      ],
    );
  }

  List<Widget> _buildRootTabs() {
    return _treeModel.data?.map((TreeRootModel model) {
      return Tab(
        text: model?.name,
      );
    })?.toList();
  }

  List<Widget> _buildSecondTitle() {
    return _treeModel.data?.map(_buildSingleSecondTitle)?.toList();
  }

  Widget _buildSingleSecondTitle(TreeRootModel model) {
    if (null == model) {
      return EmptyHolder(
        msg: "Loading",
      );
    }
    if (null == tabControllerInnerMaps[model.id])
      tabControllerInnerMaps[model.id] =
          TabController(length: model.children.length, vsync: this);
    return TabBar(
      controller: tabControllerInnerMaps[model.id],
      labelColor: Colors.white,
      isScrollable: true,
      unselectedLabelColor: GlobalConfig.color_white_a80,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.only(bottom: 2.0),
      indicatorWeight: 1.0,
      indicatorColor: Colors.white,
      tabs: _buildSecondTabs(model),
    );
  }

  List<Widget> _buildSecondTabs(TreeRootModel model) {
    return model.children.map((TreeSecondModel model) {
      return Tab(
        text: model?.name,
      );
    })?.toList();
  }

  Widget _buildBody(TreeRootModel model) {
    if (null == model) {
      return EmptyHolder(
        msg: "Loading",
      );
    }
    if (null == tabControllerInnerMaps[model.id])
      tabControllerInnerMaps[model.id] =
          TabController(length: model.children.length, vsync: this);
    return TabBarView(
      key: Key("tb${model.id}"),
      children: _buildPages(model),
      controller: tabControllerInnerMaps[model.id],
    );
  }

  List<Widget> _buildPages(TreeRootModel model) {
    return model.children?.map(_buildSinglePage)?.toList();
  }

  Widget _buildSinglePage(TreeSecondModel model) {
    return ItemListPage(
      key: Key("${model.id}"),
      request: (page) {
        return CommonService().getTreeItemList(
            "${Api.TREES_DETAIL_LIST}$page/json?cid=${model.id}");
      },
    );
  }

  void _loadTreeList() async {
    CommonService().getTrees((TreeModel _bean) {
      setState(() {
        _treeModel = _bean;
        _currentTreeRootModel = _treeModel.data[0];
      });
    });
  }
}
