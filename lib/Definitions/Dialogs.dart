import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/pages/AuditPage/ScoringPopUp.dart';
import 'package:auditor/pages/ListSchedulingPage/ApptDataTable/AuditInfoDialog.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auditor/pages/ListSchedulingPage/NewAuditDialog.dart';
import 'package:auditor/pages/ListSchedulingPage/RescheduleFollowUpAuditDialog.dart';
import 'package:auditor/pages/ListSchedulingPage/SitePopUp.dart';
import 'package:auditor/pages/developer/DeveloperMenu.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/buildTime/flutterVersion.dart';
import 'package:auditor/buildTime/flutterDate.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'AuditClasses/Audit.dart';
import 'SiteClasses/SiteList.dart';
import 'colorDefs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dialogs {
  static void showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showSuccess(BuildContext context) async {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 5),
              child: Text("The Audit has been successfully saved and will upload during the next sync")),
        ],
      ),
    );
    await showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showMessage({@required BuildContext context, @required String message, @required bool dismissable}) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: ColorDefs.textWhiteTerminal),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: dismissable,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showWidget({@required BuildContext context, @required Widget widget, @required bool dismissable}) {
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
        elevation: 6.0,
        content: widget);
    showDialog<void>(
      barrierDismissible: dismissable,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showPicture({BuildContext context, Uint8List image, bool dismissable}) {
    showDialog<void>(
      context: context,
      barrierDismissible: dismissable,
      builder: (_) => new AlertDialog(
        contentPadding: EdgeInsets.all(2.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return Container(
              height: height,
              width: width,
              child: PhotoView(
                // customSize: MediaQuery.of(context).size * 0.8,
                // minScale: PhotoViewComputedScale.contained * 0.3,
                // maxScale: PhotoViewComputedScale.covered * 0.9,
                // initialScale: PhotoViewComputedScale.contained * 0.6,
                imageProvider: MemoryImage(image),
              ),
            );
          },
        ),
      ),
    );
  }

  static void timeInPast(BuildContext context, Function continueCallBack) async {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The date and time you entered is in the past.  Are you sure you want to schedule this audit?'),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Yes"),
          onPressed: () {
            continueCallBack();
            Navigator.of(context).pop(true);
          },
        ),
        new FlatButton(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
    await showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showid(BuildContext context, String deviceid) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Your devices id number is $deviceid'),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showNotSynced(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              'This device has not had an initial sync with the database.  Please connect to a wifi connection and allow the device to sync prior to initial use.'),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showSites({BuildContext context, String programNumber, @required bool singleSite}) {
    AlertDialog alert = AlertDialog(
        contentPadding: EdgeInsets.all(0.0),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
        elevation: 0.0,
        content: SitePopUp(programNumber: programNumber, singleSite: singleSite));
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showScoring({BuildContext context, Audit audit}) {
    AlertDialog alert = AlertDialog(
        contentPadding: EdgeInsets.all(0.0),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
        elevation: 0.0,
        content: ScoringPopUp(audit: audit));
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void failedAuthentication(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: ColorDefs.colorAudit1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(FontAwesomeIcons.exclamationCircle, color: ColorDefs.colorTopHeader, size: 60),
          Container(
            width: 40,
          ),
          Expanded(
            child: Text(
              'Username or password is not correct.  Please try again.',
              style: ColorDefs.textBodyWhite25,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
    // showDialog<void>(
    //   barrierDismissible: true,
    //   context: context,
    //   builder: (_) {
    //     return alert;
    //   },
    // );
    showToast(context, alert);
  }

  static void mustBeNumber(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('This field requires a numeric response'),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void numbersOnly(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('This field only accepts numbers.  Please enter a whole digit number'),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void failedAuthenticationWithError(BuildContext context, String errorString) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('There was an error communicating with the server. Error = $errorString'),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showVersionDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Built and uploaded on: $buildDate'),
          Text("Flutter framework: ${version['frameworkVersion']}"),
          Text("Dart version: ${version['dartSdkVersion']}"),
          Text("App version: $appVersion"),
          Text("Device id: ${Provider.of<GeneralData>(context, listen: false).deviceid}")
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // static void showNotImplemented(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(50.0))),
  //     elevation: 6.0,
  //     content: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text('This program type is not yet available'),
  //       ],
  //     ),
  //   );
  //   showDialog<void>(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  static void showBadSchedule(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('This audit cannot be scheduled as entered.  Please verify that all fields are filled.'),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showPdfCreated(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      elevation: 6.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The pdf has been created'),
        ],
      ),
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showDeveloperMenu(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      title: Text('Open developer Menu?'),
      content: const Text('Do you want to open the developer menu?'),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: const Text('ACCEPT'),
          onPressed: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(builder: (context) => DeveloperMenu()),
            );
          },
        )
      ],
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showDeletePic(BuildContext context, int index) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      title: Text('Delete Pic?'),
      content: const Text('Would you like to delete this picture from the audit?'),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        FlatButton(
          child: const Text('YES'),
          onPressed: () {
            Provider.of<AuditData>(context, listen: false).removePicAtIndex(index);
            Navigator.of(context, rootNavigator: true).pop();
          },
        )
      ],
    );
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showAuditInfo(BuildContext context, CalendarResult calendarResult) {
    showDialog<void>(
      context: context, //navigatorKey.currentState.overlay.context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          backgroundColor: ColorDefs.colorTopHeader,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
          // title: Text("Audit Info"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                  child: FittedBox(fit: BoxFit.contain, child: AuditInfoDialog(calendarResult: calendarResult)));
            },
          ),
        );
      },
    );
  }

  static void showScheduledAudit({BuildContext context, Site siteFromLookupScreen}) {
    showGeneralDialog<void>(
        // barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                backgroundColor: ColorDefs.colorTopHeader,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                title: Text('Schedule Audit', style: ColorDefs.textGreen35),
                content: NewAuditDialog(followup: false, loadSite: siteFromLookupScreen),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: "Beer",
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Text("Beer?");
        });
  }

  static void showRescheduleAudit(BuildContext context,
      {CalendarResult calendarResult, bool followup, @required bool auditAlreadyStarted}) {
    bool rescheduleFollowUp =
        (followup == true && calendarResult.auditType == "Follow Up" && calendarResult.status == "Scheduled");
    Widget selectWidget(bool alreadyExists, bool rescheduleFollowUp) {
      Widget selectedWidget;
      if (rescheduleFollowUp) {
        selectedWidget =
            RescheduleFollowUpAuditDialog(calendarResult: calendarResult, auditAlreadyStarted: auditAlreadyStarted);
      } else {
        if (alreadyExists) {
          selectedWidget =
              RescheduleFollowUpAuditDialog(calendarResult: calendarResult, auditAlreadyStarted: auditAlreadyStarted);
        } else {
          selectedWidget =
              NewAuditDialog(calendarResult: calendarResult, followup: followup, alreadyExists: alreadyExists);
        }
      }

      return selectedWidget;
    }

    showGeneralDialog<void>(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                  backgroundColor: ColorDefs.colorTopHeader,
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                  title: (followup) //&& calendarResult.auditType == "Follow Up"
                      ? Text('Schedule Follow Up', style: ColorDefs.textGreen40)
                      : Text('Revise Audit', style: ColorDefs.textGreen40),
                  content: selectWidget(auditAlreadyStarted, rescheduleFollowUp)),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: "Beer",
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Text("Beer?");
        });
  }

  static void showToast(BuildContext context, Widget toast) {
    // fToast = FToast(context);
    FToast(context).showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }
}
