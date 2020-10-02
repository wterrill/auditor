import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ReviewDisplay extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  final CalendarResult activeCalendarResult;
  ReviewDisplay({Key key, this.index, this.activeSection, this.questionAutoGroup, this.activeCalendarResult})
      : super(key: key);

  @override
  _ReviewDisplayState createState() => _ReviewDisplayState();
}

class _ReviewDisplayState extends State<ReviewDisplay> {
  @override
  Widget build(BuildContext context) {
    // widget.activeCalendarResult
    int index = widget.index;
    CalendarResult activeCalendarResult = widget.activeCalendarResult;

    Widget getWidgetFromText(String text) {
      Widget widget = Text("");
      switch (text) {
        case ("Date of Visit:"):
          widget = Text(activeCalendarResult.startDateTime.toString());
          break;
        case ("Start Time:"):
          widget = Text(activeCalendarResult.startTime);
          break;
        case ("Date of Visit:"):
          widget = Text(activeCalendarResult?.startDateTime.toString());
          break;
        case ("Type of Visit:"):
          widget = Text(activeCalendarResult?.programType);
          break;
        case ("Agency Name:"):
          widget = Text(activeCalendarResult?.agencyName);
          break;
        case ("Agency/Program Number:"):
          widget = Text(activeCalendarResult?.programNum);
          break;
        case ("Site Address:"):
          String string = activeCalendarResult.siteInfo?.address1 ?? " ";
          string = string + (activeCalendarResult.siteInfo?.address2 ?? " ");
          string = string + (activeCalendarResult.siteInfo?.city ?? " ");
          string = string + (activeCalendarResult.siteInfo?.state ?? " ");
          string = string + (activeCalendarResult.siteInfo?.zip ?? "");

          widget = Text(string ?? "");
          break;
        case ("GCFD Monitor:"):
          widget = Text(activeCalendarResult.auditor);
          break;
        case ("Program Contact:"):
          widget = Text(activeCalendarResult.siteInfo?.contact ?? "None Defined");
          break;
        case ("Program Operating Hours:"):
          widget = Text(activeCalendarResult.siteInfo?.operateHours ?? "None Defined");
          break;
        case ("Service Area:"):
          widget = Text(activeCalendarResult.siteInfo?.serviceArea ?? "None Defined");
          break;
      }
      return widget;
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AutoSizeText(widget.activeSection.questions[index].text,
                  maxLines: 3, group: widget.questionAutoGroup, style: ColorDefs.textBodyBlack20),
            ),
            Expanded(
              child: getWidgetFromText(widget.activeSection.questions[index].text),
            )
          ],
        ),
      ],
    );
  }
}
