import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Definitions/PPCAuditData.dart';
import 'package:auditor/Definitions/PantryAuditData.dart';
import 'package:auditor/Definitions/CongregateAuditData.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'package:auditor/main.dart';
import 'dart:convert';
import 'package:http/http.dart' show Response, get;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
// import 'dart:io';

import 'AuditData.dart';
// import 'GeneralData.dart';

Future<dynamic> buildAuditFromIncoming(dynamic fromServer, SiteList siteList) async {
  List<Audit> newAudits = [];
  Audit newAudit;
  for (dynamic event in fromServer) {
    Map<String, dynamic> receivedAudit = event as Map<String, dynamic>;
    String auditTypeKey;
    if (convertNumberToProgramType(event['ProgramType'] as int) == "Pantry") {
      auditTypeKey = "PantryDetail";
    } else if (convertNumberToProgramType(event['ProgramType'] as int) == "Congregate") {
      auditTypeKey = "CongregateDetail";
    } else if (convertNumberToProgramType(event['ProgramType'] as int) == "Healthy Student Market" ||
        convertNumberToProgramType(event['ProgramType'] as int) == "Older Adults Program") {
      auditTypeKey = "PPCDetail";
    }

    Map<String, dynamic> incomingAudit = receivedAudit[auditTypeKey] as Map<String, dynamic>;

    if (incomingAudit != null && receivedAudit['StartTime'] != null) {
      CalendarResult newCalendarResult = CalendarResult(
        programType: convertNumberToProgramType(event['ProgramType'] as int),
        message: "",
        siteInfo: siteList.getSiteFromProgramNumber(programNumber: event['ProgramNumber'] as String),
        agencyNumber: event['AgencyNumber'] as String,
        programNum: event['ProgramNumber'] as String,
        agencyName: siteList.agencyNameFromProgramNumber(event['ProgramNumber'] as String),
        auditType: convertNumberToAuditType(event['AuditType'] as int),
        startTime: DateTime.parse(receivedAudit['StartTime'] as String).toString(),
        status: convertNumberToStatus(receivedAudit['Status'] as int),
        auditor: event['Auditor'] as String,
        deviceid: event['DeviceId'] as String,
      );
      print(event['DeviceId']);

      if (newCalendarResult.programType == "Pantry") {
        newAudit = Audit(calendarResult: newCalendarResult, questionnaire: pantryAuditSectionsQuestions);
      }

      if (newCalendarResult.programType == "Congregate") {
        newAudit = Audit(calendarResult: newCalendarResult, questionnaire: congregateAuditSectionsQuestions);
      }

      if (newCalendarResult.programType == "Healthy Student Market" ||
          newCalendarResult.programType == "Older Adults Program") {
        newAudit = Audit(calendarResult: newCalendarResult, questionnaire: pPCAuditSectionsQuestions);
      }

      List<String> missingDBVar = [];
      Map<String, dynamic> citationsMap;
      if (newAudit.calendarResult.programType == "Pantry") {
        citationsMap = receivedAudit["PantryCitations"] as Map<String, dynamic>;
      }
      if (newAudit.calendarResult.programType == "Congregate") {
        citationsMap = receivedAudit["CongregateCitations"] as Map<String, dynamic>;
      }

      if (newAudit.calendarResult.programType == "Healthy Student Market" ||
          newAudit.calendarResult.programType == "Older Adults Program") {
        citationsMap = receivedAudit["PPCCitations"] as Map<String, dynamic>;
      }

      // pantryCitations is a big object... we just need the data for the non-null pieces:
      // also, let's get a list of the databaseVars
      List<String> citationDatabaseVarsList = [];
      if (citationsMap != null) {
        citationsMap.removeWhere((key, dynamic value) => key == null || value == null);

        for (String key in citationsMap.keys) {
          if (key.contains("Flag")) {
            citationDatabaseVarsList.add(key.replaceFirst("Flag", ""));
          }
        }
      }

      // // we need to get the QuestionMap using the datavar.  ugh.
      // for (Map<String, List<Map<String, dynamic>>> section
      //     in pantryAuditSectionsQuestions) {}

      List<Question> citations = [];

      // Sections
      for (Section section in newAudit.sections) {
        print("-------------------" + section.name + "-------------------");
        if (section.name != "*Developer*") {
          // leave when changing *Developer*
          //Questions
          for (Question question in section.questions) {
            // get database variable
            String databaseVar = question.questionMap['databaseVar'] as String;
            print(databaseVar);
            // see if we can snag the question into the citations
            if (citationDatabaseVarsList.contains(databaseVar)) {
              // found one
              if (citationsMap[databaseVar + 'Flag'] as int == 0) {
                question.unflagged = true;
              } else if (citationsMap[databaseVar + 'Flag'] as int == 1) {
                question.unflagged = false;
              }
              question.fromSectionName = section.name;

              // question.unflagged = !question.unflagged;
              question.actionItem = citationsMap[databaseVar + "ActionItem"] as String;
              citations.add(question);
            }

            if (databaseVar != null) {
              dynamic value = incomingAudit[databaseVar];
              if (value == null && question.typeOfQuestion != "date") {
                print("Missing: $databaseVar");
                missingDBVar.add(databaseVar);
              } else {
                switch (question.typeOfQuestion) {
                  case ("display"):
                    print(question.text);
                    print('display');
                    print(incomingAudit[databaseVar]);
                    break;

                  case ("yesNo"):
                    print(question.text);
                    print('yesNo');
                    print(incomingAudit[databaseVar]);
                    try {
                      question.userResponse = incomingAudit[databaseVar] as bool ? "Yes" : "No";
                    } catch (err) {
                      question.userResponse = incomingAudit[databaseVar] as String;
                    }

                    question.optionalComment = incomingAudit[databaseVar + "Comments"] as String;

                    break;
                  case ("issuesNoIssues"):
                    print(question.text);
                    print('issuesNoIssues');
                    print(incomingAudit[databaseVar]);
                    question.userResponse = incomingAudit[databaseVar] as bool ? "No Issues" : "Issues";
                    question.optionalComment = incomingAudit[databaseVar + "Comments"] as String;

                    break;

                  case ("fillIn"):
                    print(question.text);
                    print('fillIn');
                    print(incomingAudit[databaseVar]);
                    question.userResponse = incomingAudit[databaseVar] as String;
                    question.optionalComment = incomingAudit[databaseVar + "Comments"] as String;

                    break;

                  case ("fillInInterview"):
                    print(question.text);
                    print('fillInInterview');
                    print(incomingAudit[databaseVar]);
                    question.userResponse = incomingAudit[databaseVar] as String;
                    Provider.of<AuditData>(navigatorKey.currentContext, listen: false).personInterviewed =
                        question.userResponse as String;

                    break;
                  case ("fillInEmail"):
                    print(question.text);
                    print('fillInInterview');
                    print(incomingAudit[databaseVar]);
                    question.userResponse = incomingAudit[databaseVar] as String;
                    Provider.of<AuditData>(navigatorKey.currentContext, listen: false).contactEmail =
                        question.userResponse as String;

                    break;

                  case ("fillInEmailInterview"):
                    print(question.text);
                    print('fillInEmailInterview');

                    break;

                  // fillInInterview
                  // fillInEmail

                  case ("fillInNum"):
                    print(question.text);
                    print('fillInNum');
                    print(incomingAudit[databaseVar]);
                    question.userResponse = incomingAudit[databaseVar] as int;
                    if (question.userResponse == 0) {
                      question.userResponse = "0";
                    }
                    question.optionalComment = incomingAudit[databaseVar + "Comments"] as String;
                    break;

                  case ("dropDown"):
                    print(question.text);
                    print('dropDown');
                    print(incomingAudit[databaseVar]);
                    if (incomingAudit[databaseVar] != null) {
                      try {
                        question.userResponse = incomingAudit[databaseVar] as String;
                      } catch (err) {
                        question.userResponse = question.dropDownMenu[incomingAudit[databaseVar] as int];
                      }
                    } else {
                      question.userResponse = 'Select';
                    }
                    question.optionalComment = incomingAudit[databaseVar + "Comments"] as String;
                    break;

                  case ("yesNoNa"):
                    print(question.text);
                    print('yesNoNa');
                    print(incomingAudit[databaseVar]);
                    if (incomingAudit[databaseVar] != null) {
                      // if (incomingAudit[databaseVar] as int == 1) {
                      //   question.userResponse = "Yes";
                      // }
                      // if (incomingAudit[databaseVar] as int == 0) {
                      //   question.userResponse = "No";
                      // }
                      // if (incomingAudit[databaseVar] as int == -1) {
                      //   question.userResponse = 'N/A';
                      //   // question.dd
                      // }

                      try {
                        if (incomingAudit[databaseVar] as int == 1) {
                          question.userResponse = "Yes";
                        } else if (incomingAudit[databaseVar] as int == 0) {
                          question.userResponse = "No";
                        } else if (incomingAudit[databaseVar] as int == -1) {
                          question.userResponse = "N/A";
                        }
                      } catch (err) {
                        try {
                          if (incomingAudit[databaseVar] as int == -1) {
                            question.userResponse = 'N/A';
                          } else {
                            print(incomingAudit[databaseVar]);
                          }
                        } catch (err) {
                          print(err);
                        }
                        // question.userResponse = incomingAudit[databaseVar] as String;
                      }

                      // (question.userResponse = incomingAudit[databaseVar] as int == 1) ? "Yes" : "No";
                    } else {
                      question.userResponse = "N/A";
                    }
                    question.optionalComment = incomingAudit[databaseVar + "Comments"] as String;
                    break;

                  case ("date"):
                    print(question.text);
                    print('date');
                    print(incomingAudit[databaseVar]);
                    if (incomingAudit[databaseVar] == null) {
                      question.userResponse = '1972-06-05 00:00:00.000';
                    } else {
                      question.userResponse = incomingAudit[databaseVar] as String;
                    }

                    question.optionalComment = incomingAudit[databaseVar + "Comments"] as String;
                    break;
                }
              }
            }
          }
        }
      } // end of questions
      newAudit.idNum = event['Id'].toString();
      newAudit.uploaded = true;
      print(newAudit.idNum);

      dynamic temp = incomingAudit['SiteVisitRequired'];
      newAudit.siteVisitRequired = temp as bool;

      // finally, add the citations created above.
      newAudit.citations = citations;

      if (incomingAudit['CertRepresentativeSignature'] != "" && incomingAudit['CertRepresentativeSignature'] != null)
        newAudit.photoSig['certRepresentativeSignature'] =
            Base64Decoder().convert(incomingAudit['CertRepresentativeSignature'] as String);
      if (incomingAudit['FoodDepositoryMonitorSignature'] != "" &&
          incomingAudit['FoodDepositoryMonitorSignature'] != null)
        newAudit.photoSig['foodDepositoryMonitorSignature'] =
            Base64Decoder().convert(incomingAudit['FoodDepositoryMonitorSignature'] as String);
      if (incomingAudit['SiteRepresentativeSignature'] != "" && incomingAudit['SiteRepresentativeSignature'] != null)
        newAudit.photoSig['siteRepresentativeSignature'] =
            Base64Decoder().convert(incomingAudit['SiteRepresentativeSignature'] as String);

      if (incomingAudit['CorrectiveActionPlanDueDate'] != null) {
        newAudit.correctiveActionPlanDueDate = DateTime.parse(incomingAudit['CorrectiveActionPlanDueDate'] as String);
      }
      if (incomingAudit['ImmediateHold'] != null) {
        newAudit.putProgramOnImmediateHold = incomingAudit['ImmediateHold'] as bool;
      }

      print(missingDBVar);
      for (Section section in newAudit.sections) {
        section.status = Status.completed;
      }
    }
    if (newAudit != null) {
      List<Uint8List> photoListx = [];
      try {
        List<dynamic> picUrls = event['PictureUrls'] as List<dynamic>;

        for (dynamic url in picUrls) {
          Response response = await get(url);
          photoListx.add(response.bodyBytes);
        }
        newAudit.photoList = photoListx;
      } catch (err) {
        print(err);
        print("no pics");
      }

      newAudit.detailsConfirmed = true;
      for (int i = 0; i < newAudit.sections.length; i++) {
        newAudit.sections[i].status = Status.completed;
      }
      newAudit.completed = true;

      newAudit.calendarResult.endDateTime = DateTime.parse(incomingAudit['EndOfAudit'] as String);
      print(incomingAudit['EndOfAudit'] as String);
      print(DateFormat("MM-dd-yyyy HH:mm:ss.000").format(newAudit.calendarResult.endDateTime));

      //   String endOfAudit = DateFormat("HH:mm:ss.000").format(outgoingAudit.calendarResult.endDateTime);
      // resultMap["EndOfAudit"] = endOfAudit;

      if (newAudit != null) {
        newAudits.add(newAudit);
      }
    } else {
      print("NO AUDIT DETECTED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  return newAudits;
}
