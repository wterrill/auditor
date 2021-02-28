import 'package:auditor/Utilities/FlatButtonToTextButton.dart';
import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HiveTroubleShooting extends StatefulWidget {
  HiveTroubleShooting({Key key}) : super(key: key);

  @override
  _HiveTroubleShootingState createState() => _HiveTroubleShootingState();
}

List<dynamic> result = <String>["press the buttons"];

class _HiveTroubleShootingState extends State<HiveTroubleShooting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => ListSchedulingPage()),
                );
              },
              child: Text("Go to scheduling page")),
          ElevatedButton(
            child: Text("calendarBoxKeys"),
            onPressed: () {
              Box calendarBox = Provider.of<ListCalendarData>(context, listen: false).calendarBox;
              result = calendarBox.keys.toList();
              for (dynamic key in result) {
                print(key);
              }
              setState(() {});
            },
          ),
          RaisedButtonX(
            colorx: Colors.red,
            childx: Text("auditData keys"),
            onPressedx: () {
              result = Provider.of<AuditData>(context, listen: false).auditBox.keys.toList();
              setState(() {});
            },
          ),
          RaisedButtonX(
            colorx: Colors.red,
            childx: Text("auditData to send keys"),
            onPressedx: () {
              result = Provider.of<AuditData>(context, listen: false).auditOutBox.keys.toList();
              setState(() {});
            },
          ),
          RaisedButtonX(
            colorx: Colors.red,
            childx: Text("delete Audit Data and Audit 'to send' data"),
            onPressedx: () {
              result = Provider.of<AuditData>(context, listen: false).auditBox.keys.toList();

              for (dynamic key in result) {
                String keyString = key as String;
                Provider.of<AuditData>(context, listen: false).auditBox.delete(keyString);
              }
              result = Provider.of<AuditData>(context, listen: false).auditOutBox.keys.toList();

              for (dynamic key in result) {
                String keyString = key as String;
                Provider.of<AuditData>(context, listen: false).auditOutBox.delete(keyString);
              }
              result = <String>["All Audit data deleted"];
              setState(() {});
            },
          ),
          RaisedButtonX(
            colorx: Colors.red,
            childx: Text("delete calendar Data and calendar 'to send' data"),
            onPressedx: () {
              result = Provider.of<ListCalendarData>(context, listen: false).calendarBox.keys.toList();

              for (dynamic key in result) {
                String keyString = key as String;
                Provider.of<ListCalendarData>(context, listen: false).calendarBox.delete(keyString);
              }

              result = Provider.of<ListCalendarData>(context, listen: false).calendarOrderedOutBox.keys.toList();

              for (dynamic key in result) {
                String keyString = key as String;
                Provider.of<ListCalendarData>(context, listen: false).calendarOrderedOutBox.delete(keyString);
              }

              result = <String>["All calendar data deleted"];
              setState(() {});
            },
          ),
          ElevatedButton(
            child: Text("Clear"),
            onPressed: () {
              result = <String>['Cleared'];
              setState(() {});
            },
          ),
          Text(result.toString())
        ],
      ),
    );
  }
}
