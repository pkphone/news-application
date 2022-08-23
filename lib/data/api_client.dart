import 'package:dio/dio.dart';
import 'package:news_application/data/curl_interceptor.dart';
import 'package:news_application/presentation/utils/string_util.dart';

class APIClient {
  late Dio dio;

  APIClient() {
    final options = BaseOptions(
        baseUrl: StringUtil.baseUrl,
        connectTimeout: StringUtil.timeout,
        receiveTimeout: StringUtil.timeout);
    dio = Dio(options)
      ..interceptors.addAll(
        [
          CURLInterceptor(),
        ],
      );
  }
}
