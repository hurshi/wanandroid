import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wanandroid/model/homebanner/HomeBannerModel.dart';
import 'package:wanandroid/model/mpwechat/MpWechatModel.dart';
import 'package:wanandroid/model/project/ProjectClassifyModel.dart';
import 'package:wanandroid/model/tree/TreeModel.dart';
import 'package:wanandroid/common/User.dart';

import 'Api.dart';

class CommonService {
  void getBanner(Function callback) async {
    Dio().get(Api.HOME_BANNER, options: _getOptions()).then((response) {
      callback(HomeBannerModel.fromJson(response.data));
    });
  }

  void getProjectClassify(Function callback) async {
    Dio().get(Api.PROJECT_CLASSIFY, options: _getOptions()).then((response) {
      callback(ProjectClassifyModel.fromJson(response.data));
    });
  }

  void getMpWechatNames(Function callback) async {
    Dio().get(Api.MP_WECHAT_NAMES, options: _getOptions()).then((response) {
      callback((response.data as List)
          ?.map((e) => e == null
              ? null
              : MpWechatModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
    });
  }

  Future<Response> getMpWechatListData(String url) async {
    return await Dio().get(url, options: _getOptions());
  }

  void getTrees(Function callback) async {
    Dio().get(Api.TREES_LIST, options: _getOptions()).then((response) {
      callback(TreeModel.fromJson(response.data));
    });
  }

  Future<Response> getTreeItemList(String url) async {
    return await Dio().get(url, options: _getOptions());
  }

  Future<Response> getArticleListData(int page) async {
    return await Dio()
        .get("${Api.HOME_LIST}$page/json", options: _getOptions());
  }

  Future<Response> getCollectListData(int page) async {
    return await Dio()
        .get("${Api.COLLECTED_ARTICLE}$page/json", options: _getOptions());
  }

  Future<Response> getProjectListData(String url) async {
    return await Dio().get(url, options: _getOptions());
  }

  Future<Response> getSearchListData(String key, int page) async {
    FormData formData = new FormData.from({
      "k": "$key",
    });
    return await Dio().post("${Api.SEARCH_LIST}$page/json",
        data: formData, options: _getOptions());
  }

  Future<Response> login(String username, String password) async {
    FormData formData = new FormData.from({
      "username": "$username",
      "password": "$password",
    });
    return await Dio().post(Api.LOGIN, data: formData);
  }

  Future<Response> collectInArticles(int id) async {
    return await Dio()
        .post("${Api.COLLECT_IN_ARTICLE}$id/json", options: _getOptions());
  }

  Future<Response> unCollectArticle(int id) async {
    return await Dio()
        .post("${Api.UNCOLLECT_ARTICLE}$id/json", options: _getOptions());
  }

  Future<Response> collectOutArticles(
      String title, String author, String link) async {
    FormData formData = new FormData.from({
      "title": "$title",
      "author": "$author",
      "link": "$link",
    });
    return await Dio()
        .post(Api.COLLECT_OUT_ARTICLE, data: formData, options: _getOptions());
  }

  Options _getOptions() {
    return Options(headers: User().getHeader());
  }
}
