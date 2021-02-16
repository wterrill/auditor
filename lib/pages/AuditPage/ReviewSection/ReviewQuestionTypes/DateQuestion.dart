import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'commonQuestionMethods.dart';

class ReviewDateQuestion extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  final Audit activeAudit;
  ReviewDateQuestion({Key key, this.index, this.activeSection, this.questionAutoGroup, @required this.activeAudit})
      : super(key: key);

  @override
  _ReviewDateQuestionState createState() => _ReviewDateQuestionState();
}

class _ReviewDateQuestionState extends State<ReviewDateQuestion> {
  DateTime selectedDate;
  Widget build(BuildContext context) {
    int index = widget.index;
    // Section activeSection = widget.activeSection;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AutoSizeText(widget.activeSection.questions[index].text,
                  maxLines: 3, group: widget.questionAutoGroup, style: ColorDefs.textBodyBlack20),
            ),
            (widget.activeSection.questions[index].userResponse != null)
                ? Text(
                    DateFormat.yMMMMd('en_US')
                        .format(DateTime.parse(widget.activeSection.questions[index].userResponse as String))
                        .toString(),
                  )
                : Text(""),
            TextButton(
                onPressed: () async {
                  selectedDate = await showDatePicker(
                    context: context,
                    initialDate: (selectedDate != null) ? selectedDate : DateTime.now(),
                    firstDate: DateTime(2018),
                    lastDate: DateTime(2030),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: child,
                      );
                    },
                  );
                  widget.activeSection.questions[index].userResponse = selectedDate.toString();
                  Provider.of<AuditData>(context, listen: false)
                      .updateSectionStatus(checkSectionDone(widget.activeSection));

                  if (widget.activeAudit.calendarResult.programType == "Pantry" ||
                      widget.activeAudit.calendarResult.programType == "Congregate") {
                    Provider.of<AuditData>(context, listen: false)
                        .tallySingleQuestion(index: index, section: widget.activeSection, audit: widget.activeAudit);
                  }
                  Audit thisAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
                  Provider.of<AuditData>(context, listen: false).saveAuditLocally(incomingAudit: thisAudit);
                  setState(() {});
                },
                child: Icon(Icons.calendar_today,
                    color: (widget.activeSection.questions[index].userResponse == null) ? Colors.red : Colors.green)),
            GestureDetector(
              onTap: () {
                widget.activeSection.questions[index].textBoxRollOut =
                    !widget.activeSection.questions[index].textBoxRollOut;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.chat_bubble,
                    color: widget.activeSection.questions[index].optionalComment == null
                        ? ColorDefs.colorChatNeutral
                        : ColorDefs.colorChatSelected),
              ),
            ),
          ],
        ),
        // ReviewCommentSection(
        //   index: index,
        //   activeSection: activeSection,
        //   key: UniqueKey(),
        //   numKeyboard: false,
        //   mandatory: false,
        // )
      ],
    );
  }
}
