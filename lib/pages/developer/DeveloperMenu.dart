import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
import 'package:auditor/pages/developer/DatabaseDetails/DatabaseDetails.dart';
import 'package:auditor/pages/developer/hiveTroubleshooting/hiveTroubleshooting.dart';
import 'package:auditor/pages/developer/pdf/PdfDemo.dart';
import 'package:auditor/pages/developer/scrollStuff/scrollStuff.dart';
import 'package:auditor/pages/developer/textTesting/textTesting.dart';
import 'package:auditor/providers/GeneralData.dart';
// import 'package:auditor/pages/developer/pdf/showPdfDocument.dart';
// import 'package:auditor/pages/developer/pdf/writePdfDocument.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Canvas/Canvas.dart';
import 'WidgetSizeAndPosition/WidgetSizeAndPosition.dart';
import 'authenticationEndpoint.dart/testAuthentication.dart';
import 'clayContainer/ClayContainerEx.dart';
import 'fingerSign/fingerSign.dart';
import 'hiveTest/Contact.dart';
import 'hiveTest/HiveTest.dart';
import 'lookAhead/lookAhead.dart';
// import 'videoGame/VideoGame.dart';
import 'package:hive/hive.dart';

class DeveloperMenu extends StatelessWidget {
  const DeveloperMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate;
    TimeOfDay selectedTime;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: FlatButton(
                  color: Colors.green,
                  child: Text("Navigate back"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(builder: (context) => ListSchedulingPage()),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
//          Container(
//            child: FlatButton(
//                color: Colors.red,
//                child: Text("pdf generation"),
//                onPressed: () {
//                  Navigator.push<dynamic>(
//                    context,
//                    MaterialPageRoute<dynamic>(
//                        builder: (context) => PdfCreate()),
//                  );
//                }),
//          ),
//          Container(
//            child: FlatButton(
//              color: Colors.red,
//              child: Text("pdf viewing"),
//              onPressed: () {
//                Navigator.push<dynamic>(
//                  context,
//                  MaterialPageRoute<dynamic>(builder: (context) => PDFScreen()),
//                );
//              },
//            ),
//          ),
            FlatButton(
              color: Colors.red,
              child: Text("finger signing"),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => FingerSign()),
                );
              },
            ),

            FlatButton(
              color: Colors.red,
              child: Text("Look Ahead"),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => LookAhead()),
                );
              },
            ),

            FlatButton(
              color: Colors.red,
              child: Text("Pdf generation and display"),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => PdfDemo()),
                );
              },
            ),

            FlatButton(
              color: Colors.red,
              child: Text("Date picker"),
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
                print(selectedDate);
              },
            ),

            FlatButton(
              color: Colors.red,
              child: Text("TextTesting"),
              onPressed: () async {
                // Navigator.push(TextTest());

                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => TextTest()),
                );
              },
            ),

            FlatButton(
              color: Colors.red,
              child: Text("Time picker"),
              onPressed: () async {
                selectedTime = await showTimePicker(
                  context: context,
                  initialTime: (selectedTime != null) ? selectedTime : TimeOfDay(hour: 10, minute: 0),
                  builder: (BuildContext context, Widget child) {
                    return Directionality(
                      textDirection: TextDirection.ltr,
                      child: child,
                    );
                  },
                );
                print(selectedTime);
              },
            ),

            // FlatButton(
            //   color: Colors.red,
            //   child: Text("videogame"),
            //   onPressed: () {
            //     Navigator.push<dynamic>(
            //       context,
            //       MaterialPageRoute<dynamic>(builder: (context) => VideoGame()),
            //     );
            //   },
            // ),
            FlatButton(
              color: Colors.red,
              child: Text("hive test"),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (context) => FutureBuilder<dynamic>(
                      future: Hive.openBox<Contact>('contacts'),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return HiveTest();
                        } else
                          return Scaffold();
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.red,
              child: Text("Network Information"),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => TestAuthentication()),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.red,
              child: Text("show device ID"),
              onPressed: () {
                String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;
                Dialogs.showid(context, deviceid);
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => HiveTroubleShooting()),
                  );
                },
                child: Text("Hive Troubleshooting")),
            RaisedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => DatabaseDetails()),
                  );
                },
                child: Text("Database Details")),
            RaisedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => ProductDetails()),
                  );
                },
                child: Text("Scroll changes testing")),
            RaisedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => ClayContainerEx()),
                  );
                },
                child: Text("Clay Container testing")),
            RaisedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => BiggerOne()),
                  );
                },
                child: Text("Widget size and position")),
            RaisedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => MyPainter()),
                  );
                },
                child: Text("Canvas")),
          ],
        ),
      ),
    );
  }
}
