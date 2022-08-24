import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_application/data/models/article_response_model.dart';

class ArticleBox implements Disposable {
  static const String _key = 'articleBox';

  final Box<ArticleResponseModel> _box;

  ArticleBox._(this._box);

  static Future<ArticleBox> get instance async {
    return ArticleBox._(await Hive.openBox<ArticleResponseModel>(_key));
  }

  foundation.ValueListenable<Box<ArticleResponseModel>> get listenable =>
      _box.listenable();

  Future saveArticles(ArticleResponseModel articleResponseModel) {
    return _box.put('article', articleResponseModel);
  }

  ArticleResponseModel getArticles() {
    return _box.get('article')!;
  }

  Future deleteArticles() {
    return _box.clear();
  }

  @override
  void dispose() {
    _box.close();
  }
}
