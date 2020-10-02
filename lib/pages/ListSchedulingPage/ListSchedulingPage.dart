import 'dart:ui';
import 'package:auditor/Definitions/AuditorClasses/AuditorList.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Utilities/SyncCode.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/ApptDataTable.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'TopDrawerWidget.dart';
import 'TopWhiteHeaderWidget.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListSchedulingPage extends StatefulWidget {
  @override
  _ListSchedulingPageState createState() => _ListSchedulingPageState();
}

class _ListSchedulingPageState extends State<ListSchedulingPage> with WidgetsBindingObserver {
  bool backgroundDisable = false;
  bool startSync = false;
  FToast fToast;
  // final filterTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // syncIfYouCan();
    // WidgetsBinding.instance
    // .addPostFrameCallback((_) => syncIfYouCan());

    print("ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ& STARTUP!!!!");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void syncIfYouCan() async {
    if (!kIsWeb) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a mobile network. or a wifi network
        print("######### CONNECTED site sync #########");
        await totalDataSync(context);
      }

      await totalDataSync(context);
    }
  }

  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   filterTextController.dispose();
  //   super.dispose();
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // bool startSync = false;
    if (state == AppLifecycleState.resumed) {
      print("&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&^  RESUMED!!!!");
      if (!kIsWeb) {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          // I am connected to a mobile network. or a wifi network
          print("######### CONNECTED total data sync #########");
          await totalDataSync(context);
        }
      }

      print("sync done");
    }

    if (state == AppLifecycleState.paused) {
      print("&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&ˆ&^  PAUSED!!!!");
      // await totalDataSync(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    fToast = FToast(context);
    bool filteredTime = Provider.of<ListCalendarData>(context, listen: false).filterTimeToggle;
    // String dayOfWeek = DateFormat('EEE').format(DateTime.now()).toString();
    AuditorList auditorList = Provider.of<ListCalendarData>(context).auditorList;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                TopWhiteHeaderWidget(), // white bar
                Expanded(
                  child: Container(
                    color: ColorDefs.colorDarkBackground,
                    child: Provider.of<ListCalendarData>(context).initializedx
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    color: Colors.black,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Container(
                                          child: Row(
                                        children: [
                                          Container(width: 30),
                                          InkWell(
                                              child: FaIcon(FontAwesomeIcons.sync, size: 35, key: Key('syncButton')),
                                              onTap: () async {
                                                var connectivityResult = await (Connectivity().checkConnectivity());
                                                FocusScopeNode currentFocus = FocusScope.of(context);
                                                if (!currentFocus.hasPrimaryFocus) {
                                                  currentFocus.unfocus();
                                                }
                                                if (connectivityResult == ConnectivityResult.mobile ||
                                                    connectivityResult == ConnectivityResult.wifi) {
                                                  // I am connected to a mobile network. or a wifi network
                                                  print("######### CONNECTED site sync #########");

                                                  await totalDataSync(context);
                                                } else {
                                                  fToast.showToast(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(25.0),
                                                        color: ColorDefs.colorTopHeader,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Icon(Icons.check, color: Colors.black),
                                                          SizedBox(
                                                            width: 12.0,
                                                          ),
                                                          Center(
                                                            child: Text("The app is currently in offline mode",
                                                                style: ColorDefs.textBodyBlack20),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    gravity: ToastGravity.BOTTOM,
                                                    toastDuration: Duration(seconds: 2),
                                                  );
                                                }
                                              }),
                                          Container(width: 30),
                                          InkWell(
                                            child: FaIcon(
                                              FontAwesomeIcons.sitemap,
                                              size: 35,
                                            ),
                                            onTap: () {
                                              // SiteList siteList =
                                              //     Provider.of<SiteData>(
                                              //             context,
                                              //             listen: false)
                                              //         .siteList;
                                              FocusScopeNode currentFocus = FocusScope.of(context);
                                              if (!currentFocus.hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                              Dialogs.showSites(context: context, singleSite: false);
                                            },
                                          )
                                        ],
                                      )),
                                      Container(
                                        height: 70,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  print("Show this week pressed");
                                                  Provider.of<ListCalendarData>(context, listen: false)
                                                      .toggleFilterTimeToggle();
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "${DateFormat('MM/dd').format(DateTime.now().subtract(Duration(days: 7)))}-${DateFormat('MM/dd').format(DateTime.now().add(Duration(days: 7)))}",
                                                        style: !filteredTime
                                                            ? ColorDefs.textBodyWhite20
                                                            : ColorDefs.textBodyWhite20Underlined),
                                                    Container(width: 2),
                                                    Text("|"),
                                                    Container(width: 2),
                                                    Text("Show All",
                                                        style: filteredTime
                                                            ? ColorDefs.textBodyWhite20
                                                            : ColorDefs.textBodyWhite20Underlined),
                                                  ],
                                                ) //filteredTime

                                                ),
                                            Container(
                                              width: 20,
                                            ),
                                            FlatButton(
                                              color: ColorDefs.colorTopHeader,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25.0),
                                                side: BorderSide(color: ColorDefs.colorLogoLightGreen, width: 3.0),
                                              ),
                                              onPressed: () {
                                                if (auditorList != null) {
                                                  Dialogs.showScheduledAudit(context: context);
                                                } else {
                                                  Dialogs.showNotSynced(context);
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                                                child: Text("Schedule Audit", style: ColorDefs.textBodyBlack20),
                                              ),
                                            ),
                                            Container(width: 20)
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              ApptDataTable()
                            ],
                          )
                        : Center(
                            child: Container(
                              height: 300,
                              width: 300,
                              child: Stack(
                                children: [
                                  Center(child: Text("Loading Data...")),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ],
              // ),
            ),
            if (backgroundDisable) Container(color: ColorDefs.colorDisabledBackground),

            if (Provider.of<GeneralData>(context).showTopDrawer) TopDrawerWidget(),
            // AuditPage()
          ],
        ),
      ),
    );
  }
}
