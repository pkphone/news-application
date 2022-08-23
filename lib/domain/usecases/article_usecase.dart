import 'package:dartz/dartz.dart';
import 'package:news_application/data/failure.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/domain/repositories/article_repo.dart';

class ArticleUsecase {
  final ArticleRepo repository;

  ArticleUsecase(this.repository);

  Future<Either<Failure, ArticleResponseModel>> execute() {
    return repository.fetchArticles();
  }
}
