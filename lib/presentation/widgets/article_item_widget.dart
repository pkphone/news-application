import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/presentation/utils/method_util.dart';

class ArticleItemWidget extends StatelessWidget {
  const ArticleItemWidget({
    Key? key,
    required this.articleModel,
    required this.articleIsInBox,
    required this.onPressedSave,
  }) : super(key: key);

  final ArticleModel articleModel;
  final bool articleIsInBox;
  final Function() onPressedSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  articleModel.title!,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                color: articleIsInBox ? Colors.blue : Colors.grey,
                icon: const Icon(
                  Icons.bookmark,
                  size: 40.0,
                ),
                onPressed: onPressedSave,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 150.0,
            child: AnyLinkPreview(
              key: Key(articleModel.link!),
              link: MethodUtil.linkPreviewBugFix(articleModel.link!),
              displayDirection: UIDirection.uiDirectionHorizontal,
              cache: const Duration(microseconds: 1),
              errorWidget: InkWell(
                onTap: () {
                  MethodUtil.launch(articleModel.link!);
                },
                child: SizedBox(
                  height: 150.0,
                  child: Center(
                      child: Text(
                    articleModel.link!,
                  )),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 16.0),
              children: <TextSpan>[
                const TextSpan(
                  text: 'Source ',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: articleModel.source!.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                    text: ' ${articleModel.source!.url}',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        MethodUtil.launch(articleModel.source!.url!);
                      }),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Published on ${MethodUtil.dateConvert(
              articleModel.publishedDate!,
            )}',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
