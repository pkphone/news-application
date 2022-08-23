import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:news_application/data/models/article_response_model.dart';
import 'package:news_application/domain/usecases/article_usecase.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ArticleUsecase _fetchArticle = Modular.get<ArticleUsecase>();

  @observable
  bool isLoading = false;

  @observable
  ArticleResponseModel? articleResponseModel;

  @observable
  String? errorMsg;

  @observable
  int? currentIndex;

  @action
  Future fetchArticles() async {
    isLoading = true;
    errorMsg = '';
    currentIndex = 0;
    articleResponseModel = ArticleResponseModel();
    final result = await _fetchArticle.execute();
    result.fold(
      (failure) {
        errorMsg = failure.message;
      },
      (data) {
        articleResponseModel = data;
      },
    );
    isLoading = false;
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
}
