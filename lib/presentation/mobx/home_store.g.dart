// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$isLoadingHomePageAtom =
      Atom(name: 'HomeStoreBase.isLoadingHomePage', context: context);

  @override
  bool get isLoadingHomePage {
    _$isLoadingHomePageAtom.reportRead();
    return super.isLoadingHomePage;
  }

  @override
  set isLoadingHomePage(bool value) {
    _$isLoadingHomePageAtom.reportWrite(value, super.isLoadingHomePage, () {
      super.isLoadingHomePage = value;
    });
  }

  late final _$articleResponseModelAtom =
      Atom(name: 'HomeStoreBase.articleResponseModel', context: context);

  @override
  ArticleResponseModel? get articleResponseModel {
    _$articleResponseModelAtom.reportRead();
    return super.articleResponseModel;
  }

  @override
  set articleResponseModel(ArticleResponseModel? value) {
    _$articleResponseModelAtom.reportWrite(value, super.articleResponseModel,
        () {
      super.articleResponseModel = value;
    });
  }

  late final _$errorMsgAtom =
      Atom(name: 'HomeStoreBase.errorMsg', context: context);

  @override
  String? get errorMsg {
    _$errorMsgAtom.reportRead();
    return super.errorMsg;
  }

  @override
  set errorMsg(String? value) {
    _$errorMsgAtom.reportWrite(value, super.errorMsg, () {
      super.errorMsg = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: 'HomeStoreBase.currentIndex', context: context);

  @override
  int? get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int? value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$articleIsInBoxAtom =
      Atom(name: 'HomeStoreBase.articleIsInBox', context: context);

  @override
  bool? get articleIsInBox {
    _$articleIsInBoxAtom.reportRead();
    return super.articleIsInBox;
  }

  @override
  set articleIsInBox(bool? value) {
    _$articleIsInBoxAtom.reportWrite(value, super.articleIsInBox, () {
      super.articleIsInBox = value;
    });
  }

  late final _$isLoadingSavedArticlesPageAtom =
      Atom(name: 'HomeStoreBase.isLoadingSavedArticlesPage', context: context);

  @override
  bool get isLoadingSavedArticlesPage {
    _$isLoadingSavedArticlesPageAtom.reportRead();
    return super.isLoadingSavedArticlesPage;
  }

  @override
  set isLoadingSavedArticlesPage(bool value) {
    _$isLoadingSavedArticlesPageAtom
        .reportWrite(value, super.isLoadingSavedArticlesPage, () {
      super.isLoadingSavedArticlesPage = value;
    });
  }

  late final _$articlesAtom =
      Atom(name: 'HomeStoreBase.articles', context: context);

  @override
  List<ArticleModel> get articles {
    _$articlesAtom.reportRead();
    return super.articles;
  }

  @override
  set articles(List<ArticleModel> value) {
    _$articlesAtom.reportWrite(value, super.articles, () {
      super.articles = value;
    });
  }

  late final _$topicNameAtom =
      Atom(name: 'HomeStoreBase.topicName', context: context);

  @override
  String? get topicName {
    _$topicNameAtom.reportRead();
    return super.topicName;
  }

  @override
  set topicName(String? value) {
    _$topicNameAtom.reportWrite(value, super.topicName, () {
      super.topicName = value;
    });
  }

  late final _$fetchArticlesAsyncAction =
      AsyncAction('HomeStoreBase.fetchArticles', context: context);

  @override
  Future<dynamic> fetchArticles(String topic) {
    return _$fetchArticlesAsyncAction.run(() => super.fetchArticles(topic));
  }

  late final _$checkArticleIsInBoxAsyncAction =
      AsyncAction('HomeStoreBase.checkArticleIsInBox', context: context);

  @override
  Future<dynamic> checkArticleIsInBox(String publishedDate) {
    return _$checkArticleIsInBoxAsyncAction
        .run(() => super.checkArticleIsInBox(publishedDate));
  }

  late final _$saveArticleAsyncAction =
      AsyncAction('HomeStoreBase.saveArticle', context: context);

  @override
  Future<dynamic> saveArticle(ArticleModel articleModel) {
    return _$saveArticleAsyncAction.run(() => super.saveArticle(articleModel));
  }

  late final _$getSavedArticlesAsyncAction =
      AsyncAction('HomeStoreBase.getSavedArticles', context: context);

  @override
  Future<dynamic> getSavedArticles() {
    return _$getSavedArticlesAsyncAction.run(() => super.getSavedArticles());
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void nextArticle() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.nextArticle');
    try {
      return super.nextArticle();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void previousArticle() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.previousArticle');
    try {
      return super.previousArticle();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingHomePage: ${isLoadingHomePage},
articleResponseModel: ${articleResponseModel},
errorMsg: ${errorMsg},
currentIndex: ${currentIndex},
articleIsInBox: ${articleIsInBox},
isLoadingSavedArticlesPage: ${isLoadingSavedArticlesPage},
articles: ${articles},
topicName: ${topicName}
    ''';
  }
}
