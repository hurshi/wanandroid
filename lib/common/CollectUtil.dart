import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/CommonService.dart';
import 'package:wanandroid/common/User.dart';
import 'package:wanandroid/model/EmptyModel.dart';
import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';

class CollectUtil {
  static updateCollectState(
      BuildContext context, BlogListDataItemModel model, Function callback) {
    if (!User().isLogin()) {
      callback(false, "收藏需要先登录哈");
    } else {
      if (model.collect) {
        _exeResponse(_unCollectArticle(model), callback);
      } else {
        if (model.link.contains("www.wanandroid.com")) {
          _exeResponse(_collectInnerArticle(model), callback);
        } else {
          _exeResponse(_collectOuterArticle(model), callback);
        }
      }
    }
  }

  static void _exeResponse(Future<Response> responseFuture, Function callback) {
    responseFuture.then((response) {
      var emptyModel = EmptyModel.fromJson(response.data);
      callback(emptyModel.errorCode == 0, emptyModel.errorMsg);
    });
  }

  static Future<Response> _collectInnerArticle(BlogListDataItemModel model) {
    return CommonService().collectInArticles(model.id);
  }

  static Future<Response> _collectOuterArticle(BlogListDataItemModel model) {
    return CommonService()
        .collectOutArticles(model.title, model.author, model.link);
  }

  static Future<Response> _unCollectArticle(BlogListDataItemModel model) {
    return CommonService().unCollectArticle(model.id);
  }
}
