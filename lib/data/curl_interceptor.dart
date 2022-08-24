import 'package:dio/dio.dart';
import 'package:news_application/data/curl_generator.dart';
import 'package:news_application/data/logger.dart';

class CURLInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.i(CURLGenerator.getCURLFromRequest(options));
    options.headers.addAll({
      'X-RapidAPI-Key': '8c45c3eafemsh87ae471f7a1bd39p18d582jsn44250b973a58',
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
