import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/pages/AuditPage/DeveloperPage.dart';
import 'package:auditor/pages/AuditPage/PhotoPage.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FollowUpReviewSection/FollowUpReview.dart';
import 'ReviewSection/ReviewPage.dart';
import 'SectionButtons.dart';
import 'AuditQuestions.dart';
import 'VerificationGoodPage.dart';
import 'VerificationBadPage.dart';
import 'dart:typed_data';

class AuditPage extends StatefulWidget {
  final bool auditAlreadyStarted;
  final CalendarResult calendarResult;
  // final String programType;
  AuditPage({Key key, @required this.calendarResult, @required this.auditAlreadyStarted}) : super(key: key);
  @override
  _AuditPageState createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage> {
  Audit activeAudit;
  Section activeSection;
  void paintButtons() {
    for (Section section in activeAudit.sections) {
      print(section.status);

      // section.status = Status.available;
      // activeSection.status = Status.completed;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.auditAlreadyStarted) {
      Provider.of<AuditData>(context, listen: false).loadExisting(widget.calendarResult);
    } else {
      Provider.of<AuditData>(context, listen: false).createNewAudit(widget.calendarResult);
      if (widget.calendarResult.citationsToFollowUp != null) {
        Provider.of<AuditData>(context, listen: false).buildQuestionFromCitation(widget.calendarResult);
        // List<Question> beer = Provider.of<AuditData>(context).previousCitations;
        // print(beer);
      }
    }
    activeAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
    if (activeAudit.calendarResult.siteInfo.contactEmail != "") {
      // Provider.of<GeneralData>(context, listen: false).emailValidated = true;
    }
    activeSection = Provider.of<AuditData>(context, listen: false).activeSection;
    Provider.of<AuditData>(context, listen: false).citations = activeAudit.citations;
    Provider.of<AuditData>(context, listen: false).previousCitations = activeAudit.previousCitations;
    paintButtons();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = Provider.of<GeneralData>(context).questionScrollController;
    print("building AuditPage");

    Audit activeAudit = Provider.of<AuditData>(context).activeAudit;
    Section activeSection = Provider.of<AuditData>(context).activeSection;
    double mediaWidth = Provider.of<GeneralData>(context).mediaArea.width;
    double mediaHeight = Provider.of<GeneralData>(context).mediaArea.height;
    CalendarResult activeCalendarResult = Provider.of<AuditData>(context).activeCalendarResult;
    Uint8List certRepresentativeSignature = Provider.of<AuditData>(context).certRepresentativeSignature;
    Uint8List siteRepresentativeSignature = Provider.of<AuditData>(context).siteRepresentativeSignature;
    Uint8List foodDepositoryMonitorSignature = Provider.of<AuditData>(context).foodDepositoryMonitorSignature;
    bool showSubmitButton = ((certRepresentativeSignature != null && activeAudit.citations.length == 0 ||
            certRepresentativeSignature != null &&
                siteRepresentativeSignature != null &&
                foodDepositoryMonitorSignature != null &&
                Provider.of<AuditData>(context, listen: false).goToVerificationGoodPage) &&
        !(activeAudit.calendarResult.status == "Completed" || activeAudit.calendarResult.status == "Site Visit Req."));

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Roboto', // Georgia
        textTheme: TextTheme(),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorDefs.colorTopHeader,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(width: 2.0, color: Colors.grey)),
              height: mediaHeight * 0.95,
              width: mediaWidth * 0.9,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(child: SectionButtons(activeAudit: activeAudit)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: ColorDefs.colorAlternatingDark,
                        thickness: 1,
                      ),
                    ),

                    if (activeSection?.name == "Review")
                      ReviewPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "Follow Up Review")
                      FollowUpReviewPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "Photos")
                      PhotoPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "Verification" && activeAudit.citations.length == 0 ||
                        Provider.of<AuditData>(context).goToVerificationGoodPage &&
                            activeSection?.name == "Verification")
                      VerificationGoodPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "Verification" &&
                        activeAudit.citations.length != 0 &&
                        !Provider.of<AuditData>(context).goToVerificationGoodPage)
                      VerificationBadPage(
                        activeAudit: activeAudit,
                      ),
                    if (activeSection?.name == "*Developer*") DeveloperPage(),
                    if (activeSection?.name != "Review" &&
                        activeSection?.name != "Verification" &&
                        activeSection?.name != "Follow Up Review")
                      if (activeSection?.name != "Photos")
                        Container(
                          child: AuditQuestions(
                            activeSection: activeSection,
                            activecalendarResult: activeCalendarResult,
                            activeAudit: activeAudit,
                          ),
                        ),

                    //),

                    if (activeSection?.name == "Verification")
                      if (showSubmitButton)
                        FlatButton(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                              child: Text("Submit Audit", style: ColorDefs.textBodyBlack30),
                            ),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),
                            disabledColor: ColorDefs.colorButtonNeutral,
                            // color: Colors.blue,
                            // textColor: Colors.black,
                            // child: Text("Submit Audit", style: ColorDefs.textBodyBlack20),
                            onPressed: (() async {
                              // Save Date time
                              activeAudit.calendarResult.endDateTime = DateTime.now();
                              // this is done to prevent "Verification" from showing as selected when opening again.
                              for (var i = activeAudit.sections.length - 1; i > -1; i--) {
                                if (activeAudit.sections[i].name == "Verification") {
                                  activeAudit.sections[i].status = Status.completed;
                                  break;
                                }
                              }
                              // Save citations, and update status
                              activeAudit.citations = Provider.of<AuditData>(context, listen: false).citations;
                              activeAudit.previousCitations = Provider.of<AuditData>(context, listen: false).citations;
                              String status = "Completed";
                              if (activeAudit.siteVisitRequired == true) {
                                status = "Site Visit Req.";
                              }
                              if (status == "Completed") {
                                Provider.of<ListCalendarData>(context, listen: false)
                                    .updateStatusOnScheduleToCompleted(activeAudit.calendarResult);
                              }

                              activeAudit.calendarResult.status = status;
                              Provider.of<AuditData>(context, listen: false)
                                  .saveAuditLocally(incomingAudit: activeAudit);
                              // the calendar item needs to be updated due to the status change.
                              Provider.of<ListCalendarData>(context, listen: false)
                                  .addCalendarItem(activeAudit.calendarResult);
                              Provider.of<AuditData>(context, listen: false).notifyTheListeners();
                              Provider.of<AuditData>(context, listen: false).saveAuditToSend(activeAudit);

                              await Dialogs.showSuccess(context);
                              Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                              Provider.of<AuditData>(context, listen: false).resetAudit();
                            })),
                    Container(height: 10),
                    if (activeAudit?.calendarResult?.status == 0)
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.black,
                        child: Text("Cancel Audit", style: ColorDefs.textBodyBlack20),
                        onPressed: () {
                          Provider.of<AuditData>(context, listen: false).toggleStartAudit();
                          Provider.of<AuditData>(context, listen: false).resetAudit();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    // Container(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
                          color: ColorDefs.colorCalendarHeader),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                            disabledColor: ColorDefs.colorButtonNeutral,
                            color: ColorDefs.colorAnotherDarkGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                              child: Text("Save and Close", style: ColorDefs.textBodyWhite20),
                            ),
                            onPressed: () {
                              Provider.of<AuditData>(context, listen: false).toggleStartAudit();
                              Provider.of<AuditData>(context, listen: false)
                                  .saveAuditLocally(incomingAudit: activeAudit);
                              Provider.of<AuditData>(context, listen: false).resetAudit();

                              Navigator.of(context).pop();
                            },
                          ),
                          // if (activeSection?.name == "Confirm Details" &&
                          //     activeAudit.detailsConfirmed == false &&
                          //     activeAudit.calendarResult.status != "Completed")
                          // FlatButton(
                          //   // padding: EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                          //   child: Padding(
                          //       padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                          //       child: Text(
                          //         "Confirm",
                          //         style: TextStyle(fontSize: 20),
                          //       )),
                          //   disabledColor: ColorDefs.colorTopHeader,
                          //   disabledTextColor: ColorDefs.colorChatNeutral,
                          //   color: ColorDefs.colorTopHeader,
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(50.0),
                          //       side: BorderSide(
                          //           color: Provider.of<GeneralData>(context).confirmButtonEnabled
                          //               ? ColorDefs.colorAnotherDarkGreen
                          //               : ColorDefs.colorButtonNeutral,
                          //           width: 3.0)),

                          //   // disabledTextColor: Colors.blue,
                          //   onPressed: (!Provider.of<GeneralData>(context).confirmButtonEnabled)
                          //       ? null
                          //       : () {
                          //           activeAudit.detailsConfirmed = true;
                          //           for (Section section in activeAudit.sections) {
                          //             section.status = Status.available;
                          //             section.lastStatus = Status.available;
                          //             activeSection.status = Status.completed;
                          //             activeSection.lastStatus = Status.completed;
                          //             if (activeAudit.calendarResult.auditType != "Follow Up") {
                          //               if (section.name == "Review") break;
                          //             }
                          //           }
                          //           setState(() {});
                          //           if (activeAudit.calendarResult.auditType == "Follow Up") {
                          //             Provider.of<AuditData>(context, listen: false).makeCitations();
                          //             Section goToSection;
                          //             for (Section section in activeAudit.sections) {
                          //               if (section.name == "Follow Up Review") {
                          //                 goToSection = section;
                          //               }
                          //             }
                          //             Provider.of<AuditData>(context, listen: false).updateActiveSection(goToSection);
                          //           }
                          //         },
                          // ),
                          if (!(activeSection?.name == "Confirm Details" &&
                              activeAudit.detailsConfirmed == false &&
                              activeAudit.calendarResult.status != "Completed"))
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 180,
                                  child: FlatButton(
                                    disabledColor: ColorDefs.colorButtonNeutral,
                                    color: ColorDefs.colorTopHeader,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),

                                    // color: Colors.blue,
                                    // textColor: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                                      child: Text("Previous", style: ColorDefs.textBodyBlack20),
                                    ),
                                    onPressed: () {
                                      try {
                                        _scrollController.jumpTo(-10);
                                      } catch (err) {
                                        // this is not an error
                                      }
                                      Section nextSection =
                                          Provider.of<AuditData>(context, listen: false).cycleSections(-1);
                                      if (Status.values.indexOf(nextSection.status) >=
                                          Status.values.indexOf(Status.available)) {
                                        Provider.of<AuditData>(context, listen: false).updateActiveSection(nextSection);
                                        Provider.of<AuditData>(context, listen: false).saveActiveAudit();
                                        Provider.of<AuditData>(context, listen: false).makeCitations();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 180,
                                  child: FlatButton(
                                    disabledColor: ColorDefs.colorButtonNeutral,
                                    color: ColorDefs.colorTopHeader,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                                      child: Text("Next", style: ColorDefs.textBodyBlack20),
                                    ),
                                    onPressed: () {
                                      try {
                                        _scrollController.jumpTo(-10);
                                      } catch (err) {
                                        // this is not an error
                                      }
                                      Section nextSection =
                                          Provider.of<AuditData>(context, listen: false).cycleSections(1);
                                      if (Status.values.indexOf(nextSection.status) >=
                                          Status.values.indexOf(Status.available)) {
                                        Provider.of<AuditData>(context, listen: false)
                                            .updateActiveSectionNext(nextSection);
                                        Provider.of<AuditData>(context, listen: false).saveActiveAudit();
                                        Provider.of<AuditData>(context, listen: false).makeCitations();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
