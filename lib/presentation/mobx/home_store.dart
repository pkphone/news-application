import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/domain/usecases/article_usecase.dart';
import 'package:news_application/presentation/utils/method_util.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ArticleUsecase _fetchArticle = Modular.get<ArticleUsecase>();

  @observable
  bool isLoadingHomePage = false;

  @observable
  String? errorMsg;

  @observable
  int? currentIndex;

  @observable
  bool? articleIsInBox = false;

  @observable
  bool isLoadingSavedArticlesPage = false;

  @observable
  List<ArticleModel> savedArticles = [];

  @observable
  String? topicName;

  @observable
  List<ArticleModel> articles = [];

  @action
  Future fetchArticles(String topic) async {
    isLoadingHomePage = true;
    errorMsg = '';
    currentIndex = 0;
    topicName = topic;
    articles.clear();
    final result = await _fetchArticle.executeGetArticles(topic);
    await result.fold(
      (failure) async {
        // extract data by current date
        final result = await _fetchArticle.executeGetLocalArticles();
        articles
            .addAll(MethodUtil.getArticlesFromCurrentDate(result.articles!));

        // check save or not
        if (articles.isNotEmpty) {
          checkArticleIsInBox(
            articles[0].publishedDate!,
          );
        }

        errorMsg = failure.message;
      },
      (data) async {
        // extract data by current date
        articles.addAll(MethodUtil.getArticlesFromCurrentDate(data.articles!));

        // check save or not
        if (articles.isNotEmpty) {
          checkArticleIsInBox(
            articles[0].publishedDate!,
          );
        }
      },
    );
    isLoadingHomePage = false;
  }

  @action
  void nextArticle() {
    if (currentIndex! < articles.length - 1) {
      currentIndex = currentIndex! + 1;
    }
  }

  @action
  void previousArticle() {
    if (currentIndex! > 0) {
      currentIndex = currentIndex! - 1;
    }
  }

  @action
  Future checkArticleIsInBox(String publishedDate) async {
    articleIsInBox = false;
    final result = await _fetchArticle.executeGetSavedArticle(publishedDate);
    if (result.publishedDate != null) {
      articleIsInBox = true;
    }
  }

  @action
  Future saveArticle(ArticleModel articleModel) async {
    List<ArticleModel> savedArticles = [];
    savedArticles = await _fetchArticle.executeGetSavedArticles();
    bool isFound = false;
    // check duplicate article
    for (ArticleModel savedArticleModel in savedArticles) {
      if (savedArticleModel.publishedDate == articleModel.publishedDate) {
        isFound = true;
        break;
      }
    }

    if (!isFound) {
      await _fetchArticle.executeSaveArticle(articleModel);
    } else {
      await _fetchArticle.deleteSavedArticle(articleModel.publishedDate!);
    }
  }

  @action
  Future getSavedArticles() async {
    isLoadingSavedArticlesPage = false;
    savedArticles.clear();
    savedArticles = await _fetchArticle.executeGetSavedArticles();
    isLoadingSavedArticlesPage = false;
  }

  @action
  Future deleteSavedArticles(String publishedDate) async {
    await _fetchArticle.deleteSavedArticle(publishedDate);
    savedArticles = await _fetchArticle.executeGetSavedArticles();
  }
}
