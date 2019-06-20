import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid_flutter/entity/article_list_entity.dart';
import 'package:wanandroid_flutter/entity/banner_entity.dart';
import 'package:wanandroid_flutter/net/dio_api_service.dart';
import 'package:wanandroid_flutter/widget/article_widget.dart';
import 'package:wanandroid_flutter/widget/refresh_loadmore_listview.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {
  List<BannerData> _bannerList = List();
  List<ArticleData> _articleList = List();
  int _page = 0;

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonListView(
        itemCount: _articleList.length + 1,
        onRefresh: () async {
          _refreshData();
        },
        itemWidget: (context, index) {
          if (index == 0)
            return buildBanner();
          else
            return ArticleItemWidget(_articleList[index - 1], index - 1);
        },
        onLoadMore: () async {
          _getArticleList(false);
        });
  }

  Widget buildBanner() {
    return Container(
      // 添加key  https://github.com/best-flutter/flutter_swiper/issues/64
      key: ValueKey(_bannerList.length),
      height: 200,
      child: Swiper(
        itemBuilder: (context, index) {
          return GestureDetector(
              child: Image.network(_bannerList[index].imagePath,
                  fit: BoxFit.cover),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return WebviewScaffold(
                    url: _bannerList[index].url,
                    appBar: AppBar(
                      title: Text(_bannerList[index].title),
                    ),
                  );
                }));
              });
        },
        itemCount: _bannerList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }

  _refreshData() {
    ApiService.getBanner().then((res) {
      setState(() {
        _bannerList = res;
      });
    });
    _getArticleList();
  }

  _getArticleList([bool isRefresh = true]) {
    _page = isRefresh ? 0 : ++_page;
    ApiService.getArticleList(_page).then((res) {
      setState(() {
        if (isRefresh) _articleList.clear();
        _articleList.addAll(res.datas);
      });
    });
  }
}
