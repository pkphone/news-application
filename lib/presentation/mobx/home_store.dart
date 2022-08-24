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
    result.fold(
      (failure) {
        errorMsg = failure.message;
      },
      (data) {
        // extract current date
        for (var article in data.articles!) {
          String serverDate = MethodUtil.dateConvert(article.publishedDate!);
          if (serverDate.split(' ')[0] == MethodUtil.getCurrentDate()) {
            articles.add(article);
          }
        }

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
      }
    }

    if (!isFound) {
      await _fetchArticle.executeSaveArticle(articleModel);
    }
  }

  @action
  Future getSavedArticles() async {
    isLoadingSavedArticlesPage = false;
    savedArticles.clear();
    savedArticles = await _fetchArticle.executeGetSavedArticles();
    isLoadingSavedArticlesPage = false;
  }
}
