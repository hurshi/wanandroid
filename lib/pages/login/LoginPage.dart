import 'package:flutter/material.dart';

import 'package:wanandroid/pages/common/ItemListPage.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/widget/SearchBar.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  State<StatefulWidget> createState() => new _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("登录"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {}
}
