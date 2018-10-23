import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/common/User.dart';
import 'package:wanandroid/fonts/IconF.dart';
import 'package:wanandroid/pages/home/HomePage.dart';
import 'package:wanandroid/pages/knowledge_systems/KnowledgeSystemsPage.dart';
import 'package:wanandroid/pages/mine/MinePage.dart';
import 'package:wanandroid/pages/project/ProjectPage.dart';
import 'package:wanandroid/pages/wechat/WeChatPage.dart';

class ApplicationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationPageState();
  }
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  PageController _pageController;

  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(IconF.blog),
        title: Text(GlobalConfig.homeTab),
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(IconF.project),
        title: Text(GlobalConfig.projectTab),
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(IconF.wechat),
        title: Text(GlobalConfig.weChatTab),
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(IconF.tree),
        title: Text(GlobalConfig.knowledgeSystemsTab),
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(IconF.me),
        title: Text(GlobalConfig.mineTab),
        backgroundColor: GlobalConfig.colorPrimary),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this._page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User().refreshUserData();
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          ProjectPage(),
          WeChatPage(),
          KnowledgeSystemsPage(),
          MinePage()
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomTabs,
        currentIndex: _page,
        fixedColor: GlobalConfig.colorPrimary,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
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
    });
  }
}
