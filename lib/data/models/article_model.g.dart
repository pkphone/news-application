// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleModelAdapter extends TypeAdapter<ArticleModel> {
  @override
  final int typeId = 1;

  @override
  ArticleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleModel(
      link: fields[0] as String?,
      publishedDate: fields[1] as String?,
      source: fields[2] as SourceModel?,
      title: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.link)
      ..writeByte(1)
      ..write(obj.publishedDate)
      ..writeByte(2)
      ..write(obj.source)
      ..writeByte(3)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      link: json['link'] as String?,
      publishedDate: json['published_date'] as String?,
      source: json['source'] == null
          ? null
          : SourceModel.fromJson(json['source'] as Map<String, dynamic>),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'link': instance.link,
      'published_date': instance.publishedDate,
      'source': instance.source,
      'title': instance.title,
    };
