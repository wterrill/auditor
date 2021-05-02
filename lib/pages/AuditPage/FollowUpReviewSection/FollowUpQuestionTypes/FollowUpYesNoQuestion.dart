// import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

import 'FollowUpCommentSection.dart';
import 'commonQuestionMethods.dart';

class FollowUpYesNoQuestion extends StatefulWidget {
  final int index;
  final List<Question> citations;
  // final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  FollowUpYesNoQuestion({
    Key key,
    this.index,
    this.citations,
    // this.activeSection,
    this.questionAutoGroup,
  }) : super(key: key);

  @override
  _FollowUpYesNoQuestionState createState() => _FollowUpYesNoQuestionState();
}

class _FollowUpYesNoQuestionState extends State<FollowUpYesNoQuestion> {
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
                String result = setQuestionValue(widget.citations[index].userResponse as String, "Yes");
                widget.citations[index].userResponse = result;

                // Audit thisAudit =
                //     Provider.of<AuditData>(context, listen: false).activeAudit;
                Provider.of<AuditData>(context, listen: false).saveAuditLocally();
                setState(() {});
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
                String result = setQuestionValue(widget.citations[index].userResponse as String, "No");
                widget.citations[index].userResponse = result;
                // Audit thisAudit =
                //     Provider.of<AuditData>(context, listen: false).activeAudit;
                Provider.of<AuditData>(context, listen: false).saveAuditLocally();
                setState(() {});
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
