import 'package:flutter/material.dart';
import 'package:wanandroid/api/Api.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/fonts/Iconf.dart';
import 'package:wanandroid/model/mpwechat/MpWechatModel.dart';
import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/widget/ClearableInputField.dart';

class MpWechatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MpWechatPageState();
  }
}

class _MpWechatPageState extends State<MpWechatPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<MpWechatModel> _list = List();
  Map<int, ItemListPage> _itemListPageMap = Map();
  TabController _tabController;
  var _controller = TextEditingController();
  String _searchKey = "";
  bool _isSearching = false;
  int _currentItemIndex = 0;
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
      appBar: _isSearching ? _buildSearchingAppbar() : _buildNormalAppbar(),
      body: _list.length <= 0
          ? null
          : TabBarView(
              children: _buildPages(context),
              controller: _tabController,
            ),
    );
  }

  AppBar _buildNormalAppbar() {
    return AppBar(
      title: Text(GlobalConfig.mpWechatTab),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(IconF.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        )
      ],
      bottom: _buildSubTitle(),
    );
  }

  AppBar _buildSearchingAppbar() {
    var originTheme = Theme.of(context);
    return AppBar(
      leading: IconButton(
          icon: Icon(IconF.back),
          onPressed: () {
            handleRefreshSearchKey(key: "");
            setState(() {
              _isSearching = false;
            });
          }),
      centerTitle: true,
      title: Theme(
          data: originTheme.copyWith(
            hintColor: GlobalConfig.color_white_a80,
            textTheme: TextTheme(subhead: TextStyle(color: Colors.white)),
          ),
          child: ClearableInputField(
            hintTxt: "搜索公众号历史文章",
            controller: _controller,
            autoFocus: true,
            border: InputBorder.none,
            onchange: (str) {
              handleRefreshSearchKey(key: str);
            },
          )),
      bottom: _buildSubTitle(),
    );
  }

  void handleRefreshSearchKey({String key}) {
    if (null != key) _searchKey = key;
    _itemListPageMap[_list[_currentItemIndex].id]?.handleRefresh();
  }

  TabBar _buildSubTitle() {
    return _list.length <= 0
        ? null
        : TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            isScrollable: true,
            unselectedLabelColor: GlobalConfig.color_white_a80,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.only(bottom: 2.0),
            indicatorWeight: 1.0,
            indicatorColor: Colors.white,
            tabs: _buildTabs(),
          );
  }

  List<Widget> _buildTabs() {
    return _list?.map((MpWechatModel _bean) {
      return Tab(
        text: _bean?.name,
      );
    })?.toList();
  }

  List<Widget> _buildPages(BuildContext context) {
    return _list?.map((_bean) {
      if (!_itemListPageMap.containsKey(_bean.id)) {
        _itemListPageMap[_bean.id] = ItemListPage(
            key: Key("${_bean.id}"),
            keepAlive: _keepAlive(),
            emptyMsg: "臣妾搜不到呀",
            request: (page) {
              return CommonService().getMpWechatListData(
                  "${Api.MP_WECHAT_LIST}${_bean.id}/$page/json?k=$_searchKey");
            });
      }
      return _itemListPageMap[_bean.id];
    })?.toList();
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
    CommonService().getMpWechatNames((List<MpWechatModel> list) {
      if (list.length > 0) {
        setState(() {
          _updateState(list);
        });
      }
    });
  }

  void _updateState(List<MpWechatModel> list) {
    _list = list;
    _tabController = TabController(length: _list.length, vsync: this);
    _tabController.addListener(() {
      _currentItemIndex = _tabController.index;
      handleRefreshSearchKey();
    });
  }
}
