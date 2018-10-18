import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/common/Router.dart';
import 'package:wanandroid/common/Snack.dart';
import 'package:wanandroid/common/User.dart';
import 'package:wanandroid/widget/BackBtn.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage();

  @override
  State<StatefulWidget> createState() => new _LoginRegisterPagePageState();
}

class _LoginRegisterPagePageState extends State<LoginRegisterPage> {
  bool isLogin = true;
  TextFormField _userNameInputForm;
  TextFormField _psdInputForm;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _psdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        centerTitle: true,
        title: Text(isLogin ? "登录" : "注册"),
      ),
      body: Builder(builder: (ct) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            _buildUserNameInputForm(),
            SizedBox(height: 8.0),
            _buildPsdInputForm(),
            SizedBox(height: 24.0),
            _buildLoginBtn(ct),
            SizedBox(height: 10.0),
            Container(
              child: _buildRegBtn(),
              alignment: Alignment.centerRight,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.all(8.0),
      color: GlobalConfig.colorPrimary,
      textColor: Colors.white,
      child: Text(isLogin ? "登录" : "注册并登录"),
      elevation: 4.0,
      onPressed: () {
        var _userNameStr = _userNameController.text;
        var _psdStr = _psdController.text;
        if (null == _userNameStr ||
            null == _psdStr ||
            _userNameStr.length < 6 ||
            _psdStr.length < 6) {
          Snack.show(context, "账号/密码不符合标准");
        } else {
          User().userName = _userNameStr;
          User().password = _psdStr;
          var callback = (bool loginOK, String errorMsg) {
            if (loginOK) {
              Snack.show(context, "登录成功");
              Timer(Duration(milliseconds: 400), () {
                Router().back(context);
              });
            } else {
              Snack.show(context, errorMsg);
            }
          };
          isLogin
              ? User().login(callback: callback)
              : User().register(callback: callback);
        }
      },
    );
  }

  Widget _buildUserNameInputForm() {
    _userNameInputForm = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      controller: _userNameController,
      decoration: InputDecoration(
        hintText: '用户名',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );
    return _userNameInputForm;
  }

  Widget _buildPsdInputForm() {
    _psdInputForm = TextFormField(
      autofocus: true,
      obscureText: true,
      controller: _psdController,
      decoration: InputDecoration(
        hintText: '密码',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );
    return _psdInputForm;
  }

  Widget _buildRegBtn() {
    return FlatButton(
      child: Text(
        isLogin ? '注册新账号' : '直接登录',
        style: TextStyle(fontSize: 15.0, color: Colors.black54),
      ),
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
    );
  }
}
