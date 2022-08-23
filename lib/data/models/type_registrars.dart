import 'package:hive/hive.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/data/models/source_model.dart';

void registerAdapters() {
  Hive.registerAdapter<ArticleResponseModel>(
    ArticleResponseModelAdapter(),
  );
  Hive.registerAdapter<ArticleModel>(
    ArticleModelAdapter(),
  );
  Hive.registerAdapter<SourceModel>(
    SourceModelAdapter(),
  );
}
