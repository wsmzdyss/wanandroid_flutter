import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/entity/article_list_entity.dart';
import 'package:wanandroid_flutter/net/dio_api_service.dart';
import 'package:wanandroid_flutter/widget/article_widget.dart';
import 'package:wanandroid_flutter/widget/refresh_loadmore_listview.dart';

class TreeContentWidget extends StatefulWidget {
  final int cid;

  TreeContentWidget(this.cid);

  @override
  State createState() => TreeContentState();
}

class TreeContentState extends State<TreeContentWidget> {
  List<ArticleData> _data = List();

  int _page = 0;

  @override
  void initState() {
    getTreeContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonListView(
        itemCount: _data.length,
        itemWidget: (context, index) => ArticleItemWidget(_data[index], index),
        onRefresh: () async {
          await getTreeContent();
        },
        onLoadMore: () async {
          await getTreeContent(false);
        },
      ),
    );
  }

  getTreeContent([bool isRefresh = true]) {
    _page = isRefresh ? 0 : _page++;
    ApiService.getTreeArticle(_page, widget.cid).then((res) {
      setState(() {
        if (isRefresh) _data.clear();
        _data.addAll(res.datas);
      });
    });
  }
}
