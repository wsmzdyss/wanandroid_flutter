import 'package:wanandroid_flutter/entity/article_list_entity.dart';
import 'package:wanandroid_flutter/entity/banner_entity.dart';
import 'package:wanandroid_flutter/entity/tree_entity.dart';

import 'api.dart';
import 'dio_manager.dart';

class ApiService {
  static Future<List<BannerData>> getBanner() {
    return DioManager.singleton.dio.get(Api.BANNER).then((res) {
      return BannerBaseEntity.fromJson(res.data).data;
    });
  }

  static Future<ArticleListData> getArticleList(int page) {
    return DioManager.singleton.dio
        .get(Api.ARTICLE_LIST + page.toString() + "/json")
        .then((res) {
      return ArticleBaseEntity.fromJson(res.data).data;
    });
  }

  static Future<List<TreeData>> getTree() {
    return DioManager.singleton.dio.get(Api.TREE).then((res) {
      return TreeBaseEntity.fromJson(res.data).data;
    });
  }

  static Future<ArticleListData> getTreeArticle(int page, int cid) {
    return DioManager.singleton.dio.get(
        Api.TREE_ARTICLE_LIST + page.toString() + "/json",
        queryParameters: {"cid": cid}).then((res) {
      return ArticleBaseEntity.fromJson(res.data).data;
    });
  }
}
