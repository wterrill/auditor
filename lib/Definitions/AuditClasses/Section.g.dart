// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Section.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final typeId = 9;

  @override
  Status read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Status.disabled;
      case 1:
        return Status.selected;
      case 2:
        return Status.available;
      case 3:
        return Status.inProgress;
      case 4:
        return Status.completed;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    switch (obj) {
      case Status.disabled:
        writer.writeByte(0);
        break;
      case Status.selected:
        writer.writeByte(1);
        break;
      case Status.available:
        writer.writeByte(2);
        break;
      case Status.inProgress:
        writer.writeByte(3);
        break;
      case Status.completed:
        writer.writeByte(4);
        break;
    }
  }
}

class SectionAdapter extends TypeAdapter<Section> {
  @override
  final typeId = 7;

  @override
  Section read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Section(
      section: (fields[0] as Map)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List)?.map((dynamic e) => (e as Map)?.cast<String, dynamic>())?.toList())),
    )
      ..name = fields[1] as String
      ..questions = (fields[2] as List)?.cast<Question>()
      ..status = fields[3] as Status
      ..lastStatus = fields[4] as Status
      ..maxPoints = fields[5] as int
      ..currentPoints = fields[6] as int
      ..sectionScore = fields[7] as double;
  }

  @override
  void write(BinaryWriter writer, Section obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.section)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.questions)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.lastStatus)
      ..writeByte(5)
      ..write(obj.maxPoints)
      ..writeByte(6)
      ..write(obj.currentPoints)
      ..writeByte(7)
      ..write(obj.sectionScore);
  }
}
