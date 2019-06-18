import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid_flutter/entity/article_list_entity.dart';
import 'package:wanandroid_flutter/entity/banner_entity.dart';
import 'package:wanandroid_flutter/net/dio_api_service.dart';
import 'package:wanandroid_flutter/widget/article_widget.dart';

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
  ScrollController _controller = ScrollController();
  bool _isLoadMore = false;
  bool _showToTopBtn = false;

  @override
  void initState() {
    _refreshData();
    _controller.addListener(() {
      //滚动到底部
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          _isLoadMore = true;
        });
        _getArticleList(false);
      }

      if (_controller.offset < 200 && _showToTopBtn) {
        setState(() {
          _showToTopBtn = false;
        });
      } else if (_controller.offset >= 200 && _showToTopBtn == false) {
        setState(() {
          _showToTopBtn = true;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            child: buildItem(),
            onRefresh: () async {
              //此处需用await，不然refresh指示器不会消失
              await _refreshData();
            }),
        floatingActionButton: _showToTopBtn
            ? FloatingActionButton(
                child: Icon(Icons.arrow_upward),
                onPressed: () {
                  _controller.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                },
              )
            : null);
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

  Widget buildItem() {
    Widget divider = Divider(
      color: Colors.grey,
      height: 1,
    );
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == 0)
          return buildBanner();
        else if (index < _articleList.length + 1) {
          var article = _articleList[index - 1];
          return ArticleItemWidget(article, index - 1);
        } else {
          return _isLoadMore
              ? Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "加载更多",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                )
              : Container(width: 0, height: 0);
        }
      },
      itemCount: _articleList.length + 2,
      controller: _controller,
      separatorBuilder: (context, index) {
        return divider;
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    _page = isRefresh ? 0 : _page++;
    ApiService.getArticleList(_page).then((res) {
      setState(() {
        if (isRefresh) {
          _articleList.clear();
          _articleList = res.datas;
        } else {
          _articleList.addAll(res.datas);
          _isLoadMore = false;
        }
      });
    });
  }
}
