import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/pages/AuditPage/AuditPage.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';

class AuditInfoDialog extends StatelessWidget {
  final CalendarResult calendarResult;
  const AuditInfoDialog({Key key, this.calendarResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool auditAlreadyStarted = Provider.of<AuditData>(context, listen: false).auditExists(calendarResult);

    Widget newWidget = Container(
        decoration:
            BoxDecoration(color: ColorDefs.colorTopHeader, borderRadius: BorderRadius.all(Radius.circular(25.0))),
        height: 700,
        width: 600,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                    decoration: BoxDecoration(
                        color: calendarResult.programTypeColor,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(calendarResult.agencyName,
                              // textAlign: TextAlign.left,
                              style: ColorDefs.textBodyWhite30),
                          // Spacer(),
                          Container(height: 0),
                          if (calendarResult.siteInfo?.address1 != null)
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText(calendarResult.siteInfo.address1, style: ColorDefs.textBodyWhite20),
                            ),
                          if (calendarResult.siteInfo?.address2 != null && calendarResult.siteInfo?.address2 != "")
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText(calendarResult.siteInfo.address2, style: ColorDefs.textBodyWhite20),
                            ),
                          if (calendarResult.siteInfo?.city != null)
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText(
                                  '${calendarResult.siteInfo.city}, ${calendarResult.siteInfo.state ?? ""},  ${calendarResult.siteInfo.zip ?? ""}',
                                  style: ColorDefs.textBodyWhite20),
                            ),
                          Spacer(),
                          if (calendarResult.siteInfo?.contact != null)
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText('Contact Name: ${calendarResult.siteInfo.contact}',
                                  style: ColorDefs.textBodyWhiteBold20),
                            ),
                          if (calendarResult.siteInfo?.contactEmail != null)
                            Container(
                              // color: Colors.grey,
                              child: AutoSizeText('${calendarResult.siteInfo.contactEmail}',
                                  style: ColorDefs.textBodyWhite20),
                            ),
                          Spacer(),

                          FlatButton(
                            color: ColorDefs.colorTopHeader,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: ColorDefs.colorLogoLightGreen, width: 3.0),
                            ),
                            onPressed: () {
                              Dialogs.showSites(
                                  context: context, programNumber: calendarResult.programNum, singleSite: true);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                              child: Text("Site Information", style: ColorDefs.textBodyBlack20),
                            ),
                          ),
                        ],
                      ),
                    ))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    color: ColorDefs.colorAlternatingDark,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 10),
                      AutoSizeText("Audit Notes",
                          // textAlign: TextAlign.left,
                          style: ColorDefs.textBodyWhite30),
                      Spacer(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Start Time:", style: ColorDefs.textBodyWhite25),
                              Text("Program Number:", style: ColorDefs.textBodyWhite25),
                              Text("Program Type:", style: ColorDefs.textBodyWhite25),
                              Text("Audit Type:", style: ColorDefs.textBodyWhite25),
                              Text("Auditor:", style: ColorDefs.textBodyWhite25),
                              Text("Status:", style: ColorDefs.textBodyWhite25)
                            ],
                          ),
                          Container(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${DateFormat.yMd().add_jm().format(calendarResult.startDateTime)}',
                                  style: ColorDefs.textBodyWhite25),
                              Text('${calendarResult.programNum}', style: ColorDefs.textBodyWhite25),
                              Text('${calendarResult.programType}', style: ColorDefs.textBodyWhite25),
                              Text('${calendarResult.auditType}', style: ColorDefs.textBodyWhite25),
                              Text('${calendarResult.auditor}', style: ColorDefs.textBodyWhite25),
                              Text('${calendarResult.status}', style: ColorDefs.textBodyWhite25),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                            color: ColorDefs.colorTopHeader,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: calendarResult.programTypeColor, width: 3.0)),

                            // disabledTextColor: Colors.blue,
                            onPressed: () {
                              Provider.of<AuditData>(context, listen: false).toggleStartAudit();
                              Navigator.of(context).pop();
                              Navigator.push<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (context) => AuditPage(
                                      calendarResult: calendarResult, auditAlreadyStarted: auditAlreadyStarted),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                              child: AutoSizeText(auditAlreadyStarted ? 'View Audit' : 'Begin Audit',
                                  style: ColorDefs.textBodyBlack20),
                            ),
                          ),
                          // FlatButton(
                          //   color: ColorDefs.colorTopHeader,
                          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0), side: BorderSide(color: calendarResult.programTypeColor, width: 3.0)),
                          //   onPressed: () async {

                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                          //     child: Text("Delete Audit", style: ColorDefs.textBodyBlack20),
                          //   ),
                          // ),
                          if (!(calendarResult.status == "Completed" || calendarResult.status == "Site Visit Req."))
                            FlatButton(
                              color: ColorDefs.colorTopHeader,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: calendarResult.programTypeColor, width: 3.0)),
                              onPressed: () {
                                bool followup = false;
                                if (calendarResult.auditType == "Follow Up") {
                                  followup = true;
                                }
                                Dialogs.showRescheduleAudit(context,
                                    calendarResult: calendarResult,
                                    followup: followup,
                                    auditAlreadyStarted: auditAlreadyStarted);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                                child: AutoSizeText('Revise Audit', style: ColorDefs.textBodyBlack20),
                              ),
                            ),
                          if (calendarResult.status == "Site Visit Req.")
                            FlatButton(
                              color: ColorDefs.colorTopHeader,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: calendarResult.programTypeColor, width: 3.0)),
                              onPressed: () {
                                Dialogs.showRescheduleAudit(context,
                                    calendarResult: calendarResult, followup: true, auditAlreadyStarted: false);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                                child: AutoSizeText('Schedule Followup', style: ColorDefs.textBodyBlack20),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));

    return newWidget;
  }
}
