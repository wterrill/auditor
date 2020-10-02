// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Site.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteAdapter extends TypeAdapter<Site> {
  @override
  final typeId = 10;

  @override
  Site read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Site(
      programNumber: fields[0] as String,
      programName: fields[1] as String,
      programDisplayName: fields[2] as String,
      agencyNumber: fields[3] as String,
      agencyName: fields[4] as String,
      address1: fields[5] as String,
      address2: fields[6] as String,
      city: fields[7] as String,
      state: fields[8] as String,
      zip: fields[9] as String,
      contact: fields[10] as String,
      operateHours: fields[11] as String,
      serviceArea: fields[12] as String,
      contactEmail: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Site obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.programNumber)
      ..writeByte(1)
      ..write(obj.programName)
      ..writeByte(2)
      ..write(obj.programDisplayName)
      ..writeByte(3)
      ..write(obj.agencyNumber)
      ..writeByte(4)
      ..write(obj.agencyName)
      ..writeByte(5)
      ..write(obj.address1)
      ..writeByte(6)
      ..write(obj.address2)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.state)
      ..writeByte(9)
      ..write(obj.zip)
      ..writeByte(10)
      ..write(obj.contact)
      ..writeByte(11)
      ..write(obj.operateHours)
      ..writeByte(12)
      ..write(obj.serviceArea)
      ..writeByte(13)
      ..write(obj.contactEmail);
  }
}
