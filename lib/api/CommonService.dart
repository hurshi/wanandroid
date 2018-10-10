import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wanandroid/model/homebanner/HomeBannerModel.dart';

import 'Api.dart';

class CommonService {
  void getBanner(Function callback) async {
    await Dio().get(Api.HOME_BANNER).then((response) {
      callback(HomeBannerModel.fromJson(response.data));
    });
  }

  Future<Response> getHomeListData(int page) async {
    return await Dio().get("${Api.HOME_LIST}$page/json");
  }
}
