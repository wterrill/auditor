// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SiteList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteListAdapter extends TypeAdapter<SiteList> {
  @override
  final typeId = 11;

  @override
  SiteList read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SiteList(
      siteList: (fields[0] as List)?.cast<Site>(),
    );
  }

  @override
  void write(BinaryWriter writer, SiteList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.siteList);
  }
}
