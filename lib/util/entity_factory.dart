import 'package:wanandroid_flutter/entity/banner_entity.dart';
import 'package:wanandroid_flutter/entity/article_list_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "BannerEntity") {
      return BannerBaseEntity.fromJson(json) as T;
    } else if (T.toString() == "ArticleEntity") {
      return ArticleBaseEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}