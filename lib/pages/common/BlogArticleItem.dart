import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/Router.dart';
import 'package:wanandroid/common/StringUtil.dart';
import 'package:wanandroid/model/list_item/BlogListDataItemModel.dart';

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
        padding: EdgeInsets.fromLTRB(5.0, 2.5, 5.0, 2.5),
        child: Card(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
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
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
          child: Text(item.author),
        ),
        Text(
          item.title,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
          child: Text("${item.niceDate}  "
              "${StringUtil.isNullOrEmpty(item.superChapterName) ? "" : item.superChapterName}"
              "${(StringUtil.isNullOrEmpty(item.superChapterName) || StringUtil.isNullOrEmpty(item.chapterName)) ? "" : "/"}"
              "${StringUtil.isNullOrEmpty(item.chapterName) ? "" : item.chapterName}"),
        )
      ],
    );
  }
}
