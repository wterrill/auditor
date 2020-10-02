// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Audit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuditAdapter extends TypeAdapter<Audit> {
  @override
  final typeId = 6;

  @override
  Audit read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Audit(
      questionnaire: (fields[4] as List)
          ?.map((dynamic e) => (e as Map)?.map((dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List)?.map((dynamic e) => (e as Map)?.cast<String, dynamic>())?.toList())))
          ?.toList(),
      calendarResult: fields[5] as CalendarResult,
    )
      ..name = fields[0] as String
      ..sections = (fields[1] as List)?.cast<Section>()
      ..completed = fields[2] as bool
      ..metadata = (fields[3] as List)?.cast<String>()
      ..citations = (fields[6] as List)?.cast<Question>()
      ..putProgramOnImmediateHold = fields[7] as bool
      ..photoSig = (fields[8] as Map)?.cast<String, Uint8List>()
      ..photoList = (fields[9] as List)?.cast<Uint8List>()
      ..siteVisitRequired = fields[10] as bool
      ..correctiveActionPlanDueDate = fields[11] as DateTime
      ..detailsConfirmed = fields[12] as bool
      ..activateConfirmDetails = fields[13] as bool
      ..actionItemList = (fields[14] as List)?.cast<String>()
      ..previousCitations = (fields[15] as List)?.cast<Question>()
      ..maxPoints = fields[16] as int
      ..currentPoints = fields[17] as int
      ..auditScore = fields[18] as double
      ..programHoldPointsAdded = fields[19] as bool
      ..visitRequiredPointsAdded = fields[20] as bool
      ..idNum = fields[21] as String
      ..uploaded = fields[22] as bool;
  }

  @override
  void write(BinaryWriter writer, Audit obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.sections)
      ..writeByte(2)
      ..write(obj.completed)
      ..writeByte(3)
      ..write(obj.metadata)
      ..writeByte(4)
      ..write(obj.questionnaire)
      ..writeByte(5)
      ..write(obj.calendarResult)
      ..writeByte(6)
      ..write(obj.citations)
      ..writeByte(7)
      ..write(obj.putProgramOnImmediateHold)
      ..writeByte(8)
      ..write(obj.photoSig)
      ..writeByte(9)
      ..write(obj.photoList)
      ..writeByte(10)
      ..write(obj.siteVisitRequired)
      ..writeByte(11)
      ..write(obj.correctiveActionPlanDueDate)
      ..writeByte(12)
      ..write(obj.detailsConfirmed)
      ..writeByte(13)
      ..write(obj.activateConfirmDetails)
      ..writeByte(14)
      ..write(obj.actionItemList)
      ..writeByte(15)
      ..write(obj.previousCitations) // <-- this was citiations
      ..writeByte(16)
      ..write(obj.maxPoints)
      ..writeByte(17)
      ..write(obj.currentPoints)
      ..writeByte(18)
      ..write(obj.auditScore)
      ..writeByte(19)
      ..write(obj.programHoldPointsAdded)
      ..writeByte(20)
      ..write(obj.visitRequiredPointsAdded)
      ..writeByte(21)
      ..write(obj.idNum)
      ..writeByte(22)
      ..write(obj.uploaded);
  }
}
