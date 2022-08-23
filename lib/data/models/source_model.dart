import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news_application/domain/entities/source.dart';

part 'source_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class SourceModel implements Source {
  SourceModel({
    this.title,
    this.url,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceModelToJson(this);

  @override
  @HiveField(0)
  final String? title;
  @override
  @HiveField(1)
  final String? url;

  @override
  List<Object?> get props => [
        title,
        url,
      ];

  @override
  bool? get stringify => true;
}
