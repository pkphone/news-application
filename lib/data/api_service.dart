import 'package:dio/dio.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class APIService {
  factory APIService(Dio dio, {String baseUrl}) = _APIService;

  @retrofit.GET('/topic-headlines')
  Future<ArticleResponseModel> fetchArticles(
    @Query('topic') String topic,
    @Query('country') String country,
    @Query('lang') String lang,
    @Query('limit') String limit,
  );
}
