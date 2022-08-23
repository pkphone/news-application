import 'package:equatable/equatable.dart';
import 'package:news_application/domain/entities/source.dart';

abstract class Article extends Equatable {
  const Article({
    this.link,
    this.publishedDate,
    this.source,
    this.title,
  });

  final String? link;
  final String? publishedDate;
  final Source? source;
  final String? title;
}
