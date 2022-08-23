import 'package:dio/dio.dart';
import 'package:news_application/data/curl_generator.dart';
import 'package:news_application/data/logger.dart';

class CURLInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.i(CURLGenerator.getCURLFromRequest(options));
    options.headers.addAll({
      'X-RapidAPI-Key': '69ff2aeca5mshd999a3ee5928595p1f0b46jsn94d179238846',
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
