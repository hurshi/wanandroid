import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/pages/home/HomePage.dart';
import 'package:wanandroid/pages/tree/TreePage.dart';
import 'package:wanandroid/pages/mine/MinePage.dart';
import 'package:wanandroid/pages/mpwechat/MpWechatPage.dart';
import 'package:wanandroid/pages/project/ProjectPage.dart';
import 'package:wanandroid/common/User.dart';

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
        icon: Icon(Icons.assignment),
        title: Text(GlobalConfig.homeTab),
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(Icons.branding_watermark),
        title: Text(GlobalConfig.projectTab),
        backgroundColor: GlobalConfig.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(Icons.color_lens),
        title: Text(GlobalConfig.mpWechatTab),
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
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User().refreshUserData();
    return MaterialApp(
      theme: ThemeData(primaryColor: GlobalConfig.colorPrimary),
      home: Scaffold(
        body: PageView(
//          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomePage(),
            ProjectPage(),
            MpWechatPage(),
            TreePage(),
            MinePage()
          ],
          controller: _pageController,
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
}
