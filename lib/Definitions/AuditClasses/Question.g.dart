// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final typeId = 8;

  @override
  Question read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      questionMap: (fields[10] as Map)?.cast<String, dynamic>(),
    )
      ..text = fields[0] as String
      ..typeOfQuestion = fields[1] as String
      ..userResponse = fields[2] as dynamic
      ..happyPathResponse = (fields[3] as List)?.cast<String>()
      ..dropDownMenu = (fields[4] as List)?.cast<String>()
      ..optionalComment = fields[5] as String
      ..note = fields[6] as String
      ..textBoxRollOut = fields[7] as bool
      ..completed = fields[8] as bool
      ..unflagged = fields[9] as bool
      ..displayVariable = fields[11] as String
      ..fromSectionName = fields[12] as String
      ..actionItem = fields[13] as String
      ..hideFollowUpActionItem = fields[14] as bool
      ..hideNa = fields[15] as bool
      ..highlight = fields[16] as bool
      ..scoring = fields[17] as int
      ..scoreAdded = fields[18] as bool;
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.typeOfQuestion)
      ..writeByte(2)
      ..write<dynamic>(obj.userResponse)
      ..writeByte(3)
      ..write(obj.happyPathResponse)
      ..writeByte(4)
      ..write(obj.dropDownMenu)
      ..writeByte(5)
      ..write(obj.optionalComment)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.textBoxRollOut)
      ..writeByte(8)
      ..write(obj.completed)
      ..writeByte(9)
      ..write(obj.unflagged)
      ..writeByte(10)
      ..write(obj.questionMap)
      ..writeByte(11)
      ..write(obj.displayVariable)
      ..writeByte(12)
      ..write(obj.fromSectionName)
      ..writeByte(13)
      ..write(obj.actionItem)
      ..writeByte(14)
      ..write(obj.hideFollowUpActionItem)
      ..writeByte(15)
      ..write(obj.hideNa)
      ..writeByte(16)
      ..write(obj.highlight)
      ..writeByte(17)
      ..write(obj.scoring)
      ..writeByte(18)
      ..write(obj.scoreAdded);
  }
}
