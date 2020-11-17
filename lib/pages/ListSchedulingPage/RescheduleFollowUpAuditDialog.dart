import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'LookAhead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RescheduleFollowUpAuditDialog extends StatefulWidget {
  final CalendarResult calendarResult;
  final bool auditAlreadyStarted;
  RescheduleFollowUpAuditDialog({Key key, @required this.calendarResult, this.auditAlreadyStarted}) : super(key: key);

  @override
  _RescheduleFollowUpAuditDialogState createState() => _RescheduleFollowUpAuditDialogState();
}

class _RescheduleFollowUpAuditDialogState extends State<RescheduleFollowUpAuditDialog> {
  final _formKey = GlobalKey<FormState>();
  String selectedAuditType = "Select";
  String selectedProgType = "Select";
  DateTime selectedDate; // = DateTime.now();
  TimeOfDay selectedTime; // = TimeOfDay(hour: 10, minute: 0);
  String selectedSiteName;
  String selectedProgramNumber;
  String selectedAgencyNumber;
  String selectedAuditor = "Select";
  bool alreadyExisted = false;
  CalendarResult alreadyExistedCalendarResult;

  @override
  void initState() {
    super.initState();
    if (widget.calendarResult != null) {
      alreadyExistedCalendarResult = widget.calendarResult.clone();

      this.selectedAuditType = widget.calendarResult.auditType; //"Follow Up";

      this.selectedProgType = widget.calendarResult.programType;
      this.selectedDate = widget.calendarResult.startDateTime;
      this.selectedTime = TimeOfDay.fromDateTime(widget.calendarResult.startDateTime);
      this.selectedSiteName = widget.calendarResult.agencyName;
      this.selectedProgramNumber = widget.calendarResult.programNum;
      this.selectedAuditor = widget.calendarResult.auditor;
      this.selectedAgencyNumber = widget.calendarResult.agencyNumber;
      auditTypeDropDownMenuFollowUp = [widget.calendarResult.auditType];
      programTypeDropDownMenu = [widget.calendarResult.programType];

      alreadyExisted = true;
    }

    auditorDropDownMenu = Provider.of<ListCalendarData>(context, listen: false).auditorList.getAuditorDropDown();
    siteList = Provider.of<SiteData>(context, listen: false).siteList;
  }

  List<String> auditorDropDownMenu;

  // List<String> auditTypeDropDownMenu = [
  //   "Select",
  //   "Annual",
  //   "Food Rescue",
  //   "CEDA",
  //   "Bi-Annual",
  //   "Complaint",
  //   // "Follow Up",
  //   "Grant"
  // ];
  List<String> auditTypeDropDownMenuFollowUp = [
    // "Select",
    // "Annual",
    // "Food Rescue",
    // "CEDA",
    // "Bi-Annual",
    // "Complaint",
    // "Follow Up", //////
    // "Grant"
  ];

  SiteList siteList;

  // List<String> auditorDropDownMenu = [
  //   "Select",
  //   "Will Terrill",
  //   "Abraham Jimenez",
  //   "Andrei Kliuchnik",
  // ];

  List<String> programTypeDropDownMenu;
  //  = [
  //   "Select",
  //   "Healthy Student Market",
  //   "Older Adults Program",
  //   "Pantry",
  //   "Congregate"
  // ];

  @override
  Widget build(BuildContext context) {
    bool timeInPastOK = false;
    bool validateEntry() {
      bool validated = true;
      if (selectedAuditType == "Select") {
        validated = false;
      } else if (selectedAuditor == "Select") {
        validated = false;
      } else if (selectedProgType == "Select") {
        validated = false;
      } else if (selectedProgramNumber == null) {
        validated = false;
      } else if (selectedSiteName == null) {
        validated = false;
      } else if (selectedTime == null) {
        validated = false;
      }

      return validated;
    }

    bool pastTimeWarning() {
      bool pastTime = false;
      if (selectedDate != null && selectedTime != null) {
        DateTime enteredTime =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute);
        if (DateTime.now().isAfter(enteredTime)) {
          pastTime = true;
        }
      }
      return pastTime;
    }

    List<DropdownMenuItem<String>> dropdown(List<String> stringArray) {
      List<DropdownMenuItem<String>> dropDownList = stringArray.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: ColorDefs.textGreen25,
          ),
        );
      }).toList();
      return dropDownList;
    }

    return Theme(
        data: ThemeData(
          brightness: Brightness.light,
        ),
        child: Container(
          width: 650,
          height: 700,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LookAhead(
                  disable: true,
                  setValue: selectedSiteName,
                  programNumber: selectedProgramNumber,
                  lookAheadCallback: (List<String> val) {
                    selectedSiteName = val[0];
                    selectedProgramNumber = val[1];
                    selectedAgencyNumber = siteList.agencyNumberFromAgencyName(selectedSiteName);
                    print(selectedAgencyNumber);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Audit Type:",
                      style: ColorDefs.textGreen25,
                    ),
                    Container(
                      child: DropdownButton<String>(
                          isExpanded: false,
                          value: selectedAuditType ?? "Select",
                          icon: Icon(Icons.keyboard_arrow_down, color: ColorDefs.colorLogoLightGreen, size: 60),
                          // iconSize: 24,
                          elevation: 16,
                          style: ColorDefs.textBodyBlack20,
                          underline: Container(
                            height: 2,
                            color: (selectedAuditType == "") ? Colors.red : Colors.green,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              //newValue = "Follow Up";
                              newValue = widget.calendarResult.auditType;

                              selectedAuditType = newValue;
                            });
                          },
                          items: dropdown(auditTypeDropDownMenuFollowUp)),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Program Type:", style: ColorDefs.textGreen25),
                    DropdownButton<String>(
                      isExpanded: false,
                      value: selectedProgType ?? "Select",
                      icon: Icon(Icons.keyboard_arrow_down, color: ColorDefs.colorLogoLightGreen, size: 60),
                      // iconSize: 24,
                      elevation: 16,
                      style: ColorDefs.textBodyBlack20,
                      underline: Container(
                        height: 2,
                        color: (selectedProgType == "") ? Colors.red : Colors.green,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          newValue = selectedProgType;

                          selectedProgType = newValue;
                        });
                      },
                      items: dropdown([widget.calendarResult.programType]),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date:", style: ColorDefs.textGreen25),
                    GestureDetector(
                      onTap: () async {
                        DateTime fromCalendar;
                        fromCalendar = await showDatePicker(
                          helpText: "Select a Date",
                          cancelText: "Cancel",
                          confirmText: "Confirm",
                          errorFormatText: "errorFormat",
                          errorInvalidText: "errorInvalidText",
                          fieldHintText: "fieldHintText",
                          fieldLabelText: "fieldLabelText",
                          context: context,
                          initialDate: (selectedDate != null) ? selectedDate : DateTime.now(),
                          firstDate: DateTime(2018),
                          lastDate: DateTime(2030),
                        );

                        setState(() {
                          if (fromCalendar != null) {
                            selectedDate = fromCalendar;
                          }
                        });
                      },
                      child: (selectedDate == null)
                          ? FaIcon(FontAwesomeIcons.calendarAlt, color: ColorDefs.colorAnotherDarkGreen, size: 60)
                          : Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 2.0, color: ColorDefs.colorAnotherDarkGreen),
                                ),
                              ),
                              child: Text(
                                DateFormat('EEE MM-dd-yyyy').format(selectedDate),
                                style: ColorDefs.textGreen25,
                              ),
                            ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Start Time:", style: ColorDefs.textGreen25),
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay fromTimeSelector = await showTimePicker(
                            context: context,
                            initialTime: (selectedTime != null) ? selectedTime : TimeOfDay(hour: 10, minute: 0)
                            // builder: (BuildContext context, Widget child) {
                            //   return Directionality(
                            //     // textDirection: TextDirection.LTR,
                            //     child: child,
                            //   );
                            // },
                            );
                        setState(() {
                          if (fromTimeSelector != null) {
                            selectedTime = fromTimeSelector;
                          }
                        });
                      },
                      child: (selectedTime == null)
                          ? FaIcon(FontAwesomeIcons.clock, color: ColorDefs.colorAnotherDarkGreen, size: 60)
                          : Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 2.0, color: ColorDefs.colorAnotherDarkGreen),
                                ),
                              ),
                              child: Text(selectedTime.format(context).toString(), style: ColorDefs.textGreen25)),

                      // Text(selectedTime.format(context).toString(), style: ColorDefs.textGreen25),
                    ),
                  ],
                ),

                ////////////////////////

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Auditor:",
                      style: ColorDefs.textGreen25,
                    ),
                    Container(
                      child: DropdownButton<String>(
                        isExpanded: false,
                        value: selectedAuditor ?? "Select",
                        icon: Icon(Icons.keyboard_arrow_down, color: ColorDefs.colorLogoLightGreen, size: 60),
                        iconSize: 24,
                        elevation: 16,
                        style: ColorDefs.textBodyBlack20,
                        underline: Container(
                          height: 2,
                          color: (selectedAuditType == "") ? Colors.red : Colors.green,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            selectedAuditor = newValue;
                          });
                        },
                        items: dropdown(auditorDropDownMenu),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                  child: FlatButton(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          print(selectedDate);
                          print(selectedTime.format(context).toString());
                          bool validateDateTime = pastTimeWarning();
                          if (validateDateTime) {
                            Function callBack = () {
                              timeInPastOK = true;
                            };
                            await Dialogs.timeInPast(context, callBack);
                          } else {
                            timeInPastOK = true;
                          }

                          bool validated = validateEntry();

                          Map<String, dynamic> oldAuditCitationsObject = widget.calendarResult.citationsToFollowUp;

                          if (validated && timeInPastOK) {
                            if (widget.calendarResult.auditType != "Follow Up")
                              Provider.of<ListCalendarData>(context, listen: false)
                                  .deleteCalendarItem(widget.calendarResult);

                            DateTime selectedDateTime = DateTime(selectedDate.year, selectedDate.month,
                                selectedDate.day, selectedTime.hour, selectedTime.minute);
                            print(selectedDateTime.toString());
                            print(selectedSiteName);
                            print(selectedProgramNumber);

                            // Map<String, dynamic> oldAuditCitationsObject;
                            String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;
                            // if (widget.followup) {
                            //   // oldAuditCitationsObject =
                            //   //     Provider.of<AuditData>(context, listen: false)
                            //   //         .getAuditCitationsObject(
                            //   //             newCalendarResult: widget.calendarResult);

                            if (alreadyExistedCalendarResult.status == "Site Visit Req.")
                              Provider.of<ListCalendarData>(context, listen: false)
                                  .updateStatusOnScheduleToCompleted(alreadyExistedCalendarResult);
                            // }

                            if (oldAuditCitationsObject != null) {
                              oldAuditCitationsObject['PreviousEvent'] = {
                                'StartTime': alreadyExistedCalendarResult.startTime,
                                'AgencyName': alreadyExistedCalendarResult.agencyName,
                                'AgencyNumber': alreadyExistedCalendarResult.agencyNumber,
                                'ProgramNumber': alreadyExistedCalendarResult.programNum,
                                'AuditType': alreadyExistedCalendarResult.auditType,
                                'ProgramType': alreadyExistedCalendarResult.programType.toString(),
                                'Auditor': alreadyExistedCalendarResult.auditor
                              };
                            }

                            if (oldAuditCitationsObject != null &&
                                oldAuditCitationsObject['PreviousEvent']['AuditType'] == "Follow Up") {
                              oldAuditCitationsObject['PreviousEvent'] = {
                                'StartTime': selectedDateTime.toString(),
                                'AgencyName': alreadyExistedCalendarResult.agencyName,
                                'AgencyNumber': alreadyExistedCalendarResult.agencyNumber,
                                'ProgramNumber': alreadyExistedCalendarResult.programNum,
                                'AuditType': alreadyExistedCalendarResult.auditType,
                                'ProgramType': alreadyExistedCalendarResult.programType.toString(),
                                'Auditor': selectedAuditor,
                              };
                            }

                            Map<String, dynamic> newEvent = <String, dynamic>{
                              'startTime': selectedDateTime.toString(),
                              'message': '',
                              'agencyName': selectedSiteName,
                              'agencyNumber': selectedAgencyNumber,
                              'auditType': selectedAuditType,
                              'programNum': selectedProgramNumber,
                              'programType': selectedProgType,
                              'auditor': selectedAuditor,
                              'status': "Scheduled",
                              'deviceid': deviceid,
                              'citationsToFollowUp': oldAuditCitationsObject
                            };

                            if (widget.auditAlreadyStarted) {
                              oldAuditCitationsObject = newEvent;
                            }

                            bool exists = Provider.of<ListCalendarData>(context, listen: false).checkBoxEvent(
                              event: newEvent,
                            );

                            if (!exists) {
                              Provider.of<ListCalendarData>(context, listen: false).addBoxEvent(
                                event: newEvent,
                                notify: true,
                              );
                              if (widget.auditAlreadyStarted) {
                                // the audit needs to be retrieved, then it needs to be stored under a different name
                                Audit retrievedAudit = Provider.of<AuditData>(context, listen: false)
                                    .getAuditFromBox(alreadyExistedCalendarResult);
                                Audit copy_retrieved = retrievedAudit.clone();
                                Provider.of<AuditData>(context, listen: false)
                                    .deleteAudit(retrievedAudit.calendarResult);

                                // Update retrieved audit:
                                copy_retrieved.calendarResult.startTime = newEvent['startTime'] as String;
                                copy_retrieved.calendarResult.auditor = newEvent['auditor'] as String;
                                copy_retrieved.calendarResult.startDateTime =
                                    DateTime.parse(newEvent['startTime'] as String);

                                Provider.of<AuditData>(context, listen: false)
                                    .saveAuditLocally(incomingAudit: copy_retrieved);
                                if (widget.calendarResult.auditType == "Follow Up")
                                  Provider.of<ListCalendarData>(context, listen: false)
                                      .deleteCalendarItem(alreadyExistedCalendarResult);

                                print("#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#");
                              } else {
                                if (widget.calendarResult.auditType == "Follow Up")
                                  Provider.of<ListCalendarData>(context, listen: false)
                                      .deleteCalendarItem(alreadyExistedCalendarResult);
                              }
                            } else {
                              Dialogs.showMessage(
                                  context: context,
                                  dismissable: true,
                                  message:
                                      "An audit exists at this location for the same time and same auditor. \nPlease check your entry and try again.",
                                  textStyle: ColorDefs.textWhiteTerminal,
                                  bckcolor: ColorDefs.colorDarkBackground);
                            }

                            if (!exists) {
                              Navigator.of(context).pop();
                            }
                            if (alreadyExisted) {
                              Navigator.of(context).pop();
                            }
                          } else {
                            Dialogs.showBadSchedule(context);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: widget.auditAlreadyStarted
                            ? Text("Reschedule Audit in Progress", style: ColorDefs.textGreen25)
                            : Text("Reschedule Follow-Up Audit", style: ColorDefs.textGreen25),
                      )),
                ),

                if (widget.auditAlreadyStarted)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                    child: FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: Text("Delete Audit in Progress", style: ColorDefs.textGreen25),
                      ),
                      color: ColorDefs.colorTopHeader,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3.0)),
                      onPressed: () async {
                        bool result = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content: Text('Do you want to delete this Audit in progress?'),
                              actions: <Widget>[
                                new FlatButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(false); // dismisses only the dialog and returns false
                                  },
                                  child: Text('Cancel'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true).pop(true);
                                    Provider.of<ListCalendarData>(context, listen: false)
                                        .deleteCalendarItem(widget.calendarResult);
                                    Provider.of<AuditData>(context, listen: false).deleteAudit(widget.calendarResult);
                                    setState(() {}); // dismisses only the dialog and returns true
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );

                        if (result) {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            print(selectedDate);
                            print(selectedTime.format(context).toString());

                            Provider.of<ListCalendarData>(context, listen: false)
                                .deleteCalendarItem(widget.calendarResult);

                            Navigator.of(context).pop();
                            if (alreadyExisted) {
                              Navigator.of(context).pop();
                            }
                          }
                        } else {
                          Navigator.of(context).pop(); // dismisses the entire widget
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
