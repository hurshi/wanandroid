import 'package:flutter/material.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/model/mpwechat/MpWechatModel.dart';
import 'package:wanandroid/widget/EmptyHolder.dart';

import 'MpWechatSinglePage.dart';

class MpWechatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MpWechatPageState();
  }
}

class _MpWechatPageState extends State<MpWechatPage>
    with AutomaticKeepAliveClientMixin {
  List<MpWechatModel> _list = List();
  var _maxCachePageNums = 5;
  var _cachedPageNum = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadMpWechatNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(GlobalConfig.mpWechatTab),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_list.length <= 0) {
      return EmptyHolder();
    }
    return DefaultTabController(
      length: _list.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 0.0,
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
              tabs: _buildTabs(),
            ),
          ),
          Expanded(
            child: TabBarView(children: _buildPages(context)),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    return _list?.map(_buildSingleTab)?.toList();
  }

  List<Widget> _buildPages(BuildContext context) {
    return _list?.map((_bean) {
      return MpWechatSinglePage(
        keepAlive: _keepAlive(),
        model: _bean,
      );
    })?.toList();
  }

  Widget _buildSingleTab(MpWechatModel _bean) {
    return Tab(
      text: _bean?.name,
    );
  }

  bool _keepAlive() {
    if (_cachedPageNum < _maxCachePageNums) {
      _cachedPageNum++;
      return true;
    } else {
      return false;
    }
  }

  void _loadMpWechatNames() async {
    CommonService().getMpWechatNames((List<MpWechatModel> _l) {
      if (_l.length > 0) {
        setState(() {
          _list = _l;
        });
      }
    });
  }
}
