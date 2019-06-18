import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid_flutter/entity/article_list_entity.dart';
class ArticleItemWidget extends StatelessWidget {

  final ArticleData data;
  final int index;

  ArticleItemWidget(this.data, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebviewScaffold(
            url: data.link,
            appBar: AppBar(
              title: Text(data.title),
            ),
          );
        }));
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${index + 1}  ${data.author}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '${data.niceDate}',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${data.title}',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${data.superChapterName}/${data.chapterName}',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          )),
    );
  }
}