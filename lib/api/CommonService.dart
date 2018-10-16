import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wanandroid/model/homebanner/HomeBannerModel.dart';
import 'package:wanandroid/model/mpwechat/MpWechatModel.dart';
import 'package:wanandroid/model/project/ProjectClassifyModel.dart';
import 'package:wanandroid/model/tree/TreeModel.dart';

import 'Api.dart';

class CommonService {
  void getBanner(Function callback) async {
    Dio().get(Api.HOME_BANNER).then((response) {
      callback(HomeBannerModel.fromJson(response.data));
    });
  }

  void getProjectClassify(Function callback) async {
    Dio().get(Api.PROJECT_CLASSIFY).then((response) {
      callback(ProjectClassifyModel.fromJson(response.data));
    });
  }

  void getMpWechatNames(Function callback) async {
    Dio().get(Api.MP_WECHAT_NAMES).then((response) {
      callback((response.data as List)
          ?.map((e) => e == null
              ? null
              : MpWechatModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
    });
  }

  Future<Response> getMpWechatListData(String url) async {
    return await Dio().get(url);
  }

  void getTrees(Function callback) async {
    Dio().get(Api.TREES_LIST).then((response) {
      callback(TreeModel.fromJson(response.data));
    });
  }

  Future<Response> getTreeItemList(String url) async {
    return await Dio().get(url);
  }

  Future<Response> getArticleListData(int page) async {
    return await Dio().get("${Api.HOME_LIST}$page/json");
  }

  Future<Response> getProjectListData(String url) async {
    return await Dio().get(url);
  }

  Future<Response> getSearchListData(String key, int page) async {
    FormData formData = new FormData.from({
      "k": "$key",
    });
    return await Dio().post("${Api.SEARCH_LIST}$page/json", data: formData);
  }

  Future<Response> login(String username, String password) async {
    FormData formData = new FormData.from({
      "username": "$username",
      "password": "$password",
    });
    return await Dio().post(Api.LOGIN, data: formData);
  }
}
