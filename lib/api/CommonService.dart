import 'package:dio/dio.dart';
import 'Api.dart';
import 'package:wanandroid/model/HomeBannerModel.dart';

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
}
