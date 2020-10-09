import 'package:flutter/material.dart';
// import 'package:device_id/device_id.dart';
import 'package:device_info/device_info.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hive/hive.dart';
import 'dart:io' show Platform;

import 'package:path_provider/path_provider.dart';

class GeneralData with ChangeNotifier {
  String username;
  double safeAreaDiff = 0.0;
  BoxConstraints safeArea;
  Size mediaArea;
  int numberOfDaysShown;
  String deviceid;
  // bool confirmButtonEnabled = false;

  bool syncInProgress = false;
  String syncMessage = "";
  // bool emailValidated = false;
  bool showTopDrawer = false;
  bool rememberMe = false;
  Box generalBox;
  bool generalInitialized = false;
  ScrollController questionScrollController = ScrollController();

  //SchedulingPage
  bool backgroundDisable;
  String portNumber = "88";

  GeneralData() {
    initializeApp();
  }

  void initializeApp() async {
    await initHive();
    backgroundDisable = false;
    numberOfDaysShown = 8;

    if (!kIsWeb) {
      // deviceid = await DeviceId.getID;
      deviceid = await _getId();
      // deviceid = await DeviceId.getIMEI;
      // deviceid = await DeviceId.getMEID;
    } else {
      deviceid = "website";
    }
    if (kIsWeb) {
      portNumber = "90";
    }
    notifyListeners();
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  void updateDatabasePort(String newPortNumber) {
    portNumber = newPortNumber;
    notifyListeners();
  }

  void initHive() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Future generalFuture = Hive.openBox<String>('generalBox');
    Future.wait<dynamic>([generalFuture]).then((List<dynamic> value) {
      print("generalBox HIVE INTIALIZED");
      generalBox = Hive.box<String>('generalBox');
      generalInitialized = true;
      String rememberMeString = generalBox.get('rememberMe') as String;
      if (rememberMeString == "true") {
        rememberMe = true;
        username = generalBox.get('username') as String;
      } else {
        rememberMe = false;
      }
      notifyListeners();
    });
  }

  void notifyTheListeners() {
    notifyListeners();
  }

  void setRememberMe(bool value) {
    rememberMe = value;
    if (rememberMe) {
      generalBox.put('rememberMe', "true");
      // generalBox.put('username', username);
    } else {
      generalBox.put('rememberMe', "false");
      generalBox.delete('username');
    }
    print("****  rememberME  ****");
    print(rememberMe);
    print(generalBox.get('rememberMe'));
  }

  void saveUsername(String username) {
    // use,/rname = username;
    if (rememberMe) {
      generalBox.put('username', username);
    }
  }

  void toggleShowTopDrawer() {
    showTopDrawer = !showTopDrawer;
  }

  void updateNumberOfDaysShown(int number) {
    numberOfDaysShown = number;
    notifyListeners();
  }

  // void enableConfirmButton() {
  //   confirmButtonEnabled = true;
  //   notifyListeners();
  // }

  // void disableConfirmButton() {
  //   confirmButtonEnabled = false;
  //   notifyListeners();
  // }

  void toggleSyncInProgressOn() {
    syncInProgress = true;
    notifyListeners();
  }

  void toggleSyncInProgressOff() {
    syncInProgress = false;
    notifyListeners();
  }
}
