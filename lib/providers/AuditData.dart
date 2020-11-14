import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/PPCAuditData.dart';
import 'package:auditor/Definitions/PantryAuditData.dart';
import 'package:auditor/Definitions/CongregateAuditData.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/Conversion.dart';
import 'package:auditor/Utilities/handleSentryError.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:auditor/main.dart';
import 'package:auditor/providers/BuildAuditToSend.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';

import 'BuildAuditFromIncoming.dart';
import 'GeneralData.dart';
// import 'dart:typed_data';

class AuditData with ChangeNotifier {
  bool auditStarted = false;
  Audit activeAudit;
  Section activeSection;
  Box auditBox;
  // Box auditsToSendBox;
  Box auditOutBox;
  Audit retrievedAudit;
  CalendarResult activeCalendarResult;
  Uint8List foodDepositoryMonitorSignature;
  Uint8List certRepresentativeSignature;
  Uint8List siteRepresentativeSignature;
  String deviceidProvider;
  bool successfullySubmitted = false;
  List<Question> citations = [];
  List<Question> previousCitations = [];
  bool goToVerificationGoodPage = false;
  String contactEmail = "";
  String personInterviewed = "";

  AuditData() {
    initialize();
    initHive();
  }
/////////////// HIVE STUFF ////////////////
  void initHive() {
    Future auditBoxFuture = Hive.openBox<Audit>('auditBox');
    // Future auditToSendBoxFuture = Hive.openBox<Audit>('auditsToSendBox');
    Future auditOutBoxFuture = Hive.openBox<Audit>('auditOutBox');

    Future.wait<dynamic>([
      auditBoxFuture,
      // auditToSendBoxFuture,
      auditOutBoxFuture,
    ]).then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      auditBox = Hive.box<Audit>('auditBox');
      // auditsToSendBox = Hive.box<Audit>('auditsToSendBox');
      auditOutBox = Hive.box<Audit>('auditOutBox');
      notifyListeners();
    });
  }

  void prepAuditForSaving(Audit incomingAudit) {
    for (Section section in incomingAudit.sections) {
      if (section.status == Status.selected) {
        section.status = section.lastStatus;
      }
    }
  }

  void deleteAudit(CalendarResult calendarResult) {
    print(auditBox.keys.length);
    auditBox.delete(
        '${calendarResult.startDateTime}-${calendarResult.agencyNumber}-${calendarResult.programNum}-${calendarResult.auditor}-${calendarResult.auditType}');
    print(auditBox.keys.length);
  }

  void saveAuditLocally({Audit incomingAudit}) {
    if (incomingAudit == null) {
      incomingAudit = activeAudit;
    }
    if (!auditStarted) {
      prepAuditForSaving(incomingAudit);
    }
    if (incomingAudit != null) {
      Audit retrievedAudit = auditBox.get(
              '${incomingAudit.calendarResult.startTime}-${incomingAudit.calendarResult.agencyNumber}-${incomingAudit.calendarResult.programNum}-${incomingAudit.calendarResult.auditor}-${incomingAudit.calendarResult.auditType}')
          as Audit;
      if (retrievedAudit != null) {
        // only the put if the status is higher than what we already have:
        if (convertStatusToNumber(retrievedAudit.calendarResult.status) <=
            convertStatusToNumber(incomingAudit.calendarResult.status)) {
          DateTime temp = DateTime.parse(incomingAudit.calendarResult.startTime);

          auditBox.put(
              '${temp.toString()}-${incomingAudit.calendarResult.agencyNumber}-${incomingAudit.calendarResult.programNum}-${incomingAudit.calendarResult.auditor}-${incomingAudit.calendarResult.auditType}',
              incomingAudit);
        }
      } else {
        //this gets rid of the "T"
        DateTime temp = DateTime.parse(incomingAudit.calendarResult.startTime);
        auditBox.put(
            '${temp.toString()}-${incomingAudit.calendarResult.agencyNumber}-${incomingAudit.calendarResult.programNum}-${incomingAudit.calendarResult.auditor}-${incomingAudit.calendarResult.auditType}',
            incomingAudit);
      }
    }

    Section verificationSection;
    if (activeAudit != null) {
      for (var i = activeAudit.sections.length - 1; i > 1; i--) {
        if (activeAudit.sections[i].name == "Verification") {
          verificationSection = activeAudit.sections[i];
          break;
        }
      }
      if (checkAllSectionsDone() &&
              (Status.values.indexOf(verificationSection.status) < Status.values.indexOf(Status.available)) ||
          (activeAudit.calendarResult.auditType == "Follow Up" &&
              verificationSection.status != Status.selected &&
              verificationSection.status != Status.completed)) {
        if (verificationSection.status != Status.selected) {
          verificationSection.status = Status.available;
        }
      }

      if (!checkAllSectionsDone() &&
          (Status.values.indexOf(verificationSection.status) >= Status.values.indexOf(Status.available)) &&
          activeAudit.calendarResult.auditType != "Follow Up") {
        verificationSection.status = Status.disabled;
      }
    }
  }

  bool checkAllSectionsDone() {
    bool allQuestionsDone = true;
    for (Section section in activeAudit.sections) {
      if (section.name == "Confirm Details") {
        if (activeAudit.detailsConfirmed == true) {
          section.status = Status.completed;
        }
      } else {
        if (section.name == "Photos") {
          break;
        }
        print(section.name);
        print(section.status);
        if (section.status != Status.selected) {
          if (section.status != Status.completed) {
            allQuestionsDone = false;
            print("changed to false 1st");
          }
        } else {
          if (section.lastStatus != Status.completed) {
            allQuestionsDone = false;
            print("changed to false 2nd");
          }
        }
      }
    }
    print(allQuestionsDone);
    return allQuestionsDone;
  }

  Audit getAuditFromBox(CalendarResult calendarResult) {
    Audit retrievedAudit = auditBox.get(
            '${calendarResult.startTime}-${calendarResult.agencyNumber}-${calendarResult.programNum}-${calendarResult.auditor}-${calendarResult.auditType}')
        as Audit;
    return retrievedAudit;
  }

  Map<String, dynamic> getAuditCitationsObject(
      // this uses the questions in the citations object to create the outgoing citations object.
      // also called '
      {CalendarResult newCalendarResult,
      @required SiteList siteList}) {
    Audit retrievedAudit;
    // check to see if it's a reschedule of a followup audit
    if (newCalendarResult.auditType == "Follow Up") {
      DateTime translate =
          DateTime.parse(newCalendarResult.citationsToFollowUp['PreviousEvent']['StartTime'] as String);
      String agencyNumber = siteList.agencyNumberFromProgramNumber(
          newCalendarResult.citationsToFollowUp['PreviousEvent']['ProgramNumber'] as String);
      retrievedAudit = auditBox.get(
              '${translate.toString()}-${agencyNumber}-${newCalendarResult.citationsToFollowUp['PreviousEvent']['ProgramNumber']}-${newCalendarResult.citationsToFollowUp['PreviousEvent']['Auditor']}-${newCalendarResult.citationsToFollowUp['PreviousEvent']['AuditType']}')
          as Audit;
    } else {
      retrievedAudit = auditBox.get(
              '${newCalendarResult.startTime}-${newCalendarResult.agencyNumber}-${newCalendarResult.programNum}-${newCalendarResult.auditor}-${newCalendarResult.auditType}')
          as Audit;
    }

    Map<String, dynamic> citationsMap = <String, dynamic>{};

    for (Question citation in retrievedAudit.citations) {
      if (!citation.unflagged) {
        citationsMap[(citation.questionMap['databaseVar'] as String) + 'Flag'] = 1;
        citationsMap[(citation.questionMap['databaseVar'] as String) + 'ActionItem'] = citation.actionItem;
        citationsMap[(citation.questionMap['databaseVar'] as String) + 'OriginalAnswer'] = citation.userResponse;
        citationsMap[(citation.questionMap['databaseVar'] as String) + 'OriginalComments'] = citation.optionalComment;
      } else {
        String text = (citation.questionMap['databaseVar'] as String) + 'Flag';
        citationsMap[text] = 0;
        citationsMap[(citation.questionMap['databaseVar'] as String) + 'OriginalAnswer'] = citation.userResponse;
        citationsMap[(citation.questionMap['databaseVar'] as String) + 'OriginalComments'] = citation.optionalComment;
      }
    }
    return citationsMap;
  }

  void saveAuditToSend(Audit outgoingAudit) {
    Audit clonedOutgoingAudit = outgoingAudit.clone();
    //this gets rid of the "T"
    DateTime temp = DateTime.parse(outgoingAudit.calendarResult.startTime);

    auditOutBox.put(
        '${temp.toString()}-${clonedOutgoingAudit.calendarResult.agencyNumber}-${clonedOutgoingAudit.calendarResult.programNum}-${clonedOutgoingAudit.calendarResult.auditor}-${clonedOutgoingAudit.calendarResult.auditType}',
        clonedOutgoingAudit);
  }

  bool auditExists(CalendarResult calendarResult) {
    // if (calendarResult.startTime.contains("24:00:00.000")) {
    //   calendarResult.startTime = DateTime.parse(calendarResult.startTime).toString();
    // }
    retrievedAudit = auditBox.get(
            '${calendarResult.startTime}-${calendarResult.agencyNumber}-${calendarResult.programNum}-${calendarResult.auditor}-${calendarResult.auditType}')
        as Audit;
    print(retrievedAudit);
    if (retrievedAudit == null) {
      return false;
    } else {
      return true;
    }
  }

//////////////////////////// END OF HIVE STUFF ////////////////

  void updateGoToVerificationGoodPage(bool newValue) {
    goToVerificationGoodPage = newValue;
    notifyListeners();
  }

  void toggleFlag(int index) {
    citations[index].unflagged = !citations[index].unflagged;
    notifyListeners();
  }

  bool notHappyPath(Question question) {
    bool isHappy = true;
    if (question.happyPathResponse != null) {
      if (!question.happyPathResponse.contains(question.userResponse)) {
        isHappy = false;
      }
    }
    return !isHappy;
  }

  void makeCitations() {
    if (activeAudit.calendarResult.status == "Scheduled" || activeAudit.calendarResult.status == "Site Visit Req.") {
      for (Section section in activeAudit.sections) {
        List<String> avoid = []; //["Photos", "Intro", "Review", "Verification"];
        if (!avoid.contains(section.name)) {
          for (Question question in section.questions) {
            if (question.userResponse != null) {
              int indexToCitation = citationExists(question);
              if (notHappyPath(question)) {
                if (indexToCitation == -1) {
                  question.fromSectionName = section.name;
                  // question.optionalComment =
                  //     question.questionMap['actionItem'] as String;
                  citations.add(question);
                }
              } else {
                if (indexToCitation != -1) {
                  citations.removeAt(indexToCitation);
                }
              }
            }
          }
        }
      }
      // makeActionItems();
      activeAudit.citations = citations;
    }
  }

  int citationExists(Question question) {
    int index = -1;
    for (Question citation in citations) {
      index++;
      if (citation.text == question.text) {
        return index;
      }
    }
    return -1;
  }

  CalendarResult convertToThrowawayCalendarResult(Map<String, String> result) {
    CalendarResult created = CalendarResult(
      startTime: result['StartTime'],
      agencyName: result['AgencyName'],
      agencyNumber: result['AgencyNumber'],
      auditType: result['AuditType'],
      programNum: result['ProgramNumber'],
      programType: result['ProgramType'],
      auditor: result['Auditor'],
      status: null,
      message: null,
      deviceid: deviceidProvider,
      siteInfo: null,
      citationsToFollowUp: result['citationsToFollowUp'] as Map<String, dynamic>,
    );
    return created;
  }

  void buildQuestionFromCitation(CalendarResult calendarResult) {
    Map<String, dynamic> previousCitationsTemp = calendarResult.citationsToFollowUp;
    List<String> citationDatabaseVarsList = [];

    for (String key in previousCitationsTemp.keys) {
      if (key.contains("Flag")) {
        citationDatabaseVarsList.add(key.replaceFirst("Flag", ""));
      }
    }

    dynamic temp = calendarResult.citationsToFollowUp['PreviousEvent'].cast<String, String>();
    CalendarResult temp2 = convertToThrowawayCalendarResult(temp as Map<String, String>);
    Audit retrievedAudit = getAuditFromBox(temp2);
    if (retrievedAudit == null) {
      // First, method that uses what we were sent by the database.  Currently, this has some problems:
      // 1. I don't have access to what the user answered, so I have to guess using the happyPath
      // 2. For dropdown answers, this means that there can only be one "angry path".. otherwise I'll guess wrong
      // 3. I don't have access to the comments made on the question.
      for (Section section in activeAudit.sections) {
        for (Question question in section.questions) {
          String databaseVar = question.questionMap['databaseVar'] as String;
          if (citationDatabaseVarsList.contains(databaseVar)) {
            // found one
            if (previousCitationsTemp[databaseVar + 'Flag'] as int == 0) {
              question.unflagged = true;
            } else if (previousCitationsTemp[databaseVar + 'Flag'] as int == 1) {
              question.unflagged = false;
            }
            question.fromSectionName = section.name;

            question.actionItem = previousCitationsTemp[databaseVar + "ActionItem"] as String;

            List<String> happyPath = question.questionMap['happyPathResponse'] as List<String>;

            if (question.typeOfQuestion == "yesNo") {
              question.userResponse = happyPath.contains("Yes") ? "No" : "Yes";
            }
            if (question.typeOfQuestion == "issuesNoIssues") {
              List<String> happyPath = question.questionMap['happyPathResponse'] as List<String>;
              question.userResponse = happyPath.contains("Issues") ? "No Issues" : "Issues";
            }
            if (question.typeOfQuestion == "dropDown") {
              List<String> happyPath = question.questionMap['happyPathResponse'] as List<String>;
              List<String> menu = question.questionMap['menuItems'] as List<String>;
              List<String> difference = happyPath.toSet().difference(menu.toSet()).toList();
              if (difference.length >= 3) {
                print("oh crap");
              }
              difference.removeWhere((item) => item == 'Select');
              question.userResponse = difference[0];
            }

            citations.add(question);
          }
        }
      }
    } else {
      // this means that we found the audit in question.  Let's copy the questions directly
      for (var i = 0; i < activeAudit.sections.length; i++) {
        for (var j = 0; j < activeAudit.sections[i].questions.length; j++) {
          String databaseVar = activeAudit.sections[i].questions[j].questionMap['databaseVar'] as String;
          if (citationDatabaseVarsList.contains(databaseVar)) {
            // found one. copy the question over
            activeAudit.sections[i].questions[j] = retrievedAudit.sections[i].questions[j];
            citations.add(activeAudit.sections[i].questions[j]);
          }
        }
      }
      // previousCitations = citations;
      // activeAudit.citations = citations;
      // activeAudit.previousCitations = citations;
      // citations = citations;
    }
    previousCitations = citations;
    activeAudit.citations = citations;
    activeAudit.previousCitations = citations;
  }

  void notifyTheListeners() {
    notifyListeners();
  }

  void saveLastSectionStatus() {
    if (activeSection.status != Status.selected) {
      activeSection.lastStatus = activeSection.status;
    }
  }

  void updateSectionStatus(Status status) {
    print("in updateSectionStatus");
    if (status != activeSection.status) {
      // activeSection.status = status;
      activeSection.lastStatus = status;
      notifyListeners();
    }
  }

  void initialize() {
    print("initialized AuditData");
  }

  void toggleStartAudit() {
    auditStarted = !auditStarted;
    notifyListeners();
  }

  void resetAudit() {
    foodDepositoryMonitorSignature = null;
    certRepresentativeSignature = null;
    siteRepresentativeSignature = null;
    activeAudit = null;
    auditStarted = false;
    activeSection = null;
    activeCalendarResult = null;
    successfullySubmitted = false;
    citations = [];
    goToVerificationGoodPage = false;

    // actionItemList = [];
  }

  void loadExisting(CalendarResult calendarResult) {
    activeAudit = retrievedAudit;
    activeSection = activeAudit.sections[0];
    activeCalendarResult = calendarResult;
    certRepresentativeSignature = activeAudit.photoSig['certRepresentativeSignature'];
    siteRepresentativeSignature = activeAudit.photoSig['siteRepresentativeSignature'];
    foodDepositoryMonitorSignature = activeAudit.photoSig['foodDepositoryMonitorSignature'];
    if ((calendarResult.programType != "Older Adults Program" &&
        calendarResult.programType != "Healthy Student Market" &&
        calendarResult.auditType != "Follow Up")) {
      if (activeAudit.maxPoints == null) {
        updateMaxPoints(activeAudit);
        updateAuditScoring(activeAudit);
      }
    }

    print(activeAudit);
  }

  void createAuditClass(CalendarResult calendarResult) {
    if (calendarResult.programType == "Pantry") {
      activeAudit = Audit(questionnaire: pantryAuditSectionsQuestions, calendarResult: calendarResult);
      activeSection = activeAudit.sections[0];
      activeCalendarResult = calendarResult;
    }
    if (calendarResult.programType == "Congregate") {
      activeAudit = Audit(questionnaire: congregateAuditSectionsQuestions, calendarResult: calendarResult);
      activeSection = activeAudit.sections[0];
      activeCalendarResult = calendarResult;
    }

    if (calendarResult.programType == "Older Adults Program" ||
        calendarResult.programType == "Healthy Student Market") {
      activeAudit = Audit(questionnaire: pPCAuditSectionsQuestions, calendarResult: calendarResult);
      activeSection = activeAudit.sections[0];
      activeCalendarResult = calendarResult;
    }

    for (Question question in activeSection.questions) {
      print(question.text == "Email Contact:");
      if (question.text == "Email Contact:" && activeAudit.calendarResult.siteInfo.contactEmail != "") {
        question.userResponse = activeAudit.calendarResult.siteInfo.contactEmail + " ; ";
        contactEmail = activeAudit.calendarResult.siteInfo.contactEmail + " ; ";

        print("email updated");
      }
    }
    // calculatePoints(calendarResult);
    updateMaxPoints(activeAudit);
  }

  void updateMaxPoints(Audit audit) {
    if (audit.calendarResult.programType != "Older Adults Program" &&
        audit.calendarResult.programType != "Healthy Student Market" &&
        audit.calendarResult.auditType != "Follow Up") {
      audit.maxPoints = 0;
      audit.currentPoints = 0;
      audit.auditScore = 0.0;
      for (Section section in audit.sections) {
        section.maxPoints = 0;
        section.currentPoints = 0;
        section.sectionScore = 0.0;
        for (int i = 0; i < section.questions.length; i++) {
          if (section.questions[i].scoring != null) {
            section.maxPoints += section.questions[i].scoring;
          }
        }
        audit.maxPoints += section.maxPoints;
      }
      audit.maxPoints += 30;
    }
  }

  void updateAuditScoring(Audit audit) {
    for (Section section in audit.sections) {
      for (int i = 0; i < section.questions.length; i++) {
        if (section.questions[i].scoring != null) {
          print(i);
          tallySingleQuestion(index: i, section: section, audit: audit);
        }
      }
    }
    setFinal30Points();
    print(audit.currentPoints);

    if (audit.maxPoints != 0) audit.auditScore = 100 * audit.currentPoints / audit.maxPoints;
  }

  void tallySingleQuestion({@required int index, @required Section section, @required Audit audit}) {
    dynamic userResponse = section.questions[index].userResponse;
    List<String> happyPath = section.questions[index].happyPathResponse;
    int hasScore = section.questions[index].scoring;
    if (hasScore != null) {
      if (happyPath.contains(userResponse)) {
        if (!section.questions[index].scoreAdded) {
          section.currentPoints += hasScore;
          audit.currentPoints += hasScore;
          print('section currentPoints: ${section.currentPoints}');
          print('section maxPoints: ${section.maxPoints}');
        }
        section.questions[index].scoreAdded = true;
      } else {
        if (section.questions[index].scoreAdded) {
          section.currentPoints -= hasScore;
          audit.currentPoints -= hasScore;
        }
        section.questions[index].scoreAdded = false;
      }
    } // TODO 6307899103

    if (audit.maxPoints != 0) audit.auditScore = 100 * audit.currentPoints / audit.maxPoints;
    print('currentPoints: ${audit.currentPoints}');
    print('score: ${audit.maxPoints}');
    print('score: ${audit.auditScore}');
    setFinal30Points();
    if (audit.maxPoints != 0) audit.auditScore = 100 * audit.currentPoints / audit.maxPoints;
  }

  void setFinal30Points() {
    makeCitations();
    if (checkAllSectionsDone()) {
      print(citations.length);
      if (citations.length == 0) {
        if (!activeAudit.visitRequiredPointsAdded && !activeAudit.programHoldPointsAdded) {
          activeAudit.putProgramOnImmediateHold = false;
          activeAudit.programHoldPointsAdded = true;
          activeAudit.siteVisitRequired = false;
          activeAudit.visitRequiredPointsAdded = true;
          activeAudit.currentPoints += 30;
        }
      } else {
        // takeOffFinalPoints();
        if (activeAudit.visitRequiredPointsAdded == false && activeAudit.siteVisitRequired == false) {
          activeAudit.currentPoints += 10;
          activeAudit.visitRequiredPointsAdded = true;
        }
        if (activeAudit.programHoldPointsAdded == false && activeAudit.putProgramOnImmediateHold == false) {
          activeAudit.currentPoints += 20;
          activeAudit.programHoldPointsAdded = true;
        }
      }
    } else {
      takeOffFinalPoints();
    }
  }

  void takeOffFinalPoints() {
    if (activeAudit.visitRequiredPointsAdded == true && activeAudit.siteVisitRequired == false) {
      activeAudit.currentPoints -= 10;
      activeAudit.siteVisitRequired = null;
      activeAudit.visitRequiredPointsAdded = false;
    }

    if (activeAudit.programHoldPointsAdded == true && activeAudit.putProgramOnImmediateHold == false) {
      activeAudit.currentPoints -= 20;
      activeAudit.putProgramOnImmediateHold = null;
      activeAudit.programHoldPointsAdded = false;
    }
  }

  Section cycleSections(int offset) {
    int index = getSectionIndex(activeSection);
    index = index + offset;
    if (index == activeAudit.sections.length) {
      index = activeAudit.sections.length - 1;
    }
    if (index < 0) {
      index = 0;
    }
    return activeAudit.sections[index];
  }

  int getSectionIndex(Section section) {
    int index = 0;
    for (var i = 0; i < activeAudit.sections.length; i++) {
      if (section.name == activeAudit.sections[i].name) {
        index = i;
      }
    }
    return index;
  }

  void updateActiveSection(Section newSection) {
    if (['Photos', 'Review', 'Verification'].contains(activeSection.name)) {
      activeSection.status = Status.completed;
    } else {
      activeSection.status = activeSection.lastStatus;
    }
    activeSection = newSection;
    activeSection.lastStatus = activeSection.status;
    activeSection.status = Status.selected;
    notifyListeners();
  }

  void updateActiveSectionNext(Section newSection) {
    if (['Photos', 'Review', 'Verification'].contains(activeSection.name)) {
      activeSection.status = Status.completed;
    } else {
      activeSection.status = activeSection.lastStatus;
    }
    activeSection = newSection;
    activeSection.lastStatus = activeSection.status;
    activeSection.status = Status.selected;
    notifyListeners();
  }

  void updateActiveSectionPrevios(Section newSection) {
    if (['Photos', 'Review', 'Verification'].contains(activeSection.name)) {
      activeSection.status = Status.completed;
    } else {
      activeSection.status = activeSection.lastStatus;
    }
    activeSection = newSection;
    activeSection.lastStatus = activeSection.status;
    activeSection.status = Status.selected;
    notifyListeners();
  }

  void saveActiveAudit() {
    saveAuditLocally(incomingAudit: activeAudit);
  }

  void createNewAudit(CalendarResult calendarResult) {
    createAuditClass(calendarResult);
  }

  /////////////////////// sync stuff //////////////////////////
  void dataSync({BuildContext context, SiteList siteList, String deviceid, bool fullSync}) async {
    deviceidProvider = deviceid;
    await sendAuditsToCloud(deviceid);
    await getAuditsFromCloud(context: context, siteList: siteList, deviceid: deviceid, fullSync: fullSync);
  }
  // // // // // // // // // // //

  List<dynamic> getPicList(List<Uint8List> photoList) {
    List<dynamic> files = <dynamic>[];
    int i = 0;
    for (Uint8List picture in photoList) {
      String base64Image = base64Encode(picture);
      Map<String, String> file = {"Filename": i.toString(), "FileExtension": ".png", "FileContent": base64Image};
      files.add(file);
      i++;
    }
    return files;
  }

  String getPicListBody(Audit audit, String deviceid) {
    List<Uint8List> photoList = audit.photoList;
    List<dynamic> files = getPicList(photoList);

    String json = jsonEncode(<String, dynamic>{
      "AgencyNumber": audit.calendarResult.agencyNumber,
      "ProgramNumber": audit.calendarResult.programNum,
      "ProgramType": convertProgramTypeToNumber(audit.calendarResult.programType),
      "Auditor": audit.calendarResult.auditor,
      "AuditType": convertAuditTypeToNumber(audit.calendarResult.auditType),
      "StartTime": audit.calendarResult.startDateTime.toString(),
      "DeviceId": deviceid,
      "Files": files
    });

    return json;
  }

  // // // // // // // // // // //

  void forceAuditDataUpload({String deviceid}) {
    List<dynamic> dynKeys = auditBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      print(toBeSentKeys[i]);
      Audit preResult = auditBox.get(toBeSentKeys[i]) as Audit;
      Audit anotherEvent = preResult.clone();

      DateTime temp = DateTime.parse(anotherEvent.calendarResult.startTime);
      if (preResult.completed == true) {
        auditOutBox.put(
            '${temp.toString()}-${anotherEvent.calendarResult.agencyNumber}-${anotherEvent.calendarResult.programNum}-${anotherEvent.calendarResult.auditor}-${anotherEvent.calendarResult.auditType}',
            anotherEvent);
      }
    }
    // sendAuditsToCloud(deviceid);
    print("test");
  }

  void sendAuditsToCloud(String deviceid) async {
    List<dynamic> dynKeys = auditOutBox.keys.toList();
    List<String> toBeSentKeys = List<String>.from(dynKeys);
    for (var i = 0; i < toBeSentKeys.length; i++) {
      Audit result = auditOutBox.get(toBeSentKeys[i]) as Audit;
      print(toBeSentKeys[i]);
      print("before build");
      Map<String, dynamic> mainBody = buildAuditToSend(result, deviceidProvider);
      print("after build");
      String idNumOrErr = "-1";
      try {
        // import 'package:connectivity/connectivity.dart';
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          // I am connected to a mobile network. or a wifi network
          print("######### CONNECTED sendFullAudit list #########");
        } else {
          throw ("No internet connection found");
        }

        idNumOrErr =
            await FullAuditComms.sendFullAudit(auditToSend: mainBody, context: navigatorKey.currentContext).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            // Navigator.of(navigatorKey.currentContext).pop();
            // Dialogs.showMessage(
            //     context: navigatorKey.currentContext,
            //     message:
            //         "A timeout error has occurred while contacting the site data enpoint. Check internet connection",
            //     dismissable: true);
            return null;
          },
        ) as String;
      } catch (err) {
        idNumOrErr = "-1";
      }
      bool successful = false;
      String errorMessage = "";
      try {
        int.parse(idNumOrErr);
        successful = true;
        updateAuditID(toBeSentKeys[i], idNumOrErr);
      } catch (err) {
        errorMessage = idNumOrErr;
        handleSentryError(
            errorMessage: "Audit Upload attempt: " + errorMessage,
            auditor: Provider.of<GeneralData>(navigatorKey.currentContext, listen: false).username);
      }

      // void handleTSentryError(String errorMessage) async {
      //   await sentry.captureException(
      //     exception: errorMessage,
      //     stackTrace: "",
      //   );
      // }

      String picJson = getPicListBody(result, deviceid);
      bool successfulpic = false;
      try {
        // import 'package:connectivity/connectivity.dart';
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          // I am connected to a mobile network. or a wifi network
          print("######### CONNECTED upload pic list #########");
        } else {
          throw ("No internet connection found");
        }
        successfulpic = await FullAuditComms.uploadPicList(json: picJson, context: navigatorKey.currentContext) as bool;
      } catch (err) {
        successfulpic = false;
      }
      if (!successfulpic) {
        handleSentryError(
            errorMessage: "pic upload not successful",
            auditor: Provider.of<GeneralData>(navigatorKey.currentContext, listen: false).username);
      }
      if (successful) auditOutBox.delete(toBeSentKeys[i]);
    }
  }

  void updateAuditID(String indexString, String idNum) {
    String truncated = indexString.split(":::")[0];
    Audit result = auditBox.get(truncated) as Audit;
    result.idNum = idNum;
    result.uploaded = true;
    auditBox.put(truncated, result);
    print(auditBox.keys.toList());
  }

  bool checkAllActiveSent() {
    List<dynamic> dynKeys = auditBox.keys.toList();
    List<String> auditBoxKeys = List<String>.from(dynKeys);
    bool allSent = true;
    for (var i = 0; i < auditBoxKeys.length; i++) {
      Audit result = auditBox.get(auditBoxKeys[i]) as Audit;
      if (result.uploaded != true && result.completed == true) {
        allSent = false;
      }
    }
    return allSent;
  }

  void removePicAtIndex(int index) {
    activeAudit.photoList.removeAt(index);
    notifyListeners();
  }

  void getAuditsFromCloud({BuildContext context, SiteList siteList, String deviceid, bool fullSync}) async {
    int allNotMe = 0; // "1: Query All   0: Query All But Me"
    if (auditBox.keys.toList().length == 0 || fullSync == true) {
      allNotMe = 1;
    }
    dynamic fromServer = null;
    try {
      // import 'package:connectivity/connectivity.dart';
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a mobile network. or a wifi network
        print("######### CONNECTED getFullAudit list #########");
      } else {
        throw ("No internet connection found");
      }

      fromServer = await FullAuditComms.getFullAudit(
          allNotMe: allNotMe, deviceid: deviceid, context: navigatorKey.currentContext);
    } catch (err) {
      print(err);
      fromServer = null;
    }
    if (fromServer != null) {
      List<Audit> newAudits = await buildAuditFromIncoming(fromServer, siteList) as List<Audit>;
      print(newAudits);
      for (Audit audit in newAudits) {
        print(audit);

        saveAuditLocally(incomingAudit: audit);
      }
      notifyListeners();
    }
  }
}
