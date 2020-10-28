import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeveloperPage extends StatelessWidget {
  final Audit activeAudit;
  const DeveloperPage({Key key, this.activeAudit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void fillOutAngryAudit() {
      print("filled");
      Audit activeAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
      activeAudit.siteVisitRequired = null;
      activeAudit.visitRequiredPointsAdded = false;
      activeAudit.programHoldPointsAdded = false;
      activeAudit.putProgramOnImmediateHold = null;
      Provider.of<AuditData>(context, listen: false).updateMaxPoints(activeAudit);
      Provider.of<AuditData>(context, listen: false).citations = [];
      activeAudit.citations = [];
      for (Section section in activeAudit.sections) {
        section.status = Status.completed;
        section.lastStatus = Status.completed;
        if (!(section.name == "Photos" ||
            section.name == "Review" ||
            section.name == "Verification" ||
            // section.name == "*Developer*" ||
            section.name == "Confirm Details")) {
          for (Question question in section.questions) {
            question.scoreAdded = false;
            switch (question.typeOfQuestion) {
              case ("display"):
                print("display");
                break;

              case ("yesNo"):
                print("yesNo");
                try {
                  String answer = question.happyPathResponse.contains("No") ? "Yes" : "No";
                  question.userResponse = answer;
                } catch (err) {
                  question.userResponse = "Yes";
                }
                question.optionalComment = question.text + " This, right here, is an optional comment";
                break;

              case ("issuesNoIssues"):
                print("issuesNoIssues");
                try {
                  String answer = question.happyPathResponse.contains("No Issues") ? "Issues" : "No Issues";
                  question.userResponse = answer;
                } catch (err) {
                  question.userResponse = "No Issues";
                }
                question.optionalComment = question.text + " This, right here, is an optional comment";
                break;

              case ("fillIn"):
                print("fillIn");
                if (!question.text.contains("If yes, how many and from where")) {
                  question.userResponse = question.text + " This, right here, is a mandatory comment";
                } else {
                  question.userResponse = "Illinois and Wisconsin";
                }

                break;

              case ("fillInNum"):
                print("fillInNum");
                question.userResponse = 12;
                break;

              case ("dropDown"):
                print("dropDown");

                try {
                  String answer = question.dropDownMenu[1];
                  for (String item in question.dropDownMenu) {
                    if (item != "Select") {
                      if (!question.happyPathResponse.contains(item)) {
                        answer = item;
                      }
                    }
                  }
                  question.userResponse = answer;
                } catch (err) {
                  question.userResponse = question.dropDownMenu[1];
                }
                question.optionalComment = question.text + " This, right here, is an optional comment";
                break;

              case ("yesNoNa"):
                print("yesNoNa");
                try {
                  String answer = question.happyPathResponse.contains("No") ? "Yes" : "No";
                  question.userResponse = answer;
                } catch (err) {
                  question.userResponse = 'N/A';
                }

                question.optionalComment = question.text + " This, right here, is an optional comment";
                break;

              case ("date"):
                print("date");
                print(question.userResponse);
                print(DateTime.now().toString());
                question.userResponse = DateTime.now().toString();
                question.optionalComment = question.text + " This, right here, is an optional comment";
                break;
            }
          }
        }
      }
      Provider.of<AuditData>(context, listen: false).updateAuditScoring(activeAudit);
      Provider.of<AuditData>(context, listen: false).notifyTheListeners();
    }

    void fillOutHappyAudit({bool almost}) {
      print("filled");

      Audit activeAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
      activeAudit.siteVisitRequired = null;
      activeAudit.visitRequiredPointsAdded = false;
      activeAudit.programHoldPointsAdded = false;
      activeAudit.putProgramOnImmediateHold = null;
      Provider.of<AuditData>(context, listen: false).updateMaxPoints(activeAudit);
      Provider.of<AuditData>(context, listen: false).citations = [];
      activeAudit.citations = [];

      for (Section section in activeAudit.sections) {
        if (almost) {
          if (section.name == "Photos" ||
              section.name == "Review" ||
              // section.name == "*Developer*" ||
              section.name == "Confirm Details") {
            section.status = Status.completed;
            section.lastStatus = Status.completed;
          } else {
            section.status = Status.inProgress;
            section.lastStatus = Status.inProgress;
          }
        } else {
          section.status = Status.completed;
          section.lastStatus = Status.completed;
        }
        if (!(section.name == "Photos" ||
            section.name == "Review" ||
            section.name == "Verification" ||
            // section.name == "*Developer*" ||
            section.name == "Confirm Details")) {
          for (int i = 0; i < section.questions.length; i++) {
            if (almost) {
              if (i == 0) {
                //&& section.name == "Complaints & Problems") {
                section.questions[i].userResponse = null;
                continue;
              }
            }
            section.questions[i].scoreAdded = false;
            switch (section.questions[i].typeOfQuestion) {
              case ("display"):
                print("display");
                break;

              case ("yesNo"):
                print("yesNo");
                try {
                  section.questions[i].userResponse = section.questions[i].happyPathResponse[0];
                } catch (err) {
                  section.questions[i].userResponse = "No";
                }
                section.questions[i].optionalComment =
                    section.questions[i].text + " This, right here, is an optional comment";
                break;

              case ("issuesNoIssues"):
                print("issuesNoIssues");
                try {
                  section.questions[i].userResponse = section.questions[i].happyPathResponse[0];
                } catch (err) {
                  section.questions[i].userResponse = "No Issues";
                }
                section.questions[i].optionalComment =
                    section.questions[i].text + " This, right here, is an optional comment";

                break;

              case ("fillIn"):
                print("fillIn");
                if (!section.questions[i].text.contains("If yes, how many and from where")) {
                  section.questions[i].userResponse =
                      section.questions[i].text + " This, right here, is a mandatory comment";
                } else {
                  section.questions[i].userResponse = "Illinois and Wisconsin";
                }

                break;

              case ("fillInNum"):
                print("fillInNum");
                section.questions[i].userResponse = 1;
                break;

              case ("dropDown"):
                print("dropDown");
                String first = section.questions[i].dropDownMenu[1];
                try {
                  if (section.questions[i].happyPathResponse.contains(first)) {
                    section.questions[i].userResponse = section.questions[i].dropDownMenu[1];
                  } else {
                    print("problem");
                  }
                } catch (err) {
                  section.questions[i].userResponse = section.questions[i].dropDownMenu[1];
                }
                section.questions[i].optionalComment =
                    section.questions[i].text + " This, right here, is an optional comment";
                // Provider.of<AuditData>(context, listen: false)
                // .tallySingleQuestion(index: i, section: section, audit: activeAudit);
                break;

              case ("yesNoNa"):
                print("yesNoNa");
                try {
                  section.questions[i].userResponse = section.questions[i]?.happyPathResponse[0];
                } catch (err) {
                  section.questions[i].userResponse = 'N/A';
                }

                section.questions[i].optionalComment =
                    section.questions[i].text + " This, right here, is an optional comment";
                break;

              case ("date"):
                print("date");
                print(section.questions[i].userResponse);
                print(DateTime.now().toString());
                section.questions[i].userResponse = DateTime.now().toString();
                section.questions[i].optionalComment =
                    section.questions[i].text + " This, right here, is an optional comment";
                break;
            }
          }
        }
      }
      Provider.of<AuditData>(context, listen: false).updateAuditScoring(activeAudit);
      Provider.of<AuditData>(context, listen: false).notifyTheListeners();
    }

    return Column(
      children: [
        Text(
          "Developer Page",
        ),
        RaisedButton(
            onPressed: () {
              fillOutHappyAudit(almost: false);
              Provider.of<AuditData>(context, listen: false).saveAuditLocally(incomingAudit: activeAudit);
            },
            child: Text("Fill out Audit -> Happy Path")),
        RaisedButton(
            onPressed: () {
              fillOutHappyAudit(almost: true);
              Provider.of<AuditData>(context, listen: false).saveAuditLocally(incomingAudit: activeAudit);
            },
            child: Text("Fill out Audit -> ALMOST Happy Path (1st question blank in Complaints)")),
        RaisedButton(
            onPressed: () {
              fillOutAngryAudit();
              Provider.of<AuditData>(context, listen: false).saveAuditLocally(incomingAudit: activeAudit);
            },
            child: Text("Fill out Audit -> Angry Path"))
      ],
    );
  }
}
