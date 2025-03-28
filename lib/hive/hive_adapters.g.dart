// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class TeaTimeAdapter extends TypeAdapter<TeaTime> {
  @override
  final int typeId = 0;

  @override
  TeaTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeaTime(
      timeInSec: (fields[0] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, TeaTime obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.timeInSec);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeaTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
