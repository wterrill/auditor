import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/Conversion.dart';
// import 'package:intl/intl.dart';

List<CalendarResult> buildScheduledFromIncoming(
  dynamic listEvents,
  SiteList siteList,
) {
  // List<dynamic> listEvents = resultMap["Result"] as List<dynamic>;

  List<CalendarResult> finalList = [];
  if (listEvents != null) {
    for (dynamic event in listEvents) {
      String agencyName = siteList.agencyNameFromProgramNumber(event['ProgramNumber'] as String);
      String agencyNumber = event['AgencyNumber'] as String;
      String programNum = event['ProgramNumber'] as String;
      String programType = convertNumberToProgramType(event['ProgramType'] as int);
      String auditor = event['Auditor'] as String;
      String auditType = convertNumberToAuditType(event['AuditType'] as int);
      // String startTime = DateFormat('yyyy-MM-dd kk:mm:ss.000').format(DateTime.parse(event['StartTime'] as String));
      String startTime = DateTime.parse(event['StartTime'] as String).toString();
      String status = convertNumberToStatus(event['Status'] as int);
      Site siteInfo = siteList.getSiteFromProgramNumber(programNumber: event['ProgramNumber'] as String);
      siteInfo.agencyNumber ??= event['AgencyNumber'] as String;
      String siteidreceived = event['DeviceId'] as String;
      String key;
      if (auditType == "Follow Up") {
        if (programType == "Pantry") {
          key = "PantryFollowUp";
        } else if (programType == "Congregate") {
          key = "CongregateFollowUp";
        } else if (programType == "Healthy Student Market") {
          key = "PPCFollowUp";
        } else if (programType == "Older Adults Program") {
          key = "PPCFollowUp";
        }
      }
      Map<String, dynamic> citationsToFollowUp = event[key] as Map<String, dynamic>;

      if (citationsToFollowUp != null) {
        citationsToFollowUp.removeWhere((String key, dynamic value) => value == null);
        citationsToFollowUp.removeWhere((String key, dynamic value) => value == "");
      }

      // Map<String, dynamic> citationsToFollowUp =
      //     event['retrievedAuditToSend'] as Map<String, dynamic>;

      if (startTime != null) {
        CalendarResult newResult = CalendarResult(
            agencyName: agencyName,
            agencyNumber: agencyNumber,
            programNum: programNum,
            programType: programType,
            auditor: auditor,
            auditType: auditType,
            startTime: startTime,
            status: status,
            siteInfo: siteInfo,
            deviceid: siteidreceived,
            citationsToFollowUp: citationsToFollowUp);
        newResult.idNum = event['Id'].toString();
        newResult.uploaded = true;
        print(newResult.idNum);
        finalList.add(newResult);
      } else {
        print('$agencyName did not have a startTime associated with it');
      }
    }
  }

  return finalList;
}
