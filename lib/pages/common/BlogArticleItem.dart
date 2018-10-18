import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/GlobalConfig.dart';
import 'package:wanandroid/common/Router.dart';
import 'package:wanandroid/common/StringUtil.dart';
import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';
import 'package:wanandroid/widget/StrokeWidget.dart';
import 'package:wanandroid/fonts/IconF.dart';

class BlogArticleItem extends StatefulWidget {
  final BlogListDataItemModel item;

  BlogArticleItem(this.item);

  @override
  State<StatefulWidget> createState() => new _BlogArticleItemState();
}

class _BlogArticleItemState extends State<BlogArticleItem> {
  @override
  Widget build(BuildContext context) {
    //去掉html中的高亮
    widget.item.title =
        widget.item.title.replaceAll(RegExp("(<em[^>]*>)|(</em>)"), "");
    return GestureDetector(
      onTap: () {
        Router().openArticle(context, widget.item);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.5),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: _buildListViewItem(widget.item),
          ),
        ),
      ),
    );
  }

  Widget _buildListViewItem(BlogListDataItemModel item) {
    var widget = (null != item.envelopePic && item.envelopePic.isNotEmpty)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: _buildItemLeftSide(item),
              ),
              Container(
                width: 30.0,
                child: CachedNetworkImage(
                  fadeInDuration: Duration(milliseconds: 0),
                  fadeOutDuration: Duration(milliseconds: 0),
                  imageUrl: item.envelopePic,
                ),
              )
            ],
          )
        : _buildItemLeftSide(item);

    return widget;
  }

  Widget _buildItemLeftSide(BlogListDataItemModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildItemLeftColumns(item),
    );
  }

  List<Widget> _buildItemLeftColumns(BlogListDataItemModel item) {
    List<Widget> list = List();
    list.add(Text(
      item.title,
      style: TextStyle(fontSize: 16.0, color: GlobalConfig.color_black),
      textAlign: TextAlign.left,
    ));
    list.add(Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            IconF.time,
            size: 15.0,
            color: GlobalConfig.color_dark_gray,
          ),
          Text(" ${item.niceDate} @${item.author}",
              style: TextStyle(color: GlobalConfig.color_dark_gray))
        ],
      ),
    ));
    var tags = _buildTagsAndDate(item);
    if (tags.length > 0) {
      list.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: tags,
      ));
    }
    return list;
  }

  List<Widget> _buildTagsAndDate(BlogListDataItemModel item) {
    List<Widget> list = List();
    item.tags?.forEach((tag) {
      list.add(StrokeWidget(
          edgeInsets: EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
          color: GlobalConfig.color_tags,
          childWidget: Text(
            tag.name,
            style: TextStyle(fontSize: 11.0, color: GlobalConfig.color_tags),
          )));
    });
    String chapterNameStr =
        "${(list.length <= 0 ? "" : "  ")}${StringUtil.isNullOrEmpty(item.superChapterName) ? "" : item.superChapterName}"
        "${(StringUtil.isNullOrEmpty(item.superChapterName) || StringUtil.isNullOrEmpty(item.chapterName)) ? "" : "/"}"
        "${StringUtil.isNullOrEmpty(item.chapterName) ? "" : item.chapterName}";
    if (!StringUtil.isNullOrEmpty(chapterNameStr.trim())) {
      list.add(StrokeWidget(
        edgeInsets: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        color: Colors.transparent,
        childWidget: Text(
          chapterNameStr,
          style: TextStyle(fontSize: 13.0, color: GlobalConfig.color_dark_gray),
        ),
      ));
    }
    return list;
  }
}
