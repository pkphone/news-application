import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_application/data/models/article_model.dart';

class SavedArticleBox implements Disposable {
  static const String _key = 'savedArticleBox';

  final Box<ArticleModel> _box;

  SavedArticleBox._(this._box);

  static Future<SavedArticleBox> get instance async {
    return SavedArticleBox._(await Hive.openBox<ArticleModel>(_key));
  }

  foundation.ValueListenable<Box<ArticleModel>> get listenable =>
      _box.listenable();

  Future<void> saveArticle(ArticleModel articleModel) async {
    return await _box.put(articleModel.publishedDate, articleModel);
  }

  List<ArticleModel> getArticles() {
    List<ArticleModel> articles = [];
    for (var key in _box.keys) {
      ArticleModel? article = _box.get(key);
      articles.add(article!);
    }
    return articles;
  }

  ArticleModel getArticle(String publishedDate) {
    return _box.get(publishedDate) ?? ArticleModel();
  }

  Future<void> deleteArticle(String publishedDate) async {
    await _box.delete(publishedDate);
  }

  Future<int> deleteArticles() async {
    return await _box.clear();
  }

  @override
  void dispose() {
    _box.close();
  }
}
