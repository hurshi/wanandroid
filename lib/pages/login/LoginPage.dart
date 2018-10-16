import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/common/Router.dart';
import 'package:wanandroid/common/Snack.dart';
import 'package:wanandroid/common/Sp.dart';
import 'package:wanandroid/model/login/UserModel.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  State<StatefulWidget> createState() => new _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPage> {
  TextFormField _userNameInputForm;
  TextFormField _psdInputForm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("登录"),
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
      child: Text("登录"),
      elevation: 4.0,
      onPressed: () {
        var _userNameStr = _userNameInputForm.controller.text;
        var _psdStr = _psdInputForm.controller.text;
        if (null == _userNameStr ||
            null == _psdStr ||
            _userNameStr.length < 6 ||
            _psdStr.length < 6) {
          Snack.show(context, "账号/密码不符合标准");
        } else {
          CommonService().login(_userNameStr, _psdStr).then((response) {
            var userModel = UserModel.fromJson(response.data);
            if (userModel.errorCode != 0) {
              Snack.show(context, userModel.errorMsg);
            } else {
              Sp.putUserName(userModel.data.username);
              Sp.putPassword(userModel.data.password);
              Snack.show(context, "登录成功");
              Timer(Duration(milliseconds: 400), () {
//                Navigator.pop(context, "back");
                Router().back(context);
              });
            }
          });
        }
      },
    );
  }

  Widget _buildUserNameInputForm() {
    _userNameInputForm = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      controller: TextEditingController(),
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
      controller: TextEditingController(),
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
        '注册新账号',
        style: TextStyle(fontSize: 15.0, color: Colors.black54),
      ),
      onPressed: () {},
    );
  }
}
