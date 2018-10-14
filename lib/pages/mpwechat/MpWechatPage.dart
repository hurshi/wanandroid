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
    if (_list.length <= 0) {
      return EmptyHolder();
    }
    return DefaultTabController(
      length: _list.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TabBar(
            labelColor: GlobalConfig.colorPrimary,
            isScrollable: true,
            unselectedLabelColor: Colors.black45,
            indicatorColor: GlobalConfig.colorPrimary,
            tabs: _buildTabs(),
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
