import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid_flutter/entity/article_list_entity.dart';
import 'package:wanandroid_flutter/entity/banner_entity.dart';
import 'package:wanandroid_flutter/net/dio_api_service.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {
  List<BannerData> bannerList = new List();
  List<ArticleData> articleList = new List();

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: buildItem(), onRefresh: _onRefresh);
  }

  Future _onRefresh() async {
    _refreshData();
  }

  Widget buildBanner() {
    return Container(
      key: ValueKey(bannerList.length),
      height: 200,
      child: Swiper(
        itemBuilder: (context, index) {
          return Image.network(bannerList[index].imagePath, fit: BoxFit.cover);
        },
        itemCount: bannerList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }

  Widget buildItem() {
    Widget divider = Divider(
      color: Colors.grey,
      height: 1,
    );
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == 0)
          return buildBanner();
        else {
          var article = articleList[index - 1];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return WebviewScaffold(
                  url: article.link,
                  appBar: AppBar(
                    title: Text(article.title),
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
                          '${article.author}',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          '${article.niceDate}',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${article.title}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${article.superChapterName}/${article.chapterName}',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                )),
          );
        }
      },
      itemCount: articleList.length + 1,
      separatorBuilder: (context, index) {
        return divider;
      },
    );
  }

  _refreshData() {
    ApiService.getBanner().then((res) {
      setState(() {
        bannerList = res;
      });
    });
    ApiService.getArticleList(0).then((res) {
      setState(() {
        articleList = res.datas;
      });
    });
  }
}
