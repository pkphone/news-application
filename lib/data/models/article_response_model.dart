import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news_application/data/models/article_model.dart';
import 'package:news_application/domain/entities/article_repsonse.dart';

part 'article_response_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ArticleResponseModel implements ArticleResponse {
  ArticleResponseModel({
    this.articles,
    this.statusCode,
  });

  factory ArticleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleResponseModelToJson(this);

  @override
  @HiveField(0)
  final List<ArticleModel>? articles;
  @override
  @HiveField(1)
  final int? statusCode;

  @override
  List<Object?> get props => [
        articles,
        statusCode,
      ];

  @override
  bool? get stringify => true;
}
