// import 'package:test/test.dart';
// import 'package:flutter_driver/flutter_driver.dart';

// void B1_ScheduleAudit() {
//   group('Schedule Audit', () {
//     // First, define the Finders and use them to locate widgets from the
//     // test suite. Note: the Strings provided to the `byValueKey` method must
//     // be the same as the Strings we used for the Keys in step 1.
//     final syncButton = find.byValueKey('syncButton');
//     final beer = find.byValueKey("beer");

//     FlutterDriver driver;

//     // Connect to the Flutter driver before running any tests.
//     setUpAll(() async {
//       driver = await FlutterDriver.connect();
//     });

//     // Close the connection to the driver after the tests have completed.
//     tearDownAll(() async {
//       if (driver != null) {
//         driver.close(); // suuk sing....   cha fong
//       }
//     });

//     test('sync', () async {
//       // Use the `driver tap, enterText and getText` method to verify the username has been entered
//       await driver.tap(syncButton);
//       await driver.waitFor(beer);
//     });
//   });
// }
