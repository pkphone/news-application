// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
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

  late final _$fetchArticlesAsyncAction =
      AsyncAction('HomeStoreBase.fetchArticles', context: context);

  @override
  Future<dynamic> fetchArticles() {
    return _$fetchArticlesAsyncAction.run(() => super.fetchArticles());
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
isLoading: ${isLoading},
articleResponseModel: ${articleResponseModel},
errorMsg: ${errorMsg},
currentIndex: ${currentIndex}
    ''';
  }
}
