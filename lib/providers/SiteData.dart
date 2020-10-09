// import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:auditor/main.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';

List<List<dynamic>> rowsAsListOfValues;
List<dynamic> headers;

class SiteData with ChangeNotifier {
  List<List<dynamic>> rowsAsListOfValues;
  List<dynamic> headers;
  SiteList siteList;
  Box siteListBox;
  bool siteListInitialized = false;

  SiteData() {
    initialize();
    // initializeFakeSiteData();
  }

  // void initializeFakeSiteData() {
  //   rowsAsListOfValues = CsvToListConverter().convert(csvDataNew);
  //   headers = rowsAsListOfValues[0];
  //   rowsAsListOfValues = rowsAsListOfValues.sublist(1);
  //   print("headers type: ${headers.runtimeType}");
  //   print("rowsAsListOfValues type: ${rowsAsListOfValues.runtimeType}");
  // }

  void initialize() {
    initHive();
  }

  void initHive() {
    Future siteListFuture = Hive.openBox<SiteList>('siteListBox');

    Future.wait<dynamic>([siteListFuture]).then((List<dynamic> value) {
      print("siteList HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      siteListBox = Hive.box<SiteList>('siteListBox');
      siteListInitialized = true;
      siteList = siteListBox.get('siteList') as SiteList;
      notifyListeners();
    });
  }

  void notifyTheListeners() {
    notifyListeners();
  }

  void siteSync() async {
    print("sync");
    dynamic result = null;
    try {
      // import 'package:connectivity/connectivity.dart';
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a mobile network. or a wifi network
        print("######### CONNECTED site sync #########");
      } else {
        throw ("No internet connection found");
      }
      result = await SiteComms.getSites(context: navigatorKey.currentContext).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // Navigator.of(navigatorKey.currentContext).pop();
          // Dialogs.showMessage(
          //     context: navigatorKey.currentContext,
          //     message:
          //         "A timeout error has occurred while contacting the site data endpoint. Check internet connection",
          //     dismissable: true);
          return null;
        },
      );
    } catch (err) {
      print(err);
      result = null;
    }

    if (result != null) {
      siteList = SiteList(siteList: result as List<Site>);
      print("beflore siteList downloaded length");
      print("Sitelist downloaded length =  ${siteList.siteList.length}");
      print("after siteList downloaded length before put");
      print(siteList);
      siteListBox.put('siteList', siteList);
      print("after siteList put");
    }
    notifyListeners();
  }
}
