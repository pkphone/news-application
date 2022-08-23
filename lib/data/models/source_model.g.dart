// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SourceModelAdapter extends TypeAdapter<SourceModel> {
  @override
  final int typeId = 2;

  @override
  SourceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SourceModel(
      title: fields[0] as String?,
      url: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SourceModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) => SourceModel(
      title: json['title'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$SourceModelToJson(SourceModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
    };
