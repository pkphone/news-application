import 'package:news_application/data/failure.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepo {
  Future<Either<Failure, ArticleResponseModel>> fetchArticles();
}
