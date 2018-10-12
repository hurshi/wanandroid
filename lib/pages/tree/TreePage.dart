import 'package:flutter/material.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/model/tree/TreeModel.dart';
import 'package:wanandroid/model/tree/TreeRootModel.dart';
import 'package:wanandroid/model/tree/TreeSecondModel.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/api/Api.dart';

class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TreePageState();
  }
}

class _TreePageState extends State<TreePage>
    with AutomaticKeepAliveClientMixin {
  TreeModel _treeModel;
  var _maxCachePageNums = 5;
  var _cachedPageNum = 0;

  @override
  void initState() {
    super.initState();
    _loadTreeList();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    if (null == _treeModel || _treeModel.data.length <= 0) {
      return EmptyHolder();
    }
    return DefaultTabController(
      length: _treeModel.data.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TabBar(
            labelColor: GlobalConfig.colorPrimary,
            isScrollable: true,
            unselectedLabelColor: Colors.black45,
            indicatorColor: GlobalConfig.colorPrimary,
            tabs: _buildRootTabs(),
          ),
          Expanded(
            child: TabBarView(children: _buildRootPages()),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRootTabs() {
    return _treeModel.data?.map(_buildSingleRootTab)?.toList();
  }

  List<Widget> _buildRootPages() {
    return _treeModel.data?.map(_buildSingleRootPage)?.toList();
  }

  Widget _buildSingleRootTab(TreeRootModel model) {
    return Tab(
      text: model?.name,
    );
  }

  Widget _buildSingleRootPage(TreeRootModel model) {
    return DefaultTabController(
      length: model.children.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TabBar(
            labelColor: GlobalConfig.colorPrimary,
            isScrollable: true,
            unselectedLabelColor: Colors.black45,
            indicatorColor: GlobalConfig.colorPrimary,
            tabs: _buildSecondTabs(model),
          ),
          Expanded(
            child: TabBarView(children: _buildSecondPages(model)),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSecondTabs(TreeRootModel model) {
    return model.children.map(_buildSingleSecondTab)?.toList();
  }

  List<Widget> _buildSecondPages(TreeRootModel model) {
    return model.children?.map(_buildSingleSecondPage)?.toList();
  }

  Widget _buildSingleSecondTab(TreeSecondModel model) {
    return Tab(
      text: model?.name,
    );
  }

  Widget _buildSingleSecondPage(TreeSecondModel model) {
    return ItemListPage(
      keepAlive: _keepAlive(),
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
      });
    });
  }

  bool _keepAlive() {
    if (_cachedPageNum < _maxCachePageNums) {
      _cachedPageNum++;
      return true;
    } else {
      return false;
    }
  }
}
