import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/presentation/mobx/home_store.dart';
import 'package:news_application/presentation/utils/method_util.dart';
import 'package:news_application/presentation/utils/string_util.dart';
import 'package:news_application/presentation/widgets/topic_button_widget.dart';

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
        if (_homeStore.currentIndex == null ||
            _homeStore.errorMsg!.isNotEmpty) {
          return const SizedBox();
        }

        if (_homeStore.currentIndex == 0) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                if (_homeStore.currentIndex != null) {
                  _homeStore.nextArticle();
                  _homeStore.checkArticleIsInBox(_homeStore
                      .articleResponseModel!
                      .articles![_homeStore.currentIndex!]
                      .publishedDate!);
                }
              },
              icon: const Icon(
                Icons.chevron_right,
                size: 30.0,
              ),
              label: const Text(''),
            ),
          );
        }

        if (_homeStore.currentIndex ==
            _homeStore.articleResponseModel!.articles!.length - 1) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                _homeStore.previousArticle();
                _homeStore.checkArticleIsInBox(_homeStore.articleResponseModel!
                    .articles![_homeStore.currentIndex!].publishedDate!);
              },
              icon: const Icon(
                Icons.chevron_left,
                size: 30.0,
              ),
              label: const Text(''),
            ),
          );
        }

        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    _homeStore.previousArticle();
                    _homeStore.checkArticleIsInBox(_homeStore
                        .articleResponseModel!
                        .articles![_homeStore.currentIndex!]
                        .publishedDate!);
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 30.0,
                  ),
                  label: const Text(''),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_homeStore.currentIndex != null) {
                      _homeStore.nextArticle();
                      _homeStore.checkArticleIsInBox(_homeStore
                          .articleResponseModel!
                          .articles![_homeStore.currentIndex!]
                          .publishedDate!);
                    }
                  },
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 30.0,
                  ),
                  label: const Text(''),
                ),
              ),
            )
          ],
        );
      }),
      appBar: AppBar(
        title: const Text(
          StringUtil.appName,
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
                  Icons.save,
                  size: 40.0,
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
                (index) => Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TopicButtonWidget(
                    color: _homeStore.topicName == StringUtil.topics[index]
                        ? Colors.blue
                        : Colors.grey,
                    name: StringUtil.topics[index],
                    onPressed: () => _homeStore.fetchArticles(
                      StringUtil.topics[index],
                    ),
                  ),
                ),
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
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _homeStore.errorMsg!,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  Text(_homeStore.articleResponseModel!
                      .articles![_homeStore.currentIndex!].title!),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AnyLinkPreview(
                      key: Key(_homeStore.articleResponseModel!
                          .articles![_homeStore.currentIndex!].link!),
                      link: _homeStore.articleResponseModel!
                          .articles![_homeStore.currentIndex!].link!,
                      displayDirection: UIDirection.uiDirectionHorizontal,
                      cache: const Duration(microseconds: 1),
                      errorWidget: InkWell(
                        onTap: () {
                          MethodUtil.launch(_homeStore.articleResponseModel!
                              .articles![_homeStore.currentIndex!].link!);
                        },
                        child: SizedBox(
                          height: 200.0,
                          child: Center(
                              child: Text(
                            _homeStore.articleResponseModel!
                                .articles![_homeStore.currentIndex!].link!,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Text(
                      'Source by ${_homeStore.articleResponseModel!.articles![_homeStore.currentIndex!].source!.title!} ${_homeStore.articleResponseModel!.articles![_homeStore.currentIndex!].source!.url}'),
                  Text(
                    MethodUtil.dateConvert(
                      _homeStore.articleResponseModel!
                          .articles![_homeStore.currentIndex!].publishedDate!,
                    ),
                  ),
                  IconButton(
                    color:
                        _homeStore.articleIsInBox! ? Colors.blue : Colors.grey,
                    icon: const Icon(
                      Icons.bookmark,
                      size: 50.0,
                    ),
                    onPressed: () async {
                      await _homeStore.saveArticle(_homeStore
                          .articleResponseModel!
                          .articles![_homeStore.currentIndex!]);
                      _homeStore.checkArticleIsInBox(_homeStore
                          .articleResponseModel!
                          .articles![_homeStore.currentIndex!]
                          .publishedDate!);
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
