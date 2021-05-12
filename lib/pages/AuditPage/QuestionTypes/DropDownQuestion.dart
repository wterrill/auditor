import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CommentSection.dart';
import 'commonQuestionMethods.dart';

class DropDownQuestion extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  final Audit activeAudit;
  DropDownQuestion({Key key, this.index, this.activeSection, this.questionAutoGroup, @required this.activeAudit})
      : super(key: key);
  @override
  _DropDownQuestionState createState() => _DropDownQuestionState();
}

class _DropDownQuestionState extends State<DropDownQuestion> {
  bool myBubbleOn = false;
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    Section activeSection = widget.activeSection;
    return Container(
      color: widget.activeSection.questions[index].highlight ? ColorDefs.colorHighlight : Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(widget.activeSection.questions[index].text,
                    maxLines: 3, style: ColorDefs.textBodyBlack20), //group: widget.questionAutoGroup, ),
              ),
              if (!widget.activeSection.questions[index].hideNa)
                GestureDetector(
                  onTap: () {
                    if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status !=
                        "Scheduled") {
                      Dialogs.showMessage(
                          context: context,
                          message: "This audit has already been submitted, and cannot be edited",
                          dismissable: true,
                          textStyle: ColorDefs.textWhiteTerminal,
                          bckcolor: ColorDefs.colorDarkBackground);
                    } else {
                      String result =
                          setQuestionValue(widget.activeSection.questions[index].userResponse as String, 'N/A');
                      widget.activeSection.questions[index].userResponse = result;
                      Provider.of<AuditData>(context, listen: false)
                          .updateSectionStatus(checkSectionDone(widget.activeSection));
                      if (widget.activeAudit.calendarResult.programType == "Pantry" ||
                          widget.activeAudit.calendarResult.programType == "Congregate") {
                        Provider.of<AuditData>(context, listen: false)
                            .tallySingleQuestion(index: index, section: activeSection, audit: widget.activeAudit);
                      }
                      // Audit thisAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
                      // Provider.of<AuditData>(context, listen: false).saveAuditLocally(incomingAudit: thisAudit);
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: buttonColorPicker(widget.activeSection.questions[index], 'N/A'),
                        borderRadius: BorderRadius.circular(20.0),
                        // border:
                        //     Border.all(width: 2.0, color: Colors.grey)
                      ),
                      width: ColorDefs.buttonwidth,
                      height: ColorDefs.buttonheight,
                      child: Center(child: Text("N/A", style: ColorDefs.textBodyBlack20)),
                    ),
                  ),
                ),
              DropdownButton<String>(
                value: widget.activeSection.questions[index].userResponse as String ?? "Select",
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: ColorDefs.textBodyBlack20,
                underline: Container(
                  height: 2,
                  color: (widget.activeSection.questions[index].userResponse == "Select") ? Colors.red : Colors.green,
                ),
                onChanged: (String newValue) {
                  if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status != "Scheduled") {
                    Dialogs.showMessage(
                        context: context,
                        message: "This audit has already been submitted, and cannot be edited",
                        dismissable: true,
                        textStyle: ColorDefs.textWhiteTerminal,
                        bckcolor: ColorDefs.colorDarkBackground);
                  } else {
                    setState(() {
                      widget.activeSection.questions[index].userResponse = newValue;
                      if (newValue == "Other") {
                        widget.activeSection.questions[index].textBoxRollOut = true;
                      }
                      Provider.of<AuditData>(context, listen: false)
                          .updateSectionStatus(checkSectionDone(widget.activeSection));
                      if (widget.activeAudit.calendarResult.programType == "Pantry" ||
                          widget.activeAudit.calendarResult.programType == "Congregate") {
                        Provider.of<AuditData>(context, listen: false)
                            .tallySingleQuestion(index: index, section: activeSection, audit: widget.activeAudit);
                      }
                      // Audit thisAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
                      // Provider.of<AuditData>(context, listen: false).saveAuditLocally(incomingAudit: thisAudit);
                    });
                  }
                },
                items: widget.activeSection.questions[index].dropDownMenu.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              GestureDetector(
                onTap: () {
                  widget.activeSection.questions[index].textBoxRollOut =
                      !widget.activeSection.questions[index].textBoxRollOut;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(Icons.chat_bubble,
                      size: ColorDefs.chatBubbleSize,
                      color: myBubbleOn ? ColorDefs.colorChatSelected : ColorDefs.colorChatNeutral),
                ),
              ),
            ],
          ),
          CommentSection(
            index: index,
            activeSection: activeSection,
            numKeyboard: false,
            mandatory: false,
            bubbleCallback: (String val) {
              setState(() {
                if (val.length > 0) {
                  myBubbleOn = true;
                } else {
                  myBubbleOn = false;
                }
              });
            },
          )
        ],
      ),
    );
  }
}
