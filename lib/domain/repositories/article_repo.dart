import 'package:news_application/data/failure.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepo {
  Future<Either<Failure, ArticleResponseModel>> getArticles(String topic);
  Future<void> saveArticle(ArticleModel articleModel);
  Future<List<ArticleModel>> getSavedArticles();
  Future<ArticleModel> getSavedArticle(String publishedDate);
  Future<void> deleteSavedArticle(String publishedDate);
  Future<int> deleteSavedArticles();
}
