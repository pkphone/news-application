import 'package:dartz/dartz.dart';
import 'package:news_application/data/failure.dart';
import 'package:news_application/data/models/article_response_model.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, ArticleResponseModel>> fetchArticles();
}
