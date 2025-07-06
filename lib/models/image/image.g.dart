// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageEntityAdapter extends TypeAdapter<ImageEntity> {
  @override
  final int typeId = 0;

  @override
  ImageEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageEntity(
      url: fields[0] as String?,
      hdUrl: fields[1] as String?,
      title: fields[2] as String?,
      date: fields[3] as String?,
      explanation: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.hdUrl)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.explanation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
