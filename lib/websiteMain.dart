import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/Utilities/SyncCode.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/ColorAdapter.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:auditor/providers/WebData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/pages/LoginScreen/LoginScreen.dart';
import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
import 'package:provider/provider.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'Definitions/AuditClasses/Question.dart';
import 'Definitions/AuditClasses/Section.dart';
import 'Definitions/AuditClasses/Audit.dart';
// import 'Definitions/Dialogs.dart';
import 'Definitions/SiteClasses/Site.dart';
import 'Definitions/SiteClasses/SiteList.dart';
import 'Definitions/AuditorClasses/Auditor.dart';
import 'Definitions/AuditorClasses/AuditorList.dart';
import 'Definitions/colorDefs.dart';
import 'pages/developer/hiveTest/Contact.dart';
import 'package:auditor/pages/developer/hiveTest/Contact.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
// import 'package:background_fetch/background_fetch.dart';
import 'package:sentry/sentry.dart';
// import 'package:flutter_sentry/flutter_sentry.dart';
import 'dart:async';

final navigatorKey = GlobalKey<NavigatorState>();
final SentryClient sentry =
    SentryClient(dsn: 'https://cd836d0fb8ca4376b30917eef5b32517@o436899.ingest.sentry.io/5398676');

// Future<void>
void main() //=> FlutterSentry.wrap( ()
async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    final dynamic appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path as String);
  }
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(CalendarResultAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(SiteAdapter());
  Hive.registerAdapter(AuditAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(SectionAdapter());
  Hive.registerAdapter(StatusAdapter());
  Hive.registerAdapter(SiteListAdapter());
  Hive.registerAdapter(AuditorAdapter());
  Hive.registerAdapter(AuditorListAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListCalendarData()),
        ChangeNotifierProvider(create: (context) => GeneralData()),
        ChangeNotifierProvider(
          create: (context) => AuditData(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => WebData()),
        ChangeNotifierProvider(
          create: (context) => SiteData(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    ),
  );
  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
} // END OF wrap
//   dsn: 'https://cd836d0fb8ca4376b30917eef5b32517@o436899.ingest.sentry.io/5398676',
// );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool _enabled = true;
  // int _status = 0;
  // List<DateTime> _events = [];

  @override
  void initState() {
    super.initState();

    // initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    if (Provider.of<GeneralData>(context).rememberMe == true) {
      screen = ListSchedulingPage();
    } else {
      screen = LoginScreen();
    }
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        toggleableActiveColor: ColorDefs.colorLogoDarkGreen,
        fontFamily: 'Roboto', // 'Poppins', //'Arial', // Arial Regular, Arial, sans-serif  <-- from Kyle
        textTheme: TextTheme(),
      ),
      home: SafeArea(
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          print("constraints: $constraints");
          Size mediaSize = MediaQuery.of(context).size;
          double safeAreaSize = mediaSize.height - constraints.maxHeight;
          Provider.of<GeneralData>(context).safeAreaDiff = safeAreaSize;
          Provider.of<GeneralData>(context).safeArea = constraints;
          Provider.of<GeneralData>(context).mediaArea = mediaSize;

          return kIsWeb ? Scaffold(body: ListSchedulingPage()) : Scaffold(body: screen);
          // return Scaffold(body: ListSchedulingPage());
        }),
      ),
    );
  }
}
