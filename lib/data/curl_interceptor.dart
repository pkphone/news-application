import 'package:dio/dio.dart';
import 'package:news_application/data/curl_generator.dart';
import 'package:news_application/data/logger.dart';

class CURLInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.i(CURLGenerator.getCURLFromRequest(options));
    options.headers.addAll({
      'X-RapidAPI-Key': '491749b4aamsh481dc94912ce182p10fe5cjsn802b35997b7d',
      'X-RapidAPI-Host': 'google-news1.p.rapidapi.com',
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.wtf(response.data);
    super.onResponse(response, handler);
  }
}
