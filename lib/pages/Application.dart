import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/pages/home/HomePage.dart';
import 'package:wanandroid/pages/tree/TreePage.dart';
import 'package:wanandroid/pages/mine/MinePage.dart';
import 'package:wanandroid/pages/project/ProjectPage.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class ApplicationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationPageState();
  }
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  String _titleTxt = GlobalConfig.homeTab;
  SearchBar _searchbar;
  PageController _pageController;

  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.assignment),
        title: Text(GlobalConfig.homeTab),
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(Icons.branding_watermark),
        title: Text(GlobalConfig.projectTab),
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(Icons.developer_board),
        title: Text(GlobalConfig.treeTab),
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(Icons.assignment_ind),
        title: Text(GlobalConfig.mineTab),
        backgroundColor: GlobalConfig.colorPrimary),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this._page);
    _searchbar = SearchBar(
      setState: setState,
      onSubmitted: print,
      inBar: true,
      showClearButton: true,
      buildDefaultAppBar: buildAppBar,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(_titleTxt),
      centerTitle: true,
      actions: <Widget>[_searchbar.getSearchAction(context)],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: GlobalConfig.colorPrimary),
      home: Scaffold(
        appBar: _searchbar.build(context),
        body: PageView(
//          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[HomePage(), ProjectPage(), TreePage(), MinePage()],
          controller: _pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomTabs,
          currentIndex: _page,
          fixedColor: GlobalConfig.colorPrimary,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
        ),
      ),
    );
  }

  void onTap(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
      switch (page) {
        case 0:
          _titleTxt = GlobalConfig.homeTab;
          break;
        case 1:
          _titleTxt = GlobalConfig.projectTab;
          break;
        case 2:
          _titleTxt = GlobalConfig.treeTab;
          break;
        case 3:
          _titleTxt = GlobalConfig.mineTab;
          break;
      }
    });
  }
}
