import 'package:news_application/data/models/article_model.dart';

abstract class LocalDataSource {
  Future<void> saveArticle(ArticleModel articleModel);
  Future<List<ArticleModel>> getSavedArticles();
  Future<ArticleModel> getSavedArticle(String publishedDate);
  Future<void> deleteSavedArticle(String publishedDate);
  Future<int> deleteSavedArticles();
}
