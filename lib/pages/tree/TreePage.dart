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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(GlobalConfig.treeTab),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (null == _treeModel || _treeModel.data.length <= 0) {
      return EmptyHolder();
    }
    return DefaultTabController(
      length: _treeModel.data.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            margin: EdgeInsets.all(0.0),
            color: GlobalConfig.colorPrimary,
            child: TabBar(
              labelColor: Colors.white,
              isScrollable: true,
              unselectedLabelColor: GlobalConfig.color_white_a80,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.only(bottom: 2.0),
              indicatorWeight: 1.0,
              indicatorColor: Colors.white,
              tabs: _buildRootTabs(),
            ),
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
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
            color: GlobalConfig.colorPrimary,
//            elevation: 4.0,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.all(Radius.circular(0.0)),
//            ),
//            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
//            color: Colors.white,
            child: Center(
              child: TabBar(
//                indicatorSize: TabBarIndicatorSize.label,
//                indicatorPadding: EdgeInsets.only(bottom: 2.0),
//                indicatorWeight: 1.0,
//                labelColor: GlobalConfig.colorPrimary,
//                isScrollable: true,
//                unselectedLabelColor: Colors.black45,
//                indicatorColor: GlobalConfig.colorPrimary,
                labelColor: Colors.white,
                isScrollable: true,
                unselectedLabelColor: GlobalConfig.color_white_a80,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 2.0),
                indicatorWeight: 1.0,
                indicatorColor: Colors.white,
                tabs: _buildSecondTabs(model),
              ),
            ),
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
