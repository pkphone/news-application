import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_application/presentation/mobx/home_store.dart';
import 'package:news_application/presentation/utils/string_util.dart';
import 'package:news_application/presentation/widgets/article_item_widget.dart';
import 'package:news_application/presentation/widgets/common_button_widget.dart';
import 'package:news_application/presentation/widgets/topic_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore _homeStore = Modular.get<HomeStore>();

  @override
  void initState() {
    _homeStore.fetchArticles(StringUtil.topics[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Observer(builder: (_) {
        if (_homeStore.currentIndex == null || _homeStore.isLoadingHomePage) {
          return const SizedBox();
        } else if (_homeStore.articles.length <= 1) {
          return const SizedBox();
        } else if (_homeStore.currentIndex == 0) {
          return Row(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: CommonButtonWidget(
                  icon: Icons.chevron_right,
                  onPressed: () {
                    if (_homeStore.currentIndex != null) {
                      _homeStore.nextArticle();
                      _homeStore.checkArticleIsInBox(_homeStore
                          .articles[_homeStore.currentIndex!].publishedDate!);
                    }
                  },
                ),
              ),
            ],
          );
        } else if (_homeStore.currentIndex == _homeStore.articles.length - 1) {
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: CommonButtonWidget(
                  icon: Icons.chevron_left,
                  onPressed: () {
                    _homeStore.previousArticle();
                    _homeStore.checkArticleIsInBox(_homeStore
                        .articles[_homeStore.currentIndex!].publishedDate!);
                  },
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: CommonButtonWidget(
                icon: Icons.chevron_left,
                onPressed: () {
                  _homeStore.previousArticle();
                  _homeStore.checkArticleIsInBox(_homeStore
                      .articles[_homeStore.currentIndex!].publishedDate!);
                },
              ),
            ),
            Expanded(
              child: CommonButtonWidget(
                icon: Icons.chevron_right,
                onPressed: () {
                  if (_homeStore.currentIndex != null) {
                    _homeStore.nextArticle();
                    _homeStore.checkArticleIsInBox(_homeStore
                        .articles[_homeStore.currentIndex!].publishedDate!);
                  }
                },
              ),
            )
          ],
        );
      }),
      appBar: AppBar(
        title: const Text(
          StringUtil.appName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Modular.to.pushNamed(
                    '/home/saved-articles',
                  );
                },
                icon: const Icon(
                  Icons.collections_bookmark,
                  size: 30.0,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Observer(builder: (_) {
            return Wrap(
              children: List.generate(
                StringUtil.topics.length,
                (index) => TopicItemWidget(
                    topic: _homeStore.topicName!,
                    index: index,
                    onPressed: () {
                      // prevent frequent button press
                      if (!_homeStore.isLoadingHomePage) {
                        _homeStore.fetchArticles(
                          StringUtil.topics[index],
                        );
                      }
                    }),
              ),
            );
          }),
          Expanded(
            child: Observer(builder: (_) {
              if (_homeStore.isLoadingHomePage) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (_homeStore.errorMsg!.isNotEmpty) {
                Fluttertoast.showToast(
                    msg: _homeStore.errorMsg!,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }

              if (_homeStore.articles.isEmpty &&
                  _homeStore.errorMsg!.isNotEmpty) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.book,
                        size: 40.0,
                      ),
                      Text(
                        StringUtil.articlesLocalEmpty,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (_homeStore.articles.isEmpty &&
                  _homeStore.errorMsg!.isEmpty) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.book,
                        size: 40.0,
                      ),
                      Text(
                        StringUtil.articlesEmpty,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // reset error message
              _homeStore.errorMsg = '';

              return ArticleItemWidget(
                articleModel: _homeStore.articles[_homeStore.currentIndex!],
                articleIsInBox: _homeStore.articleIsInBox!,
                onPressedSave: (() async {
                  await _homeStore.saveArticle(
                      _homeStore.articles[_homeStore.currentIndex!]);
                  _homeStore.checkArticleIsInBox(_homeStore
                      .articles[_homeStore.currentIndex!].publishedDate!);
                }),
              );
            }),
          ),
        ],
      ),
    );
  }
}
