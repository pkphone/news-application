import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/data/api_service.dart';
import 'package:news_application/data/failure.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/data/repositories/article_repo_impl.dart';
import 'package:news_application/domain/repositories/remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  APIService service = Modular.get<APIService>();

  @override
  Future<Either<Failure, ArticleResponseModel>> fetchArticles(
      String topic) async {
    try {
      ArticleResponseModel articleResponseModel =
          await service.fetchArticles(topic, 'US', 'en-US', '50');

      ArticleRepoImpl articleRepoImpl = ArticleRepoImpl.instance;

      articleRepoImpl.deleteLocalArticles();
      articleRepoImpl.saveLocalArticles(articleResponseModel);

      ArticleResponseModel localArticleResponseModel =
          await articleRepoImpl.getLocalArticles();

      return Right(localArticleResponseModel);
    } on DioError catch (e) {
      if (e.response == null) {
        return Left(ServerFailure(e.message));
      } else {
        return Left(ServerFailure('${e.response!.data['message']}'));
      }
    }
  }
}
