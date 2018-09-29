import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/pages/home/HomePage.dart';
import 'package:wanandroid/pages/classify/ClassifyPage.dart';
import 'package:wanandroid/pages/mine/MinePage.dart';

class ApplicationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationPageState();
  }
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  int page = 0;
  String title = GloableConfig.homeTab;
  PageController pageController;

  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text(GloableConfig.homeTab),
        backgroundColor: GloableConfig.colorPrimary),
    new BottomNavigationBarItem(
        icon: Icon(Icons.tune),
        title: Text(GloableConfig.classyTab),
        backgroundColor: GloableConfig.colorPrimary),
    new BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text(GloableConfig.mineTab),
        backgroundColor: GloableConfig.colorPrimary),
  ];

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: this.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primaryColor: GloableConfig.colorPrimary),
      home: Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new PageView(
//          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[HomePage(), ClassifyPage(), MinePage()],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: new BottomNavigationBar(
          items: _bottomTabs,
          currentIndex: page,
          fixedColor: GloableConfig.colorPrimary,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
        ),
      ),
    );
  }

  void onTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
      switch (page) {
        case 0:
          title = GloableConfig.homeTab;
          break;
        case 1:
          title = GloableConfig.classyTab;
          break;
        case 2:
          title = GloableConfig.mineTab;
          break;
      }
    });
  }
}
