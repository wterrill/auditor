import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';

import 'Question.dart';
import 'Section.dart';

import 'package:hive/hive.dart';
import 'dart:typed_data';

part 'Audit.g.dart';

@HiveType(typeId: 6)
class Audit extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Section> sections = [];

  @HiveField(2)
  bool completed;

  @HiveField(3)
  List<String> metadata; // <-- this does nothing now.

  @HiveField(4)
  List<Map<String, List<Map<String, dynamic>>>> questionnaire;

  @HiveField(5)
  CalendarResult calendarResult;

  @HiveField(6)
  List<Question> citations = [];

  @HiveField(7)
  bool putProgramOnImmediateHold;

  @HiveField(8)
  Map<String, Uint8List> photoSig = {};

  @HiveField(9)
  List<Uint8List> photoList;

  @HiveField(10)
  bool siteVisitRequired;

  @HiveField(11)
  DateTime correctiveActionPlanDueDate;

  @HiveField(12)
  bool detailsConfirmed = false;

  @HiveField(13)
  bool activateConfirmDetails = false;

  @HiveField(14)
  List<String> actionItemList = [];

  @HiveField(15)
  List<Question> previousCitations = [];

  @HiveField(16)
  int maxPoints;

  @HiveField(17)
  int currentPoints;

  @HiveField(18)
  double auditScore;

  @HiveField(19)
  bool programHoldPointsAdded = false;

  @HiveField(20)
  bool visitRequiredPointsAdded = false;

  @HiveField(21)
  String idNum = "";
  @HiveField(22)
  bool uploaded = false;

  Audit({this.questionnaire, this.calendarResult}) {
    for (Map<String, List<Map<String, dynamic>>> section in questionnaire) {
      sections.add(Section(section: section));
      name = convertProgramTypeToOfficial(calendarResult.programType);
      photoList = [];
    }
  }

  String convertProgramTypeToOfficial(String programType) {
    String value = "Error in Name";
    switch (programType) {
      case ("Pantry"):
        value = "Pantry Policy / Procedures Checklist";
        break;
      case ("Congregate"):
        value = "Congregate Policy Checklist";
        break;
      case ("Older Adults Program"):
        value = "Senior Adults Policy Checklist";
        break;
      case ("Healthy Student Market"):
        value = "Healthy Student Policy Checklist";
        break;
    }
    return value;
  }

  Audit clone() {
    Audit clonedAudit = Audit(calendarResult: calendarResult, questionnaire: questionnaire);
    clonedAudit.name = name;
    clonedAudit.sections = List.from(sections);
    clonedAudit.completed = completed;
    // clonedAudit.metadata = List.from(metadata);

    clonedAudit.questionnaire = questionnaire;
    clonedAudit.citations = List.from(citations);
    clonedAudit.calendarResult = calendarResult;
    clonedAudit.putProgramOnImmediateHold = putProgramOnImmediateHold;
    clonedAudit.photoSig = Map.from(photoSig);
    clonedAudit.photoList = List.from(photoList);
    clonedAudit.siteVisitRequired = siteVisitRequired;
    clonedAudit.correctiveActionPlanDueDate = correctiveActionPlanDueDate;
    clonedAudit.detailsConfirmed = detailsConfirmed;
    clonedAudit.activateConfirmDetails = activateConfirmDetails;
    clonedAudit.actionItemList = actionItemList;
    clonedAudit.previousCitations = List.from(previousCitations);
    clonedAudit.maxPoints = maxPoints;
    clonedAudit.currentPoints = currentPoints;
    clonedAudit.auditScore = auditScore;
    clonedAudit.programHoldPointsAdded = programHoldPointsAdded;
    clonedAudit.visitRequiredPointsAdded = visitRequiredPointsAdded;
    clonedAudit.idNum = idNum;
    clonedAudit.uploaded = uploaded;
    return clonedAudit;
  }

  @override
  String toString() {
    print(
        '''calendarResult: ${calendarResult.toString()} \n citations: ${citations.toString()} \n previous citations: ${previousCitations.toString()} status: ${calendarResult.status}''');
    return '''calendarResult: ${calendarResult.toString()} \n citations: ${citations.toString()} \n previous citations: ${previousCitations.toString()} status: ${calendarResult.status}''';
  }
}
