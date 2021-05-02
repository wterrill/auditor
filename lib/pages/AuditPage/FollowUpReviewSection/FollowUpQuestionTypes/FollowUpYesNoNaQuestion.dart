// import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FollowUpCommentSection.dart';
import 'commonQuestionMethods.dart';

class FollowUpYesNoNaQuestion extends StatefulWidget {
  final int index;
  final List<Question> citations;
  final AutoSizeGroup questionAutoGroup;
  FollowUpYesNoNaQuestion({
    Key key,
    this.index,
    this.citations,
    this.questionAutoGroup,
  }) : super(key: key);

  @override
  _FollowUpYesNoNaQuestionState createState() => _FollowUpYesNoNaQuestionState();
}

class _FollowUpYesNoNaQuestionState extends State<FollowUpYesNoNaQuestion> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    // Section activeSection = widget.activeSection;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AutoSizeText(widget.citations[index].text,
                  maxLines: 3, group: widget.questionAutoGroup, style: ColorDefs.textBodyBlack20),
            ),
            GestureDetector(
              onTap: () {
                if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status != "Scheduled") {
                  Dialogs.showMessage(
                      context: context,
                      message: "This audit has already been submitted, and cannot be edited",
                      dismissable: true,
                      textStyle: ColorDefs.textWhiteTerminal,
                      bckcolor: ColorDefs.colorDarkBackground);
                } else {
                  String result = setQuestionValue(widget.citations[index].userResponse as String, "Yes");
                  widget.citations[index].userResponse = result;
                  // Provider.of<AuditData>(context, listen: false)
                  //     .updateSectionStatus(
                  //         checkSectionDone(widget.activeSection));
                  // Audit thisAudit =
                  //     Provider.of<AuditData>(context, listen: false)
                  //         .activeAudit;
                  Provider.of<AuditData>(context, listen: false).saveAuditLocally();
                  setState(() {});
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: buttonColorPicker(widget.citations[index], "Yes"),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 80,
                child: Center(child: Text("Yes", style: ColorDefs.textBodyBlack20)),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status != "Scheduled") {
                  Dialogs.showMessage(
                      context: context,
                      message: "This audit has already been submitted, and cannot be edited",
                      dismissable: true,
                      textStyle: ColorDefs.textWhiteTerminal,
                      bckcolor: ColorDefs.colorDarkBackground);
                } else {
                  String result = setQuestionValue(widget.citations[index].userResponse as String, "No");
                  widget.citations[index].userResponse = result;
                  // Provider.of<AuditData>(context, listen: false)
                  //     .updateSectionStatus(
                  //         checkSectionDone(widget.activeSection));
                  // Audit thisAudit =
                  //     Provider.of<AuditData>(context, listen: false)
                  //         .activeAudit;
                  Provider.of<AuditData>(context, listen: false).saveAuditLocally();
                  setState(() {});
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: buttonColorPicker(widget.citations[index], "No"),
                  borderRadius: BorderRadius.circular(20.0),
                  // border:
                  //     Border.all(width: 2.0, color: Colors.grey)
                ),
                width: 80,
                child: Center(child: Text("No", style: ColorDefs.textBodyBlack20)),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status != "Scheduled") {
                  Dialogs.showMessage(
                      context: context,
                      message: "This audit has already been submitted, and cannot be edited",
                      dismissable: true,
                      textStyle: ColorDefs.textWhiteTerminal,
                      bckcolor: ColorDefs.colorDarkBackground);
                } else {
                  String result = setQuestionValue(widget.citations[index].userResponse as String, 'N/A');
                  widget.citations[index].userResponse = result;
                  // Provider.of<AuditData>(context, listen: false)
                  //     .updateSectionStatus(
                  //         checkSectionDone(widget.activeSection));
                  // Audit thisAudit =
                  //     Provider.of<AuditData>(context, listen: false)
                  //         .activeAudit;
                  Provider.of<AuditData>(context, listen: false).saveAuditLocally();
                  setState(() {});
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: buttonColorPicker(widget.citations[index], 'N/A'),
                  borderRadius: BorderRadius.circular(20.0),
                  // border:
                  //     Border.all(width: 2.0, color: Colors.grey)
                ),
                width: 80,
                child: Center(child: Text("N/A", style: ColorDefs.textBodyBlack20)),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.citations[index].textBoxRollOut = !widget.citations[index].textBoxRollOut;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.chat_bubble,
                    size: ColorDefs.chatBubbleSize,
                    color: widget.citations[index].optionalComment == null
                        ? ColorDefs.colorChatNeutral
                        : ColorDefs.colorChatSelected),
              ),
            ),
          ],
        ),
        FollowUpCommentSection(
            index: index, citations: widget.citations, key: UniqueKey(), numKeyboard: false, mandatory: false)
      ],
    );
  }
}
