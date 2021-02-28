import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Utilities/FlatButtonToTextButton.dart';
import 'package:auditor/providers/AuditData.dart';
// import 'package:auditor/providers/GeneralData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FillInEmailInterview extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  // final Audit activeAudit;
  FillInEmailInterview({Key key, this.index, this.activeSection, this.questionAutoGroup}) : super(key: key);

  @override
  _FillInEmailInterviewState createState() => _FillInEmailInterviewState();
}

class _FillInEmailInterviewState extends State<FillInEmailInterview> {
  bool confirmButtonEnabled = false;
  String personInterviewed = "";
  String contactEmail = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController interviewController = TextEditingController();

  int index;

  @override
  void initState() {
    super.initState();
    index = widget.index;

    if (widget.activeSection.questions[index + 1].userResponse != "" &&
        widget.activeSection.questions[index + 1].userResponse != null) {
      emailController.text = widget.activeSection.questions[index + 1].userResponse as String;
      contactEmail = widget.activeSection.questions[index + 1].userResponse as String;
    }

    if (widget.activeSection.questions[index + 2].userResponse != "" &&
        widget.activeSection.questions[index + 2].userResponse != null) {
      interviewController.text = widget.activeSection.questions[index + 2].userResponse as String;
      personInterviewed = widget.activeSection.questions[index + 2].userResponse as String;
    }

    if (personInterviewed.length > 0 && emailValidated(contactEmail)) {
      confirmButtonEnabled = true;
    }
  }

  bool emailValidated(String emailString) {
    bool emailValidated = true;
    if (emailString == "") emailValidated = false;
    List<String> emailList = emailString.split(";");
    for (String email in emailList) {
      email = email.replaceAll(" ", "");
      if ((!email.contains(RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')) && email != "")) {
        emailValidated = false;
      }
    }
    print(emailList);
    print("wtf?");
    print(emailValidated);
    // Provider.of<GeneralData>(context, listen: false).emailValidated = emailValidated;
    return emailValidated;
  }

  @override
  Widget build(BuildContext context) {
    Audit activeAudit = Provider.of<AuditData>(context, listen: false).activeAudit;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: AutoSizeText(widget.activeSection.questions[index + 1].text,
                  maxLines: 1, group: widget.questionAutoGroup, style: ColorDefs.textBodyBlack20),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextField(
                  // readOnly: activeAudit.detailsConfirmed ? true : false, // Removed to allow for editing after the fact
                  enableInteractiveSelection: true,
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: ColorDefs.colorAudit2, width: 3),
                      ),
                      border: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: (widget.activeSection.questions[index].text == "Person Interviewed:")
                          ? "Enter Person Interviewed for this Audit "
                          : "Enter Site Contact Email(s) separated by ';'"),
                  controller: emailController,
                  onChanged: (value) {
                    widget.activeSection.questions[index + 1].userResponse = value;
                    contactEmail = value;

                    setState(() {
                      if (emailValidated(value) && personInterviewed.length > 0) {
                        confirmButtonEnabled = true;
                      } else {
                        confirmButtonEnabled = false;
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Container(
          height: 5,
        ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Row(
          children: [
            Expanded(
              flex: 2,
              child: AutoSizeText(widget.activeSection.questions[index + 2].text,
                  maxLines: 1, group: widget.questionAutoGroup, style: ColorDefs.textBodyBlack20),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextField(
                  // readOnly: activeAudit.detailsConfirmed ? true : false,  // Removed to allow for editing after the fact
                  enableInteractiveSelection: true,
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: ColorDefs.colorAudit2, width: 3),
                      ),
                      border: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: (widget.activeSection.questions[index + 2].text == "Person Interviewed:")
                          ? "Enter Person Interviewed for this Audit "
                          : "Enter Site Contact Email"),
                  controller: interviewController,
                  onChanged: (value) {
                    widget.activeSection.questions[index + 2].userResponse = value;
                    personInterviewed = value;
                    print(value);

                    setState(() {
                      if (emailValidated(contactEmail) && personInterviewed.length > 0) {
                        confirmButtonEnabled = true;
                      } else {
                        confirmButtonEnabled = false;
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Container(height: 5),
        if (!activeAudit.detailsConfirmed)
          FlatButtonX(
            // padding: EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
            childx: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                child: Text(
                  "Confirm",
                  style: TextStyle(fontSize: 20),
                )),
            textColorx: Colors.black,
            disabledColorx: ColorDefs.colorTopHeader,
            disabledTextColorx: ColorDefs.colorChatNeutral,
            colorx: ColorDefs.colorTopHeader,
            shapex: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(
                    color: confirmButtonEnabled //Provider.of<GeneralData>(context).confirmButtonEnabled
                        ? ColorDefs.colorAnotherDarkGreen
                        : ColorDefs.colorButtonNeutral,
                    width: 3.0)),
            onPressedx: !confirmButtonEnabled
                ? null
                : () {
                    activeAudit.detailsConfirmed = true;
                    activeAudit.calendarResult.actualStartDateTime = DateTime.now();
                    for (Section section in activeAudit.sections) {
                      if (section.name != "Pre-Fill") {
                        section.status = Status.available;
                        if (section.name == "Confirm Details") {
                          section.status = Status.selected;
                        }
                        section.lastStatus = Status.available;
                        widget.activeSection.status = Status.selected;
                        widget.activeSection.lastStatus = Status.completed;
                        if (activeAudit.calendarResult.auditType != "Follow Up") {
                          if (section.name == "Review") break;
                        }
                      }
                    }
                    for (Section section in activeAudit.sections) {
                      if (section.name == "*Developer*") {
                        section.status = Status.available;
                        section.lastStatus = Status.available;
                        widget.activeSection.status = Status.completed;
                        widget.activeSection.lastStatus = Status.completed;
                      }
                    }
                    setState(() {});
                    if (activeAudit.calendarResult.auditType == "Follow Up") {
                      Provider.of<AuditData>(context, listen: false).makeCitations();
                      Section goToSection;
                      for (Section section in activeAudit.sections) {
                        if (section.name == "Follow Up Review") {
                          goToSection = section;
                        }
                      }
                      Provider.of<AuditData>(context, listen: false).updateActiveSection(goToSection);
                    }
                    Provider.of<AuditData>(context, listen: false).personInterviewed = personInterviewed;
                    Provider.of<AuditData>(context, listen: false).contactEmail = contactEmail;
                    activeAudit.detailsConfirmed = true;
                    setState(() {});
                    Provider.of<AuditData>(context, listen: false).notifyTheListeners();
                  },
          ),
      ],
    );
  }
}
