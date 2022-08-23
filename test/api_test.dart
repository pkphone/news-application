import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:news_application/data/api_service.dart';
import 'package:news_application/presentation/modules/app_module.dart';

main() async {
  initModule(AppModule());

  APIService apiService = Modular.get<APIService>();

  test('Fetch articles test', () async {
    var response = await apiService.fetchArticles('WORLD', 'US', 'en-US', '50');
    debugPrint('${response.articles}');
    final df = DateFormat('dd-MM-yyyy hh:mm:ss');
    var inputDate = DateTime.parse(response.articles![0].publishedDate!);
    debugPrint(df.format(inputDate));
  });
}
