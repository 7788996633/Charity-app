import 'package:baader/data/models/articlemodel.dart';
import 'package:baader/data/models/saved_article_model.dart';

import '../services/articlrs_services.dart';

class ArticlesRepository {
  Future<List<ArticleModel>> showArticles() async {
    var articlesList = await ArticlesServices().showArticles();
    return articlesList
        .map(
          (e) => ArticleModel.fromJson(e),
        )
        .toList();
  }

  Future<List<SavedArticleModel>> showSavedArticles() async {
    var articlesList = await ArticlesServices().showSavedArticles();
    return articlesList
        .map(
          (e) => SavedArticleModel.fromJson(e),
        )
        .toList();
  }

  Future<List<ArticleModel>> showHotArticles() async {
    var articlesList = await ArticlesServices().showHotArticles();
    return articlesList
        .map(
          (e) => ArticleModel.fromJson(e),
        )
        .toList();
  }
}
