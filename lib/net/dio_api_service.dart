import 'package:wanandroid_flutter/entity/article_list_entity.dart';
import 'package:wanandroid_flutter/entity/banner_entity.dart';

import 'api.dart';
import 'dio_manager.dart';

class ApiService {
  static Future<List<BannerData>> getBanner() {
    return DioManager.singleton.dio.get(Api.BANNER).then((res) {
      return BannerBaseEntity.fromJson(res.data).data;
    });
  }

  static Future<ArticleListData> getArticleList(int page) {
    return DioManager.singleton.dio.get(Api.ARTICLE_LIST + page.toString() + "/json").then((res) {
      return ArticleBaseEntity.fromJson(res.data).data;
    });
  }

}
