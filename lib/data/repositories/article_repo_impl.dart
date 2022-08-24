import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/data/failure.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/domain/repositories/article_repo.dart';
import 'package:news_application/domain/repositories/local_data_source.dart';
import 'package:news_application/domain/repositories/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class ArticleRepoImpl implements ArticleRepo {
  ArticleRepoImpl._();

  static final ArticleRepoImpl _repo = ArticleRepoImpl._();
  static ArticleRepoImpl get instance => _repo;

  RemoteDataSource remoteDataSource = Modular.get<RemoteDataSource>();

  LocalDataSource localDataSource = Modular.get<LocalDataSource>();

  @override
  Future<Either<Failure, ArticleResponseModel>> getArticles(
      String topic) async {
    return await remoteDataSource.fetchArticles(topic);
  }

  @override
  Future<void> deleteSavedArticle(String publishedDate) async {
    await localDataSource.deleteSavedArticle(publishedDate);
  }

  @override
  Future<int> deleteSavedArticles() async {
    return await localDataSource.deleteSavedArticles();
  }

  @override
  Future<ArticleModel> getSavedArticle(String publishedDate) async {
    return await localDataSource.getSavedArticle(publishedDate);
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return await localDataSource.getSavedArticles();
  }

  @override
  Future<void> saveArticle(ArticleModel articleModel) async {
    await localDataSource.saveArticle(articleModel);
  }
}
