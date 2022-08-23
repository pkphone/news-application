// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleResponseModelAdapter extends TypeAdapter<ArticleResponseModel> {
  @override
  final int typeId = 0;

  @override
  ArticleResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleResponseModel(
      articles: (fields[0] as List?)?.cast<ArticleModel>(),
      statusCode: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.articles)
      ..writeByte(1)
      ..write(obj.statusCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleResponseModel _$ArticleResponseModelFromJson(
        Map<String, dynamic> json) =>
    ArticleResponseModel(
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCode: json['statusCode'] as int?,
    );

Map<String, dynamic> _$ArticleResponseModelToJson(
        ArticleResponseModel instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'statusCode': instance.statusCode,
    };
