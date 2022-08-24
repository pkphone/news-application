import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/presentation/mobx/home_store.dart';
import 'package:news_application/presentation/utils/string_util.dart';
import 'package:news_application/presentation/widgets/article_item_widget.dart';

class SavedArticlesPage extends StatefulWidget {
  const SavedArticlesPage({Key? key}) : super(key: key);

  @override
  State<SavedArticlesPage> createState() => _SavedArticlesPageState();
}

class _SavedArticlesPageState extends State<SavedArticlesPage> {
  final HomeStore _homeStore = Modular.get<HomeStore>();

  @override
  void initState() {
    _homeStore.getSavedArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringUtil.savedArticles,
        ),
      ),
      body: Observer(builder: (_) {
        if (_homeStore.isLoadingSavedArticlesPage) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
            itemCount: _homeStore.savedArticles.length,
            itemBuilder: ((_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ArticleItemWidget(
                  articleModel: _homeStore.savedArticles[index],
                ),
              );
            }));
      }),
    );
  }
}
