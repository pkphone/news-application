import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/presentation/mobx/home_store.dart';
import 'package:news_application/presentation/utils/string_util.dart';
import 'package:news_application/presentation/widgets/article_item_widget.dart';

class SavedArticlesPage extends StatefulWidget {
  const SavedArticlesPage({
    Key? key,
    required this.publishedDate,
  }) : super(key: key);

  final String publishedDate;

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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
      body: Observer(builder: (_) {
        if (_homeStore.isLoadingSavedArticlesPage) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (_homeStore.savedArticles.isEmpty) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.collections_bookmark,
                  size: 40.0,
                ),
                Text(
                  StringUtil.savedArticlesEmpty,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
            itemCount: _homeStore.savedArticles.length,
            itemBuilder: ((_, index) {
              return Card(
                child: ArticleItemWidget(
                  articleModel: _homeStore.savedArticles[index],
                  articleIsInBox: true,
                  onPressedSave: (() async {
                    _homeStore.deleteSavedArticles(
                        _homeStore.savedArticles[index].publishedDate!);
                    // check current news is save or not when user changed in the saved list
                    if (widget.publishedDate ==
                        _homeStore.savedArticles[index].publishedDate!) {
                      _homeStore.checkArticleIsInBox(widget.publishedDate);
                    }
                  }),
                ),
              );
            }));
      }),
    );
  }
}
