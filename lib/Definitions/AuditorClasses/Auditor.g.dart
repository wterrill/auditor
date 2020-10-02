// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Auditor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditorAdapter extends TypeAdapter<Auditor> {
  @override
  final typeId = 12;

  @override
  Auditor read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Auditor(auditorMap: (fields[0] as Map)?.cast<String, dynamic>())
      ..username = fields[1] as String
      ..firstName = fields[2] as String
      ..lastName = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Auditor obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.auditorMap)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName);
  }
}
