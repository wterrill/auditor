// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:auditor/providers/GeneralData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auditor/main.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Login Screen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    tester.binding.window.physicalSizeTestValue = Size(600, 2950);
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: null)<GeneralData>(
          //   builder: (context) => GeneralData(),
          // ),
          // Provider<Appointments>(
          //   builder: (context) => Appointments(),
          //  )

          await ChangeNotifierProvider(create: (context) => GeneralData()),
        ],
        child: Builder(
          builder: (_) => MyApp(),
        ),
      ),
    );

    // Verify that we can add data to the username field
    await tester.tap(find.byKey(Key('username')));
    await tester.enterText(find.byKey(Key('username')), 'beer');
    expect(find.text('beer'), findsOneWidget);
    // expect(find.text('mxotestaud1'), findsNothing);

    // // Verify that we can add data to the username field, and that it is not visible
    // await tester.tap(find.byKey(Key('password')));
    // await tester.enterText(find.byKey(Key('password')), 'alsobeer');
    // expect(find.text('alsobeer'), findsNothing);

    // // Verify that clicking the eyeball makes the password visible
    // await tester.tap(find.byKey(Key('eyeball')));
    // expect(find.text('findsOneWidget'), findsNothing);
  });
}
