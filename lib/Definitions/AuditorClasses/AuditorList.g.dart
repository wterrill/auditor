// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuditorList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditorListAdapter extends TypeAdapter<AuditorList> {
  @override
  final typeId = 13;

  @override
  AuditorList read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuditorList(
      auditorList: (fields[0] as List)?.cast<Auditor>(),
    );
  }

  @override
  void write(BinaryWriter writer, AuditorList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.auditorList);
  }
}
