import 'dart:convert';

import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

String buildScheduledToSend(CalendarResult calendarResult, String addDelete, String deviceid) {
  String key;
  if (calendarResult.programType == "Pantry") {
    key = "PantryFollowUp";
  }
  if (calendarResult.programType == "Congregate") {
    key = "CongregateFollowUp";
  }

  if (calendarResult.programType == "Healthy Student Market") {
    key = "PPCFollowUp";
  }
  if (calendarResult.programType == "Older Adults Program") {
    key = "PPCFollowUp";
  }

  if (calendarResult.citationsToFollowUp != null) {
    Map<String, dynamic> finalObject = <String, dynamic>{};

    Map<String, dynamic> temp = calendarResult.citationsToFollowUp;
    dynamic initialObject = temp['PreviousEvent'];
    dynamic keys2 = initialObject.keys.toList();
    List<String> keys3 = keys2.cast<String>().toList() as List<String>;
    for (String key in keys3) {
      if (key == "ProgramType") {
        print(initialObject[key]);

        finalObject[key] = initialObject[key];
        // convertProgramTypeToNumber(initialObject[key] as String);

      } else if (key == "AuditType") {
        dynamic beer = initialObject[key];

        finalObject[key] = beer;

        print(finalObject[key]);
      } else {
        finalObject[key] = initialObject[key];
      }
    }

    calendarResult.citationsToFollowUp['PreviousEvent'] = finalObject;
  }

  String body = jsonEncode(<String, dynamic>{
    'AED': addDelete,
    'AgencyNumber': calendarResult.agencyNumber,
    'ProgramNumber': calendarResult.programNum,
    'ProgramType': convertProgramTypeToNumber(calendarResult.programType),
    'Auditor': calendarResult.auditor,
    'AuditType': convertAuditTypeToNumber(calendarResult.auditType),
    'StartTime': calendarResult.startDateTime.toString(),
    'DeviceId': kIsWeb ? "website" : deviceid,
    key: calendarResult.citationsToFollowUp,
    if (addDelete == "E") 'Status': convertStatusToNumber(calendarResult.status)
  });

  return body;
}
