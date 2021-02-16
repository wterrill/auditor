import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:flutter/material.dart';

class AuditEditMenu extends StatelessWidget {
  AuditEditMenu({Key key, this.calendarResult}) : super(key: key);
  final CalendarResult calendarResult;

  final List<String> statusDropDownMenu = [
    "Scheduled",
    "Site Visit Req.",
    "Completed",
  ];

  Widget build(BuildContext context) {
    return Container(
        width: 600,
        height: 800,
        child: Column(
          children: [
            Row(
              children: [
                Text("Change status"),
                DropdownButton<String>(
                  items: statusDropDownMenu.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                  },
                )
              ],
            )
          ],
        ));
  }
}
