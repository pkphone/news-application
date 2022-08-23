import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/data/api_service.dart';
import 'package:news_application/data/article_box.dart';
import 'package:news_application/data/failure.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/domain/repositories/remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  APIService service = Modular.get<APIService>();

  @override
  Future<Either<Failure, ArticleResponseModel>> fetchArticles() async {
    try {
      ArticleResponseModel articleResponseModel =
          await service.fetchArticles('WORLD', 'US', 'en-US', '50');

      ArticleBox articleBox = await ArticleBox.instance;
      articleBox.deleteArticles();
      articleBox.saveArticles(articleResponseModel);

      return Right(articleBox.getArticles());
    } on DioError catch (e) {
      return Left(ServerFailure('${e.response!.data['message']}'));
    }
  }
}
