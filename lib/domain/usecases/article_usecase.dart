import 'package:dartz/dartz.dart';
import 'package:news_application/data/failure.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/domain/repositories/article_repo.dart';

class ArticleUsecase {
  final ArticleRepo repository;

  ArticleUsecase(this.repository);

  Future<Either<Failure, ArticleResponseModel>> executeGetArticles(
      String topic) {
    return repository.getArticles(topic);
  }

  Future<void> executeSaveArticle(ArticleModel articleModel) async {
    repository.saveArticle(articleModel);
  }

  Future<ArticleModel> executeGetSavedArticle(String publishedDate) {
    return repository.getSavedArticle(publishedDate);
  }

  Future<List<ArticleModel>> executeGetSavedArticles() {
    return repository.getSavedArticles();
  }

  Future<ArticleResponseModel> executeGetLocalArticles() {
    return repository.getLocalArticles();
  }

  Future<void> deleteSavedArticle(String publishedDate) async {
    await repository.deleteSavedArticle(publishedDate);
  }
}
