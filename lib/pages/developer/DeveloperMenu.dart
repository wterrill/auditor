import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Utilities/FlatButtonToTextButton.dart';
import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
import 'package:auditor/pages/developer/DatabaseDetails/DatabaseDetails.dart';
import 'package:auditor/pages/developer/hiveTroubleshooting/hiveTroubleshooting.dart';
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
              child: FlatButtonX(
                  colorx: Colors.green,
                  textColorx: Colors.black,
                  childx: Text("Navigate back"),
                  onPressedx: () {
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
            FlatButtonX(
              colorx: Colors.red,
              textColorx: Colors.black,
              childx: Text("finger signing"),
              onPressedx: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => FingerSign()),
                );
              },
            ),

            FlatButtonX(
              colorx: Colors.red,
              textColorx: Colors.black,
              childx: Text("Look Ahead"),
              onPressedx: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => LookAhead()),
                );
              },
            ),

            FlatButtonX(
              colorx: Colors.red,
              textColorx: Colors.black,
              childx: Text("Date picker"),
              onPressedx: () async {
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

            FlatButtonX(
              colorx: Colors.red,
              textColorx: Colors.black,
              childx: Text("TextTesting"),
              onPressedx: () async {
                // Navigator.push(TextTest());

                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => TextTest()),
                );
              },
            ),

            FlatButtonX(
              colorx: Colors.red,
              textColorx: Colors.black,
              childx: Text("Time picker"),
              onPressedx: () async {
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
            FlatButtonX(
              colorx: Colors.red,
              textColorx: Colors.black,
              childx: Text("hive test"),
              onPressedx: () {
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
            FlatButtonX(
              colorx: Colors.red,
              textColorx: Colors.black,
              childx: Text("Network Information"),
              onPressedx: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => TestAuthentication()),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            FlatButtonX(
              colorx: Colors.red,
              textColorx: Colors.black,
              childx: Text("show device ID"),
              onPressedx: () {
                String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;
                Dialogs.showid(context, deviceid);
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => HiveTroubleShooting()),
                  );
                },
                child: Text("Hive Troubleshooting")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => DatabaseDetails()),
                  );
                },
                child: Text("Database Details")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => ProductDetails()),
                  );
                },
                child: Text("Scroll changes testing")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => ClayContainerEx()),
                  );
                },
                child: Text("Clay Container testing")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => BiggerOne()),
                  );
                },
                child: Text("Widget size and position")),
            ElevatedButton(
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
