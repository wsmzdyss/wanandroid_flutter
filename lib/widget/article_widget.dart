import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid_flutter/entity/article_list_entity.dart';

class ArticleItemWidget extends StatefulWidget {
  final ArticleData data;
  final int index;

  ArticleItemWidget(this.data, this.index);

  @override
  State<StatefulWidget> createState() {
    return ArticleItemState();
  }
}

class ArticleItemState extends State<ArticleItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebviewScaffold(
            url: widget.data.link,
            appBar: AppBar(
              title: Text(widget.data.title),
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
                    '${widget.index + 1}  ${widget.data.author}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '${widget.data.niceDate}',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${widget.data.title}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${widget.data.superChapterName}/${widget.data.chapterName}',
                        style: TextStyle(fontSize: 12),
                      ),
                      GestureDetector(
                        child: widget.data.collect
                            ? Icon(Icons.star)
                            : Icon(Icons.star_border),
                        onTap: () {
                          setState(() {
                            widget.data.collect = !widget.data.collect;
                          });
                        },
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
