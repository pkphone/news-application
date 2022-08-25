import 'package:news_application/data/article_box.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/data/saved_article_box.dart';
import 'package:news_application/domain/repositories/local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> deleteSavedArticle(String publishedDate) async {
    SavedArticleBox savedArticleBox = await SavedArticleBox.instance;
    savedArticleBox.deleteArticle(publishedDate);
  }

  @override
  Future<int> deleteSavedArticles() async {
    SavedArticleBox savedArticleBox = await SavedArticleBox.instance;
    return await savedArticleBox.deleteArticles();
  }

  @override
  Future<ArticleModel> getSavedArticle(String publishedDate) async {
    SavedArticleBox savedArticleBox = await SavedArticleBox.instance;
    return savedArticleBox.getArticle(publishedDate);
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    SavedArticleBox savedArticleBox = await SavedArticleBox.instance;
    return savedArticleBox.getArticles();
  }

  @override
  Future<void> saveArticle(ArticleModel articleModel) async {
    SavedArticleBox savedArticleBox = await SavedArticleBox.instance;
    return savedArticleBox.saveArticle(articleModel);
  }

  @override
  Future<ArticleResponseModel> getLocalArticles() async {
    ArticleBox localArticleBox = await ArticleBox.instance;
    return localArticleBox.getArticles();
  }

  @override
  Future<int> deleteLocalArticle() async {
    ArticleBox localArticleBox = await ArticleBox.instance;
    return localArticleBox.deleteArticles();
  }

  @override
  Future<void> saveLocalArticle(
      ArticleResponseModel articleResponseModel) async {
    ArticleBox localArticleBox = await ArticleBox.instance;
    return localArticleBox.saveArticles(articleResponseModel);
  }
}
