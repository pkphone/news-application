import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news_application/data/models/source_model.dart';
import 'package:news_application/domain/entities/article.dart';

part 'article_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class ArticleModel implements Article {
  ArticleModel({
    this.link,
    this.publishedDate,
    this.source,
    this.title,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  @override
  @HiveField(0)
  final String? link;

  @override
  @HiveField(1)
  @JsonKey(name: 'published_date')
  final String? publishedDate;

  @override
  @HiveField(2)
  final SourceModel? source;

  @override
  @HiveField(3)
  final String? title;

  @override
  List<Object?> get props => [
        link,
        publishedDate,
        source,
        title,
      ];

  @override
  bool? get stringify => true;
}
