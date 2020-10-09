import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'LookAhead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewAuditDialog extends StatefulWidget {
  final CalendarResult calendarResult;
  final bool followup;
  final Site loadSite;
  final bool alreadyExists;
  NewAuditDialog({Key key, this.calendarResult, @required this.followup, this.loadSite, this.alreadyExists})
      : super(key: key);

  @override
  _NewAuditDialogState createState() => _NewAuditDialogState();
}

class _NewAuditDialogState extends State<NewAuditDialog> {
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
      alreadyExistedCalendarResult = widget.calendarResult;
      if (widget.followup) {
        this.selectedAuditType = "Follow Up";
      } else {
        this.selectedAuditType = widget.calendarResult.auditType;
      }
      this.selectedProgType = widget.calendarResult.programType;
      this.selectedDate = widget.calendarResult.startDateTime;
      this.selectedTime = TimeOfDay.fromDateTime(widget.calendarResult.startDateTime);
      this.selectedSiteName = widget.calendarResult.agencyName;
      this.selectedProgramNumber = widget.calendarResult.programNum;
      this.selectedAuditor = widget.calendarResult.auditor;
      this.selectedAgencyNumber = widget.calendarResult.agencyNumber;
      if (widget.calendarResult.status != "Site Visit Req.") {
        alreadyExisted = true;
      }
    }
    if (widget.loadSite != null) {
      selectedSiteName = widget.loadSite.agencyName;

      selectedProgramNumber = widget.loadSite.programNumber;
      selectedAgencyNumber = widget.loadSite.agencyNumber;
    }

    auditorDropDownMenu = Provider.of<ListCalendarData>(context, listen: false).auditorList.getAuditorDropDown();
    siteList = Provider.of<SiteData>(context, listen: false).siteList;
  }

  List<String> auditorDropDownMenu;

  List<String> auditTypeDropDownMenu = [
    "Select",
    "Annual",
    "Food Rescue",
    "CEDA",
    "Bi-Annual",
    "Complaint",
    // "Follow Up",
    "Grant"
  ];
  List<String> auditTypeDropDownMenuFollowUp = [
    // "Select",
    // "Annual",
    // "Food Rescue",
    // "CEDA",
    // "Bi-Annual",
    // "Complaint",
    "Follow Up",
    // "Grant"
  ];

  SiteList siteList;

  // List<String> auditorDropDownMenu = [
  //   "Select",
  //   "Will Terrill",
  //   "Abraham Jimenez",
  //   "Andrei Kliuchnik",
  // ];

  List<String> programTypeDropDownMenu = [
    "Select",
    "Healthy Student Market",
    "Older Adults Program",
    "Pantry",
    "Congregate"
  ];

  @override
  Widget build(BuildContext context) {
    bool timeInPastOK = false;

    String selectButtonText() {
      String buttonText = "";
      if (alreadyExisted) {
        if (widget.followup) {
          buttonText = "Schedule Follow-Up Audit";
        } else {
          buttonText = "Save Changes";
        }
      } else {
        buttonText = "Schedule Audit";
      }
      return buttonText;
    }

    bool identicalEntry() {
      bool identical = false;
      if (alreadyExistedCalendarResult != null) {
        if (selectedAuditType == alreadyExistedCalendarResult.auditType &&
            selectedAuditor == alreadyExistedCalendarResult.auditor &&
            selectedProgType == alreadyExistedCalendarResult.programType &&
            selectedProgramNumber == alreadyExistedCalendarResult.programNum &&
            selectedSiteName == alreadyExistedCalendarResult.agencyName &&
            selectedTime.hour == alreadyExistedCalendarResult.startDateTime.hour &&
            selectedTime.minute == alreadyExistedCalendarResult.startDateTime.minute) {
          identical = true;
        }
      }
      return identical;
    }

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
      } else if (identicalEntry()) {
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
                disable: widget.followup,
                setValue: selectedSiteName,
                programNumber: (widget.followup) ? selectedProgramNumber : null,
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
                          if (widget.followup) {
                            newValue = "Follow Up";
                          }
                          selectedAuditType = newValue;
                        });
                      },
                      items:
                          widget.followup ? dropdown(auditTypeDropDownMenuFollowUp) : dropdown(auditTypeDropDownMenu),
                    ),
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
                        if (widget.followup) {
                          newValue = selectedProgType;
                        }
                        selectedProgType = newValue;
                      });
                    },
                    items: widget.followup ? dropdown([selectedProgType]) : dropdown(programTypeDropDownMenu),
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
                        ? FaIcon(FontAwesomeIcons.calendarAlt, color: ColorDefs.colorAnotherDarkGreen, size: 40)
                        : Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2.0, color: ColorDefs.colorAnotherDarkGreen),
                              ),
                            ),
                            child: Text(
                              DateFormat('EEE MM-dd-yyyy')?.format(selectedDate) ?? "",
                              style: ColorDefs.textGreen25,
                            ),
                          ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Start Time:",
                    style: ColorDefs.textGreen25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay fromTimeSelector = await showTimePicker(
                          context: context,
                          initialTime: (selectedTime != null) ? selectedTime : TimeOfDay(hour: 10, minute: 0));
                      setState(() {
                        if (fromTimeSelector != null) {
                          selectedTime = fromTimeSelector;
                        }
                      });
                    },
                    child: (selectedTime == null)
                        ? FaIcon(FontAwesomeIcons.clock, color: ColorDefs.colorAnotherDarkGreen, size: 40)
                        : Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2.0, color: ColorDefs.colorAnotherDarkGreen),
                              ),
                            ),
                            child: Text(selectedTime?.format(context).toString() ?? "", style: ColorDefs.textGreen25)),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                          // print(selectedTime.format(context).toString());
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

                          if (validated && timeInPastOK) {
                            if (alreadyExisted && !widget.followup) {
                              Provider.of<ListCalendarData>(context, listen: false)
                                  .deleteCalendarItem(widget.calendarResult);
                            }

                            DateTime selectedDateTime = DateTime(selectedDate.year, selectedDate.month,
                                selectedDate.day, selectedTime.hour, selectedTime.minute);
                            print(selectedDateTime.toString());
                            print(selectedSiteName);
                            print(selectedProgramNumber);

                            Map<String, dynamic> oldAuditCitationsObject;
                            String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;
                            if (widget.followup) {
                              oldAuditCitationsObject = Provider.of<AuditData>(context, listen: false)
                                  .getAuditCitationsObject(newCalendarResult: widget.calendarResult);

                              Provider.of<ListCalendarData>(context, listen: false)
                                  .updateStatusOnScheduleToCompleted(alreadyExistedCalendarResult);
                            }

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

                            bool exists = Provider.of<ListCalendarData>(context, listen: false).checkBoxEvent(
                              event: newEvent,
                            );

                            if (!exists) {
                              Provider.of<ListCalendarData>(context, listen: false).addBoxEvent(
                                event: newEvent,
                                notify: true,
                              );
                            } else {
                              Dialogs.showMessage(
                                  context: context,
                                  dismissable: true,
                                  message:
                                      "An audit exists at this location for the same time and same auditor. \nPlease check your entry and try again.");
                            }

                            if (!exists) {
                              Navigator.of(context).pop();
                              if (newEvent['auditType'] == "Follow Up") {
                                Navigator.of(context).pop();
                              }
                            }
                            if (alreadyExisted) {
                              Navigator.of(context).pop();
                            }
                          } else {
                            if (!identicalEntry()) {
                              Dialogs.showBadSchedule(context);
                            } else {
                              Navigator.of(context).pop();
                            }
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(selectButtonText(), style: ColorDefs.textGreen25),
                      ),
                    ),
                  ),
                  if (alreadyExisted && !widget.followup)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                      child: FlatButton(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                          child: Text("Delete Audit", style: ColorDefs.textGreen25),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
                                title: Text('Confirmation'),
                                content: Text('Do you want to delete this Scheduled Audit?'),
                                actions: <Widget>[
                                  new FlatButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(false); // dismisses only the dialog and returns false
                                    },
                                    child: Text('No'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true).pop(true);
                                      Provider.of<ListCalendarData>(context, listen: false)
                                          .deleteCalendarItem(widget.calendarResult);
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
                              // print(selectedTime.format(context).toString());

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
            ],
          ),
        ),
      ),
    );
  }
}
