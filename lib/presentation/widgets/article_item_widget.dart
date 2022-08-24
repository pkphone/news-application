import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/presentation/utils/method_util.dart';

class ArticleItemWidget extends StatelessWidget {
  final ArticleModel articleModel;

  const ArticleItemWidget({
    Key? key,
    required this.articleModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(articleModel.title!),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: AnyLinkPreview(
            key: Key(articleModel.link!),
            link: articleModel.link!,
            displayDirection: UIDirection.uiDirectionHorizontal,
            cache: const Duration(microseconds: 1),
            errorWidget: InkWell(
              onTap: () {
                MethodUtil.launch(articleModel.link!);
              },
              child: SizedBox(
                height: 200.0,
                child: Center(
                    child: Text(
                  articleModel.link!,
                )),
              ),
            ),
          ),
        ),
        Text('Source by ${articleModel.title!} ${articleModel.source!.url}'),
        Text(
          MethodUtil.dateConvert(
            articleModel.publishedDate!,
          ),
        ),
      ],
    );
  }
}
