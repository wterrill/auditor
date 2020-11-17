import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class DatabaseDetails extends StatelessWidget {
  const DatabaseDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box auditBox = Provider.of<AuditData>(context).auditBox;
    Box auditOutBox = Provider.of<AuditData>(context).auditOutBox;

    Box calendarBox = Provider.of<ListCalendarData>(context).calendarBox;
    Box calendarOrderedOutBox = Provider.of<ListCalendarData>(context).calendarOrderedOutBox;

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: Scaffold(
            body: Column(
          children: [
            Text("auditBox"),
            Expanded(
              child: ListView.builder(
                  itemCount: auditBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Audit gotAudit = auditBox.get(auditBox.keys.toList()[index].toString()) as Audit;
                          Dialogs.showMessage(
                              context: context,
                              message: gotAudit.toString(),
                              dismissable: true,
                              textStyle: ColorDefs.textWhiteTerminal,
                              bckcolor: ColorDefs.colorDarkBackground);
                        },
                        child: Text(auditBox.keys.toList()[index].toString()));
                  }),
            ),
            Container(height: 50),
            Text("auditOutBox"),
            Expanded(
              child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: auditOutBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Audit gotIt = auditOutBox.get(auditOutBox.keys.toList()[index].toString()) as Audit;
                          Dialogs.showMessage(
                              context: context,
                              message: gotIt.toString(),
                              dismissable: true,
                              textStyle: ColorDefs.textWhiteTerminal,
                              bckcolor: ColorDefs.colorDarkBackground);
                        },
                        child: Text(auditOutBox.keys.toList()[index].toString()));
                  }),
            ),
            Container(height: 50),
            Text("calendarBox"),
            Expanded(
              child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: calendarBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          CalendarResult gotIt =
                              calendarBox.get(calendarBox.keys.toList()[index].toString()) as CalendarResult;
                          Dialogs.showMessage(
                              context: context,
                              message: gotIt.toString(),
                              dismissable: true,
                              textStyle: ColorDefs.textWhiteTerminal,
                              bckcolor: ColorDefs.colorDarkBackground);
                        },
                        child: Text(calendarBox.keys.toList()[index].toString()));
                  }),
            ),
            Text("calendarOrderedOutBox"),
            Expanded(
              child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: calendarOrderedOutBox.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Map<String, dynamic> gotIt = calendarOrderedOutBox
                              .get(calendarOrderedOutBox.keys.toList()[index].toString()) as Map<String, dynamic>;
                          Dialogs.showMessage(
                              context: context,
                              message: ((gotIt['type'] as String) + " " + (gotIt['calendarResult'].toString())),
                              dismissable: true,
                              textStyle: ColorDefs.textWhiteTerminal,
                              bckcolor: ColorDefs.colorDarkBackground);
                        },
                        child: Text(calendarOrderedOutBox.keys.toList()[index].toString()));
                  }),
            ),
          ],
        )),
      ),
    );
  }
}
