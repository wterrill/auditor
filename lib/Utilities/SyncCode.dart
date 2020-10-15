// import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Utilities/handleSentryError.dart';
import 'package:auditor/main.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sentry/sentry.dart';

void totalDataSync(BuildContext context) async {
  // check if logged in with a test account:
  String username = Provider.of<GeneralData>(context, listen: false).username;
  String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
  bool notATest = true;
  if (username.toLowerCase().contains("mxotest") && portNumber == "88") {
    Function callBack = () {
      notATest = false;
    };
    await Dialogs.notATestCheck(context, callBack);
  }
  if (notATest) {
    try {
      // Future.delayed(Duration(milliseconds: 300), () => true);

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a mobile network. or a wifi network
        print("######### CONNECTED inside syncCode  #########");
      } else {
        throw ("No internet connection found");
      }

      //// Site Data /////
      try {
        _showToast(context, "Syncing Data", Icon(Icons.sync), ColorDefs.colorAnotherDarkGreen);
      } catch (err) {
        print(err);
      }
      print("deviceid");
      String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;
      print("siteSync");
      try {
        await Provider.of<SiteData>(context, listen: false).siteSync();
      } catch (err) {
        print(err);
        _showToast(context, "Site Sync Failed: $err", Icon(Icons.close), ColorDefs.colorChatRequired);
        throw ("site sync failed: $err");
      }

      SiteList siteList = Provider.of<SiteData>(context, listen: false).siteList;

      print("ListCalendarData dataSync");
      try {
        await Provider.of<ListCalendarData>(context, listen: false)
            .dataSync(context: context, siteList: siteList, deviceid: deviceid, fullSync: false);
      } catch (err) {
        _showToast(context, "Schedule Sync Failed: $err", Icon(Icons.close), ColorDefs.colorChatRequired);
        throw ("ListCalendarData sync failed: $err");
      }

      print("AuditData dataSync");
      try {
        await Provider.of<AuditData>(context, listen: false)
            .dataSync(context: context, siteList: siteList, deviceid: deviceid, fullSync: false);
      } catch (err) {
        _showToast(context, "Audit Sync Failed: $err", Icon(Icons.close), ColorDefs.colorChatRequired);
        throw ("audit sync failed: $err");
      }

      print("making final edits");
      try {
        await Provider.of<ListCalendarData>(context, listen: false).sendOrderedEditsToCloud(deviceid);
      } catch (err) {
        _showToast(context, "Final Sync Failed: $err", Icon(Icons.close), ColorDefs.colorChatRequired);
        throw ("final edit sync failed: $err");
      }

      bool calendarSent = Provider.of<ListCalendarData>(context, listen: false).checkAllActiveSent();
      bool auditSent = Provider.of<AuditData>(context, listen: false).checkAllActiveSent();

      if (!calendarSent) {
        handleSentryError(
            auditor: Provider.of<GeneralData>(context, listen: false).username,
            errorMessage: "Not all calendar appointments were sent");
      }
      if (!auditSent) {
        handleSentryError(
            auditor: Provider.of<GeneralData>(context, listen: false).username,
            errorMessage: "Not all completed audits were sent");
      }
      if (!auditSent || !calendarSent) {
        _showToast(context, "Sync Unsuccessful: not all data sent. Contact Support", Icon(Icons.close),
            ColorDefs.colorChatRequired);

        handleSentryError(
            errorMessage: "Not all data sent... contact support",
            auditor: Provider.of<GeneralData>(navigatorKey.currentContext, listen: false).username);
      } else {
        /// Done with sync
        _showToast(
          context,
          "Synced Successfully",
          Icon(Icons.check),
          ColorDefs.colorAnotherDarkGreen,
        );
      }
    } catch (err, stackTrace) {
      print("failed");
      print(err);
      print(stackTrace);
      _showToast(context, "Sync Unsuccessful: $err", Icon(Icons.close), ColorDefs.colorChatRequired);

      handleSentryError(
          errorMessage: "sync unsuccessful: $err",
          auditor: Provider.of<GeneralData>(navigatorKey.currentContext, listen: false).username);
    }
  }
}

void _showToast(BuildContext context, String message, Icon icon, Color color) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: color),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        SizedBox(
          width: 12.0,
        ),
        Flexible(child: Text(message, style: ColorDefs.textBodyWhite25)),
      ],
    ),
  );
  var fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 4),
  );
}
