import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/data/failure.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/domain/repositories/article_repo.dart';
import 'package:news_application/domain/repositories/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class ArticleRepoImpl implements ArticleRepo {
  ArticleRepoImpl._();

  static final ArticleRepoImpl _repo = ArticleRepoImpl._();
  static ArticleRepoImpl get instance => _repo;

  RemoteDataSource remoteDataSource = Modular.get<RemoteDataSource>();

  @override
  Future<Either<Failure, ArticleResponseModel>> fetchArticles() async {
    return await remoteDataSource.fetchArticles();
  }
}
