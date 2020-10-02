import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/programTypeTextAndColorLookup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hive/hive.dart';
part 'CalendarResult.g.dart';

@HiveType(typeId: 1)
class CalendarResult extends HiveObject {
  @HiveField(0)
  String startTime;
  @HiveField(1)
  final String agencyName;
  @HiveField(2)
  final String agencyNumber;
  @HiveField(3)
  String auditType;
  @HiveField(4)
  final String programNum;
  @HiveField(5)
  final String programType;
  @HiveField(6)
  String auditor;
  @HiveField(7)
  String status;
  @HiveField(8)
  final String message;
  @HiveField(9)
  Color programTypeColor;
  @HiveField(10)
  DateTime startDateTime;
  @HiveField(11)
  Site siteInfo;
  @HiveField(12)
  String deviceid;
  @HiveField(13)
  Map<String, dynamic> citationsToFollowUp;
  @HiveField(14)
  DateTime endDateTime;
  @HiveField(15)
  String idNum = "";
  @HiveField(16)
  bool uploaded = false;

  // String date;

  CalendarResult(
      {@required this.startTime,
      @required this.agencyName,
      @required this.agencyNumber,
      @required this.auditType,
      @required this.programNum,
      @required this.programType,
      @required this.auditor,
      @required this.status,
      this.message,
      this.programTypeColor,
      @required this.siteInfo,
      @required this.deviceid,
      this.citationsToFollowUp}) {
    startDateTime = DateTime.parse(startTime);
    var lookup = programTypeTextAndColorLookup(programType);
    programTypeColor = lookup["color"] as Color;
    print(programTypeColor);
  }

  String getStartTimeFormatted() {
    return DateFormat.jm().format(startDateTime).toString();
  }

  String getDateFormatted() {
    return DateFormat('MM-dd-yyyy').format(startDateTime).toString();
  }

  String getDateTimeFormatted() {
    return DateFormat('dd-MM-yyyy HH:mm').format(startDateTime).toString();
  }

  CalendarResult clone() {
    return CalendarResult(
        startTime: startTime,
        agencyName: agencyName,
        agencyNumber: agencyNumber,
        auditType: auditType,
        programNum: programNum,
        programType: programType,
        auditor: auditor,
        status: status,
        message: message,
        siteInfo: siteInfo,
        deviceid: deviceid,
        citationsToFollowUp: citationsToFollowUp);
  }

  String toString() {
    return ''' $startTime ,
      $agencyName,
      $agencyNumber,
      $auditType,
      $programNum,
      $programType,
      $auditor,
      $status,''';
  }

  bool selected = false;
}
