import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/domain/usecases/article_usecase.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ArticleUsecase _fetchArticle = Modular.get<ArticleUsecase>();

  @observable
  bool isLoadingHomePage = false;

  @observable
  ArticleResponseModel? articleResponseModel;

  @observable
  String? errorMsg;

  @observable
  int? currentIndex;

  @observable
  bool? articleIsInBox = false;

  @observable
  bool isLoadingSavedArticlesPage = false;

  @observable
  List<ArticleModel> articles = [];

  @action
  Future fetchArticles() async {
    isLoadingHomePage = true;
    errorMsg = '';
    currentIndex = 0;
    articleResponseModel = ArticleResponseModel();
    final result = await _fetchArticle.executeGetArticles();
    result.fold(
      (failure) {
        errorMsg = failure.message;
      },
      (data) {
        articleResponseModel = data;
        if (articleResponseModel!.articles!.isNotEmpty) {
          checkArticleIsInBox(
              articleResponseModel!.articles![0].publishedDate!);
        }
      },
    );
    isLoadingHomePage = false;
  }

  @action
  void nextArticle() {
    if (currentIndex! < articleResponseModel!.articles!.length - 1) {
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
    articles = await _fetchArticle.executeGetSavedArticles();
    isLoadingSavedArticlesPage = false;
  }
}
