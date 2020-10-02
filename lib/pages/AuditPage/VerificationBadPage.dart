import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'dart:typed_data';

import 'ReviewSection/FollowupActionItems2.dart';
import 'ReviewSection/FollowupCitationsSections.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerificationBadPage extends StatefulWidget {
  const VerificationBadPage({Key key, this.activeAudit}) : super(key: key);
  final Audit activeAudit;

  @override
  _VerificationBadPageState createState() => _VerificationBadPageState();
}

class _VerificationBadPageState extends State<VerificationBadPage> {
  // Uint8List finalImage = null;
  // Uint8List finalImage2 = null;
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();
  final _sign2 = GlobalKey<SignatureState>();
  Uint8List siteRepresentativeSignature = null;
  Uint8List foodDepositoryMonitorSignature = null;
  List<String> actionItems;
  int followupReqVal;
  int scoringReqVal = -1;
  String affectedIssues = "";

  DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    TextStyle getScoreColor(double auditScore) {
      TextStyle scoreStyle = ColorDefs.textRedScore;
      if (auditScore >= 40) {
        scoreStyle = ColorDefs.textOrangeScore;
      }
      if (auditScore > 70) {
        scoreStyle = ColorDefs.textGreenScore;
      }
      return scoreStyle;
    }

    followupReqVal = -1;
    if (widget.activeAudit.siteVisitRequired != null) {
      if (widget.activeAudit.siteVisitRequired == true) {
        followupReqVal = 1;
      } else {
        followupReqVal = 0;
      }
    }

    bool checkActionItems() {
      bool actionItemValid = true;
      affectedIssues = "";
      for (Question question in widget.activeAudit.citations) {
        print(question.actionItem);
        if (question.actionItem == ("Explain issue and action item for plumbing issues: ")) {
          actionItemValid = false;
          affectedIssues = affectedIssues + "\n - " + question.actionItem;
        }
        if (question.actionItem == ("Explain issue and action item for Sewage issues: ")) {
          actionItemValid = false;
          affectedIssues = affectedIssues + "\n - " + question.actionItem;
        }
        if (question.actionItem == ("Explain issue and action item for garbage and refuse disposal issues: ")) {
          actionItemValid = false;
          affectedIssues = affectedIssues + "\n - " + question.actionItem;
        }
        if (question.actionItem == ("Explain action items for the fire extinguisher: ")) {
          actionItemValid = false;
          affectedIssues = affectedIssues + "\n - " + question.actionItem;
        }
        if (question.actionItem == ("Please explain lighting issues and action items: ")) {
          actionItemValid = false;
          affectedIssues = affectedIssues + "\n - " + question.actionItem;
        }
        if (question.actionItem == ("Please explain ventilation issues and action items in comments: ")) {
          actionItemValid = false;
          affectedIssues = affectedIssues + "\n - " + question.actionItem;
        }
        if (question.actionItem ==
            ("Please explain issues with access to all pertinent areas of food program action items: ")) {
          actionItemValid = false;
          affectedIssues = affectedIssues + "\n - " + question.actionItem;
        }
      }
      return actionItemValid;
    }

    bool checkVisitAndHoldItems() {
      bool actionItemValid = true;
      affectedIssues = "";

      if (widget.activeAudit.siteVisitRequired == null || widget.activeAudit.putProgramOnImmediateHold == null) {
        actionItemValid = false;
      }
      return !actionItemValid;
    }

    bool flaggedCitationsExist(List<Question> citations) {
      bool exists = false;
      for (Question citation in citations) {
        if (!citation.unflagged) {
          exists = true;
          return exists;
        }
      }
      return exists;
    }

    List<Question> citations = Provider.of<AuditData>(context).citations;
    selectedDate = widget.activeAudit?.correctiveActionPlanDueDate;
    try {
      foodDepositoryMonitorSignature = widget.activeAudit?.photoSig['foodDepositoryMonitorSignature'];
    } catch (err) {}
    try {
      siteRepresentativeSignature = widget.activeAudit?.photoSig['siteRepresentativeSignature'];
    } catch (err) {}

    print("onbuild: $followupReqVal");
    return Container(
      child: Expanded(
          child: Scrollbar(
        thickness: 4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("CITATIONS", style: ColorDefs.textBodyBlack30),
              if (citations.length != 0)
                Text(
                  "Follow-Up / Citations",
                  style: ColorDefs.textBodyBlack30,
                ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 240),
                child: FollowupCitationsSections(
                    // activeAudit: widget.activeAudit,
                    ),
              ),
              if (flaggedCitationsExist(citations))
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 5.0),
                  child: Text("ACTION ITEMS", style: ColorDefs.textBodyBlack30),
                ),

              // Container(
              //   height: 350,
              //   child: FollowupActionItems(
              //     activeAudit: widget.activeAudit,
              //   ),
              // ),
              // Text("ACTION ITEMS Ver 2", style: ColorDefs.textBodyBlack30),

              if (flaggedCitationsExist(citations))
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 340),
                  child: FollowupActionItems2(
                      // activeAudit: widget.activeAudit,
                      ),
                ),
              Container(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("These Compliance Requirements must be completed by: "),
                  ),
                  if (selectedDate != null)
                    FlatButton(
                      disabledColor: ColorDefs.colorButtonNeutral,
                      color: ColorDefs.colorTopHeader,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        child: Text(
                            (selectedDate != null) ? DateFormat('MM-dd-yyyy').format(selectedDate) : "Select Date"),
                      ),
                      onPressed: () async {
                        selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        widget.activeAudit.correctiveActionPlanDueDate = selectedDate;
                        setState(() {});
                      },
                    ),

                  if (selectedDate == null)
                    GestureDetector(
                      child: FaIcon(FontAwesomeIcons.calendarAlt, color: ColorDefs.colorAnotherDarkGreen, size: 60),
                      onTap: () async {
                        selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        widget.activeAudit.correctiveActionPlanDueDate = selectedDate;
                        setState(() {});
                      },
                    )

                  // InkWell(
                  //   child: FaIcon(FontAwesomeIcons.calendarAlt, size: 35),
                  //   onTap: () async {
                  //     selectedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime.now(),
                  //       lastDate: DateTime(2030),
                  //     );
                  //     widget.activeAudit.correctiveActionPlanDueDate =
                  //         selectedDate;
                  //     setState(() {});
                  //   },
                  // ),
                ],
              ),

              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Require follow-up site visit for this establishment? "),
                  ),
                  DropdownButton<int>(
                      value: followupReqVal,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: ColorDefs.textBodyBlack20,
                      underline: Container(
                        height: 2,
                        color: (followupReqVal == 1) ? Colors.red : Colors.green,
                      ),
                      onChanged: (int newValue) {
                        setState(() {
                          print(newValue);
                          if (newValue != scoringReqVal) {
                            if (newValue == 0 &&
                                widget.activeAudit.currentPoints != null &&
                                widget.activeAudit.visitRequiredPointsAdded == false) {
                              widget.activeAudit.currentPoints += 10;
                              widget.activeAudit.visitRequiredPointsAdded = true;
                              widget.activeAudit.auditScore =
                                  100 * widget.activeAudit.currentPoints / widget.activeAudit.maxPoints;
                            }
                            if (newValue == 1 &&
                                widget.activeAudit.currentPoints != null &&
                                widget.activeAudit.visitRequiredPointsAdded == true) {
                              widget.activeAudit.currentPoints -= 10;
                              widget.activeAudit.visitRequiredPointsAdded = false;
                              widget.activeAudit.auditScore =
                                  100 * widget.activeAudit.currentPoints / widget.activeAudit.maxPoints;
                            }
                          }

                          followupReqVal = newValue;
                          scoringReqVal = newValue;
                          print(followupReqVal);
                          Provider.of<AuditData>(context, listen: false).activeAudit.siteVisitRequired =
                              newValue == 0 ? false : true;
                          Provider.of<AuditData>(context, listen: false).notifyTheListeners();
                        });
                      },
                      items: [
                        DropdownMenuItem<int>(
                          value: -1,
                          child: Text("Select"),
                        ),
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text("No follow up site visit required"),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text("Follow up site visit required"),
                        )
                      ]),
                ],
              ),

              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              // child:
              Container(
                padding: EdgeInsets.all(25),
                // width: 500, //MediaQuery.of(context).size.width,
                child: Wrap(direction: Axis.horizontal, children: [
                  Text(
                    '''
In order to be fully certified and in good standing with the Greater Chicago Food Depository. Failure to comply with the requirements listed below will result in a breach of program agreement, being placed on HOLD status, corrective action up to, and including, suspension and/or termination of membership. We appreciate your prompt attention to this matter to ensure your community does not suffer an interruption of services.  If the agency does not adhere to the corrective action plan and/or receives additional violations during the probation period of three (3) months, the program may be permanently removed as determined by the Greater Chicago Food Depository.''',
                  ),
                ]),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Program is being placed on immediate hold:'),
                  ),
                  if (widget.activeAudit.putProgramOnImmediateHold == null ||
                      widget.activeAudit.putProgramOnImmediateHold == true)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.activeAudit.putProgramOnImmediateHold == null) {
                              widget.activeAudit.putProgramOnImmediateHold = true;
                              widget.activeAudit.programHoldPointsAdded = false;
                            } else {
                              widget.activeAudit.putProgramOnImmediateHold = null;
                              widget.activeAudit.programHoldPointsAdded = false;
                            }
                          });
                          Provider.of<AuditData>(context, listen: false).notifyTheListeners();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorDefs.colorButtonNeutral,
                              borderRadius: BorderRadius.all(Radius.circular(25.0))),
                          height: 70,
                          width: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.red, size: 40),
                              Text("Yes", style: ColorDefs.textBodyBlack20)
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (widget.activeAudit.putProgramOnImmediateHold == null ||
                      widget.activeAudit.putProgramOnImmediateHold == false)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.activeAudit.putProgramOnImmediateHold == null) {
                              widget.activeAudit.putProgramOnImmediateHold = false;

                              if (widget.activeAudit.auditScore != null &&
                                  widget.activeAudit.programHoldPointsAdded == false) {
                                Provider.of<AuditData>(context, listen: false).activeAudit.putProgramOnImmediateHold =
                                    false;
                                widget.activeAudit.currentPoints += 20;
                                widget.activeAudit.programHoldPointsAdded = true;
                                widget.activeAudit.auditScore =
                                    100 * widget.activeAudit.currentPoints / widget.activeAudit.maxPoints;
                                Provider.of<AuditData>(context, listen: false).notifyTheListeners();
                              }
                            } else {
                              widget.activeAudit.putProgramOnImmediateHold = null;
                              if (widget.activeAudit.auditScore != null &&
                                  widget.activeAudit.programHoldPointsAdded == true) {
                                Provider.of<AuditData>(context, listen: false).activeAudit.putProgramOnImmediateHold =
                                    null;
                                widget.activeAudit.currentPoints -= 20;
                                widget.activeAudit.programHoldPointsAdded = false;
                                widget.activeAudit.auditScore =
                                    100 * widget.activeAudit.currentPoints / widget.activeAudit.maxPoints;
                                Provider.of<AuditData>(context, listen: false).notifyTheListeners();
                              }
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorDefs.colorButtonNeutral,
                              borderRadius: BorderRadius.all(Radius.circular(25.0))),
                          height: 70,
                          width: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green, size: 40),
                              Text("No", style: ColorDefs.textBodyBlack20)
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                    '''Submit a dated and SIGNED Letter of Compliance regarding above issues on your agency letterhead.  Please do not submit pictures of documents as the quality is not legible when printed  
 '''),
              ),

              if (foodDepositoryMonitorSignature == null)
                Text("Food Depository Monitor: " +
                    Provider.of<ListCalendarData>(context, listen: false)
                        .auditorList
                        .getFirstAndLastFromUser(widget.activeAudit.calendarResult.auditor)),

              foodDepositoryMonitorSignature == null
                  ? Container()
                  : Container(
                      child: LimitedBox(
                          maxHeight: 100.0,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(width: 2.0, color: Colors.lightBlue.shade900),
                              )),
                              child: Image.memory(foodDepositoryMonitorSignature.buffer.asUint8List()))),
                    ),

              if (foodDepositoryMonitorSignature == null)
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorDefs.colorUserAccent, width: 1.0),
                  ),
                  child: Signature(
                    color: color,
                    key: _sign,
                    onSign: () {
                      final sign = _sign.currentState;
                      // debugPrint('${sign.points.length} points in the signature');
                    },
                    backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                    strokeWidth: strokeWidth,
                  ),
                ),
              if (foodDepositoryMonitorSignature == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        child: Text("Save"),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                          side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),
                      onPressed: () async {
                        if (checkActionItems()) {
                          SignatureState sign = _sign.currentState;
                          int lineColor = img.getColor(color.red, color.green, color.blue);
                          int backColor = img.getColor(255, 255, 255);
                          int imageWidth;
                          int imageHeight;
                          BuildContext currentContext = _sign.currentContext;
                          if (currentContext != null) {
                            var box = currentContext.findRenderObject() as RenderBox;
                            imageWidth = box.size.width.toInt();
                            imageHeight = box.size.height.toInt();
                          }

                          // create the image with the given size
                          img.Image signatureImage = img.Image(imageWidth, imageHeight);

                          // set the image background color
                          // remove this for a transparent background
                          img.fill(signatureImage, backColor);

                          for (int i = 0; i < sign.points.length - 1; i++) {
                            if (sign.points[i] != null && sign.points[i + 1] != null) {
                              img.drawLine(signatureImage, sign.points[i].dx.toInt(), sign.points[i].dy.toInt(),
                                  sign.points[i + 1].dx.toInt(), sign.points[i + 1].dy.toInt(), lineColor,
                                  thickness: 3);
                            } else if (sign.points[i] != null && sign.points[i + 1] == null) {
                              // draw the point to the image
                              img.drawPixel(
                                  signatureImage, sign.points[i].dx.toInt(), sign.points[i].dy.toInt(), lineColor);
                            }
                          }

                          sign.clear();
                          setState(() {
                            foodDepositoryMonitorSignature = img.encodePng(signatureImage) as Uint8List;
                            Provider.of<AuditData>(context, listen: false).foodDepositoryMonitorSignature =
                                foodDepositoryMonitorSignature;
                            widget.activeAudit.photoSig['foodDepositoryMonitorSignature'] =
                                foodDepositoryMonitorSignature;
                            Provider.of<AuditData>(context, listen: false).notifyTheListeners();
                          });
                          debugPrint("onPressed ");
                        } else {
                          Dialogs.showMessage(
                              context: context,
                              message: "These action items must be updated prior to signing: \n $affectedIssues",
                              dismissable: true);
                        }
                        if (checkVisitAndHoldItems()) {
                          Dialogs.showMessage(
                              context: context,
                              message:
                                  "Please select if a follow up site visit is needed, \nor if the program should be put on hold.",
                              dismissable: true);
                        }
                      },
                    ),
                    FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        child: Text("Clear"),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),
                      onPressed: () {
                        final sign = _sign.currentState;
                        sign.clear();
                        setState(() {
                          foodDepositoryMonitorSignature = null;
                        });
                        debugPrint("cleared");
                      },
                    ),
                  ],
                ),
              if (foodDepositoryMonitorSignature == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            color = color == Colors.green ? Colors.red : Colors.green;
                          });
                          debugPrint("change color");
                        },
                        child: Text("Change color")),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            int min = 1;
                            int max = 10;
                            int selection = min + (Random().nextInt(max - min));
                            strokeWidth = selection.roundToDouble();
                            debugPrint("change stroke width to $selection");
                          });
                        },
                        child: Text("Change stroke width")),
                  ],
                ),
//////////////  END FIRST SIGNATURE /////////////////////////////
              if (foodDepositoryMonitorSignature != null)
                Text("Food Depository Monitor: " +
                    Provider.of<ListCalendarData>(context, listen: false)
                        .auditorList
                        .getFirstAndLastFromUser(widget.activeAudit.calendarResult.auditor)),
              if (siteRepresentativeSignature == null &&
                  Provider.of<AuditData>(context, listen: false).personInterviewed != null)
                Text("Agency Representative: " + (Provider.of<AuditData>(context, listen: false).personInterviewed) ??
                    ""),
              if (Provider.of<AuditData>(context, listen: false).personInterviewed == null)
                Text("Agency Representative"),
//////////////  SECOND SIGNATURE /////////////////////////////
              siteRepresentativeSignature == null
                  ? Container()
                  : LimitedBox(
                      maxHeight: 100.0,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.lightBlue.shade900),
                          )),
                          child: Image.memory(siteRepresentativeSignature.buffer.asUint8List()))),
              if (siteRepresentativeSignature != null)
                Text("Agency Representative: " +
                    (Provider.of<AuditData>(context, listen: false).personInterviewed ?? "")),
              if (siteRepresentativeSignature == null)
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorDefs.colorUserAccent, width: 1.0),
                  ),
                  child: Signature(
                    color: color,
                    key: _sign2,
                    onSign: () {
                      final sign = _sign2.currentState;
                      // debugPrint('${sign.points.length} points in the signature');
                    },
                    backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                    strokeWidth: strokeWidth,
                  ),
                ),
              if (siteRepresentativeSignature == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      // color: Colors.green,

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        child: Text("Save"),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                          side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),

                      onPressed: () async {
                        if (checkActionItems()) {
                          SignatureState sign = _sign2.currentState;
                          int lineColor = img.getColor(color.red, color.green, color.blue);
                          int backColor = img.getColor(255, 255, 255);
                          int imageWidth;
                          int imageHeight;
                          BuildContext currentContext = _sign2.currentContext;
                          if (currentContext != null) {
                            var box = currentContext.findRenderObject() as RenderBox;
                            imageWidth = box.size.width.toInt();
                            imageHeight = box.size.height.toInt();
                          }

                          // create the image with the given size
                          img.Image signatureImage = img.Image(imageWidth, imageHeight);

                          // set the image background color
                          // remove this for a transparent background
                          img.fill(signatureImage, backColor);

                          for (int i = 0; i < sign.points.length - 1; i++) {
                            if (sign.points[i] != null && sign.points[i + 1] != null) {
                              img.drawLine(signatureImage, sign.points[i].dx.toInt(), sign.points[i].dy.toInt(),
                                  sign.points[i + 1].dx.toInt(), sign.points[i + 1].dy.toInt(), lineColor,
                                  thickness: 3);
                            } else if (sign.points[i] != null && sign.points[i + 1] == null) {
                              // draw the point to the image
                              img.drawPixel(
                                  signatureImage, sign.points[i].dx.toInt(), sign.points[i].dy.toInt(), lineColor);
                            }
                          }
                          sign.clear();
                          setState(() {
                            siteRepresentativeSignature = img.encodePng(signatureImage) as Uint8List;
                            Provider.of<AuditData>(context, listen: false).siteRepresentativeSignature =
                                siteRepresentativeSignature;
                            widget.activeAudit.photoSig['siteRepresentativeSignature'] = siteRepresentativeSignature;
                            Provider.of<AuditData>(context, listen: false).notifyTheListeners();
                          });
                          debugPrint("onPressed ");
                        } else {
                          Dialogs.showMessage(
                              context: context,
                              message: "These action items must be updated: + $affectedIssues",
                              dismissable: true);
                        }
                        if (checkVisitAndHoldItems()) {
                          Dialogs.showMessage(
                              context: context,
                              message:
                                  "Please select if a follow up site visit is needed, \nor if the program should be put on hold.",
                              dismissable: true);
                        }
                      },
                    ),
                    FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        child: Text("Clear"),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),
                      onPressed: () {
                        final sign = _sign2.currentState;
                        sign.clear();
                        setState(() {
                          siteRepresentativeSignature = null;
                        });
                        debugPrint("cleared");
                      },
                    ),
                  ],
                ),
              if (siteRepresentativeSignature == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            color = color == Colors.green ? Colors.red : Colors.green;
                          });
                          debugPrint("change color");
                        },
                        child: Text("Change color")),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            int min = 1;
                            int max = 10;
                            int selection = min + (Random().nextInt(max - min));
                            strokeWidth = selection.roundToDouble();
                            debugPrint("change stroke width to $selection");
                          });
                        },
                        child: Text("Change stroke width")),
                  ],
                ),
              Container(height: 30),
              if (foodDepositoryMonitorSignature != null && siteRepresentativeSignature != null)
                FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                    child: Text(
                      "Success! Go to the Inspection Certificate",
                      style: ColorDefs.textBodyWhite30,
                    ),
                  ),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),

                  // color: Colors.green,
                  onPressed: () {
                    Provider.of<AuditData>(context, listen: false).updateGoToVerificationGoodPage(true);
                  },
                  // child: Text(
                  //   "Success! Go to the Inspection Certificate",
                  //   style: ColorDefs.textBodyWhite30,
                  // )
                ),

              Container(
                height: 300,
              )
            ],
          ),
        ),
      )),
    );
  }
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}
