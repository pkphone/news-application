import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/presentation/mobx/home_store.dart';
import 'package:news_application/presentation/utils/method_util.dart';
import 'package:news_application/presentation/utils/string_util.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore _homeStore = Modular.get<HomeStore>();

  @override
  void initState() {
    _homeStore.fetchArticles();
    super.initState();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
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
      ),
      body: Observer(builder: (_) {
        if (_homeStore.isLoading) {
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
                    _launchUrl(_homeStore.articleResponseModel!
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
          ],
        );
      }),
    );
  }
}
