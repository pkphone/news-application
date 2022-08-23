import 'package:equatable/equatable.dart';
import 'package:news_application/domain/entities/article.dart';

abstract class ArticleResponse extends Equatable {
  const ArticleResponse({
    this.articles,
    this.statusCode,
  });

  final List<Article>? articles;
  final int? statusCode;
}
