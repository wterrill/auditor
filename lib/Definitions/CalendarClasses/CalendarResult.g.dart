// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalendarResult.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarResultAdapter extends TypeAdapter<CalendarResult> {
  @override
  final typeId = 1;

  @override
  CalendarResult read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarResult(
        startTime: fields[0] as String,
        agencyName: fields[1] as String,
        agencyNumber: fields[2] as String,
        auditType: fields[3] as String,
        programNum: fields[4] as String,
        programType: fields[5] as String,
        auditor: fields[6] as String,
        status: fields[7] as String,
        message: fields[8] as String,
        programTypeColor: fields[9] as Color,
        siteInfo: fields[11] as Site,
        deviceid: fields[12] as String,
        citationsToFollowUp: (fields[13] as Map)?.cast<String, dynamic>())
      ..startDateTime = fields[10] as DateTime
      ..endDateTime = fields[14] as DateTime
      ..idNum = fields[15] as String
      ..uploaded = fields[16] as bool
      ..actualStartDateTime = fields[17] as DateTime;
  }

  @override
  void write(BinaryWriter writer, CalendarResult obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.agencyName)
      ..writeByte(2)
      ..write(obj.agencyNumber)
      ..writeByte(3)
      ..write(obj.auditType)
      ..writeByte(4)
      ..write(obj.programNum)
      ..writeByte(5)
      ..write(obj.programType)
      ..writeByte(6)
      ..write(obj.auditor)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.message)
      ..writeByte(9)
      ..write(obj.programTypeColor)
      ..writeByte(10)
      ..write(obj.startDateTime)
      ..writeByte(11)
      ..write(obj.siteInfo)
      ..writeByte(12)
      ..write(obj.deviceid)
      ..writeByte(13)
      ..write(obj.citationsToFollowUp)
      ..writeByte(14)
      ..write(obj.endDateTime)
      ..writeByte(15)
      ..write(obj.idNum)
      ..writeByte(16)
      ..write(obj.uploaded)
      ..writeByte(17)
      ..write(obj.actualStartDateTime);
  }
}
