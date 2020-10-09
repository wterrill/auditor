import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';

import 'QuestionTypes/DateQuestion.dart';
import 'QuestionTypes/Display.dart';
import 'QuestionTypes/DropDownQuestion.dart';
// import 'QuestionTypes/FillInEmail.dart';
import 'QuestionTypes/FillInEmailInterview.dart';
// import 'QuestionTypes/FillInInterview.dart';
import 'QuestionTypes/FillInNumQuestion.dart';
import 'QuestionTypes/FillInQuestion.dart';
import 'QuestionTypes/IssuesNoIssuesQuestion.dart';
import 'QuestionTypes/YesNoNaQuestion.dart';
import 'QuestionTypes/YesNoQuestion.dart';

class AuditQuestions extends StatefulWidget {
  AuditQuestions({Key key, this.activeSection, this.activecalendarResult, @required this.activeAudit})
      : super(key: key);
  final Section activeSection;
  final CalendarResult activecalendarResult;
  final Audit activeAudit;

  @override
  _AuditQuestionsState createState() => _AuditQuestionsState();
}

class _AuditQuestionsState extends State<AuditQuestions> {
  ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    _scrollController = Provider.of<GeneralData>(context).questionScrollController;
    print("building auditQuestions");
    var questionAutoGroup = AutoSizeGroup();
    Widget built;
    (widget.activeSection == null)
        ? built = Text("")
        : built = Expanded(
            child: Scrollbar(
              // thickness: 2,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.activeSection?.questions?.length,
                itemBuilder: (BuildContext context, int index) {
                  return (widget.activeSection?.questions[index].typeOfQuestion != "fillInEmail" &&
                          widget.activeSection?.questions[index].typeOfQuestion != "fillInInterview")
                      ? Container(
                          color: index.isEven ? ColorDefs.colorAlternateDark : ColorDefs.colorAlternateLight,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                if (widget.activeSection?.questions[index].typeOfQuestion == "display")
                                  Display(
                                    key: UniqueKey(),
                                    index: index,
                                    activeSection: widget.activeSection,
                                    activeCalendarResult: widget.activecalendarResult,
                                  ),
                                if (widget.activeSection?.questions[index].typeOfQuestion == "yesNo")
                                  YesNoQuestion(
                                      key: UniqueKey(),
                                      index: index,
                                      activeSection: widget.activeSection,
                                      activeAudit: widget.activeAudit),
                                if (widget.activeSection?.questions[index].typeOfQuestion == "issuesNoIssues")
                                  IssuesNoIssuesQuestion(
                                      key: UniqueKey(),
                                      index: index,
                                      activeSection: widget.activeSection,
                                      activeAudit: widget.activeAudit),
                                if (widget.activeSection?.questions[index].typeOfQuestion == "fillIn")
                                  FillInQuestion(
                                      key: UniqueKey(),
                                      index: index,
                                      activeSection: widget.activeSection,
                                      activeAudit: widget.activeAudit,
                                      questionAutoGroup: questionAutoGroup),
                                // if (widget.activeSection?.questions[index].typeOfQuestion == "fillInInterview")
                                //   FillInInterview(
                                //       key: UniqueKey(),
                                //       index: index,
                                //       activeSection: widget.activeSection,
                                //       questionAutoGroup: questionAutoGroup),
                                // if (widget.activeSection?.questions[index].typeOfQuestion == "fillInEmail")
                                //   FillInEmail(
                                //       key: UniqueKey(),
                                //       index: index,
                                //       activeSection: widget.activeSection,
                                //       questionAutoGroup: questionAutoGroup),
                                if (widget.activeSection?.questions[index].typeOfQuestion == "fillInNum")
                                  FillInNumQuestion(
                                      key: UniqueKey(),
                                      index: index,
                                      activeSection: widget.activeSection,
                                      activeAudit: widget.activeAudit,
                                      questionAutoGroup: questionAutoGroup),
                                if (widget.activeSection?.questions[index].typeOfQuestion == "dropDown")
                                  DropDownQuestion(
                                      key: UniqueKey(),
                                      index: index,
                                      activeSection: widget.activeSection,
                                      activeAudit: widget.activeAudit,
                                      questionAutoGroup: questionAutoGroup),
                                if (widget.activeSection?.questions[index].typeOfQuestion == "date")
                                  DateQuestion(
                                    key: UniqueKey(),
                                    index: index,
                                    activeSection: widget.activeSection,
                                    activeAudit: widget.activeAudit,
                                    questionAutoGroup: questionAutoGroup,
                                  ),
                                if (widget.activeSection?.questions[index].typeOfQuestion == "yesNoNa")
                                  YesNoNaQuestion(
                                    key: UniqueKey(),
                                    index: index,
                                    activeSection: widget.activeSection,
                                    activeAudit: widget.activeAudit,
                                    questionAutoGroup: questionAutoGroup,
                                  ),
                                if (widget.activeSection?.questions[index].typeOfQuestion == "fillInEmailInterview")
                                  FillInEmailInterview(
                                    key: UniqueKey(),
                                    index: index,
                                    activeSection: widget.activeSection,
                                    questionAutoGroup: questionAutoGroup,
                                  ),
                              ],
                            ),
                          ))
                      : Container(color: Colors.blue);
                },
              ),
            ),
          );
    return built;
  }
}
