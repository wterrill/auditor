// import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/colorDefs.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'FollowUpCommentSection.dart';
import 'commonQuestionMethods.dart';

class FollowUpIssuesNoIssuesQuestion extends StatefulWidget {
  final int index;
  @required
  // final Question citation;
  final AutoSizeGroup questionAutoGroup;
  final List<Question> citations;
  FollowUpIssuesNoIssuesQuestion({
    Key key,
    this.index,
    this.citations,
    this.questionAutoGroup,
  }) : super(key: key);

  @override
  _FollowUpIssuesNoIssuesQuestionState createState() =>
      _FollowUpIssuesNoIssuesQuestionState();
}

class _FollowUpIssuesNoIssuesQuestionState
    extends State<FollowUpIssuesNoIssuesQuestion> {
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
                  maxLines: 3,
                  group: widget.questionAutoGroup,
                  style: ColorDefs.textBodyBlack20),
            ),

////////
////////
            GestureDetector(
              onTap: () {
                String result = setQuestionValue(
                    widget.citations[index].userResponse as String,
                    "No Issues");
                widget.citations[index].userResponse = result;
                // Provider.of<AuditData>(context, listen: false)
                //     .updateSectionStatus(
                //         checkSectionDone(widget.activeSection));
                // Audit thisAudit =
                //     Provider.of<AuditData>(context, listen: false).activeAudit;
                // Provider.of<AuditData>(context, listen: false)
                //     .saveAuditLocally(thisAudit);
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color:
                      buttonColorPicker(widget.citations[index], "No Issues"),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 100,
                child: Center(
                    child: Text("No Issues", style: ColorDefs.textBodyBlack20)),
              ),
            ),

////////
////////
            GestureDetector(
              onTap: () {
                String result = setQuestionValue(
                    widget.citations[index].userResponse as String, "Issues");
                widget.citations[index].userResponse = result;
                // Provider.of<AuditData>(context, listen: false)
                //     .updateSectionStatus(
                //         checkSectionDone(widget.activeSection));
                // Audit thisAudit =
                //     Provider.of<AuditData>(context, listen: false).activeAudit;
                // Provider.of<AuditData>(context, listen: false)
                //     .saveAuditLocally(thisAudit);
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: buttonColorPicker(widget.citations[index], "Issues"),
                  borderRadius: BorderRadius.circular(20.0),
                  // border:
                  //     Border.all(width: 2.0, color: Colors.grey)
                ),
                width: 80,
                child: Center(
                    child: Text("Issues", style: ColorDefs.textBodyBlack20)),
              ),
            ),
////////
////////
            GestureDetector(
              onTap: () {
                widget.citations[index].textBoxRollOut =
                    !widget.citations[index].textBoxRollOut;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.chat_bubble,
                    color: widget.citations[index].optionalComment == null
                        ? ColorDefs.colorChatNeutral
                        : ColorDefs.colorChatSelected),
              ),
            ),
          ],
        ),
        FollowUpCommentSection(
            index: index,
            citations: widget.citations,
            key: UniqueKey(),
            numKeyboard: false,
            mandatory: false)
      ],
    );
  }
}
