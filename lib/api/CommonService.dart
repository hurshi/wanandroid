import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wanandroid/model/homebanner/HomeBannerModel.dart';
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
}
