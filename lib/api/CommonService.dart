import 'package:dio/dio.dart';
import 'dart:async';
import 'Api.dart';
import 'package:wanandroid/model/homebanner/HomeBannerModel.dart';
import 'package:wanandroid/model/homelist/HomeListModel.dart';

class CommonService {
//  void getData(
//      String uri,
//      Function callback,
//      /*Type | Function | List<Type | Function | List<Type | Function | ...>>*/
//      type) async {
//    await Dio().get(uri).then((hm) {
//
//      var ds = fromJson(hm.data, HomeBannerModel);
//      print(ds);
////      callback(fromJson(hm.data, type));
//    });
//  }

  void getBanner(Function callback) async {
    await Dio().get(Api.HOME_BANNER).then((response) {
      callback(HomeBannerModel.fromJson(response.data));
    });
  }

  Future<Null> getHomeListData(Function callback, int page) async {
    return await Dio().get("${Api.HOME_LIST}$page/json").then((response) {
      callback(HomeListModel.fromJson(response.data));
    });
  }
}
