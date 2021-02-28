import 'dart:convert';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/Utilities/FlatButtonToTextButton.dart';
import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ntlm/ntlm.dart';
// import 'dart:io';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import 'package:provider/provider.dart';

class TestAuthentication extends StatefulWidget {
  const TestAuthentication({Key key}) : super(key: key);

  @override
  _TestAuthenticationState createState() => _TestAuthenticationState();
}

class _TestAuthenticationState extends State<TestAuthentication> {
  String result = "Awaiting results...";
  bool isNtlm = true;
  dynamic sender;
  Uint8List pickedImage;

  Widget build(BuildContext context) {
    NTLMClient client = NTLMClient(
      domain: "",
      workstation: "LAPTOP",
      username: "MXOTestAud1",
      password: "Password1",
    );

    void pickImage() async {
//web
      // Uint8List fromPicker =
      //     await ImagePickerWeb.getImage(outputType: ImageType.bytes)
      //         as Uint8List;

      // if (fromPicker != null) {
      //   pickedImage = fromPicker;
      //   if (pickedImage == null) {
      //     print("buggered");
      //   }
      //   setState(() {
      //     pickedImage = fromPicker;
      //   });
      // }

//ios
      // File _image;
      final picker = ImagePicker();
      PickedFile fromPicker = await picker.getImage(source: ImageSource.gallery);
      pickedImage = await fromPicker.readAsBytes();
      setState(() {});
    }

    void uploadPic() {
      String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
      result = "";
      String base64Image = base64Encode(pickedImage);

      String body = jsonEncode(<String, dynamic>{
        "agencyNumber": "A00078",
        "ProgramNumber": "PY00002",
        "ProgramType": "1",
        "Auditor": "jchang",
        "AuditType": "2",
        "StartTime": "2020-05-29T13:00:00.000Z",
        "DeviceId": "aaabbbccc",
        "Files": [
          {"Filename": "snail", "FileExtension": ".png", "FileContent": "$base64Image"}
        ]
      });

      print(body);
      if (isNtlm) {
        sender = client.post('http://12.216.81.220:$portNumber/api/Audit/FileUpload',
            body: body, headers: {'Content-type': 'application/json', 'Accept': 'application/json'});
      } else {
        sender = http.post('http://12.216.81.220:$portNumber/api/Audit/FileUpload',
            body: body, headers: {'Content-type': 'application/json', 'Accept': 'application/json'});
      }
      sender.then((http.Response res) {
        print(res.statusCode);
        print(res.body);
        setState(() {
          result = res.body;
        });
      }).catchError((dynamic err) {
        print(err);
        setState(() {
          result = err.toString();
        });
      });
    }

////////////////////////////////////////////////////////////////
    void downloadSched() async {
      String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
      result = "";
      var queryParameters = {
        "MyDeviceId": "aaabbbccc",
        "QueryType": "1",
      };
      if (isNtlm) {
        sender = client.get(
            "http://12.216.81.220:$portNumber/api/Audit/Get?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
      } else {
        sender = http.get(
            "http://12.216.81.220:$portNumber/api/Audit/Get?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
      }
      sender.then(
        (http.Response res) {
          print(res.body);
          setState(
            () {
              result = res.body;
            },
          );
        },
      ).catchError((dynamic e) {
        setState(
          () {
            result = e.toString();
          },
        );
      });

      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(result);
      print(prettyprint);
      print(result);
      setState(() {
        result = prettyprint;
      });
    }

////////////////////////////////////////////////////////////////
    void getSiteInfo() {
      String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
      result = "";
      // http
      if (isNtlm) {
        sender = client.get("http://12.216.81.220:$portNumber/api/SiteInfo");
      } else {
        sender = http.get("http://12.216.81.220:$portNumber/api/SiteInfo");
      }
      print(sender);

      sender.then(
        (http.Response res) {
          print(res.body);
          setState(
            () {
              result = res.body;
            },
          );
        },
      ).catchError((dynamic e) {
        setState(
          () {
            result = e.toString();
          },
        );
      });
    }

////////////////////////////////////////////////////////////////
    void scheduleAudit() {
      String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
      result = "";
      // String body = jsonEncode(<String, dynamic>{
      //   'AED': 'A',
      //   'agencyNumber': 'A00091',
      //   'ProgramNumber': 'PY00005',
      //   'ProgramType': 1,
      //   'Auditor': 'MXOTestAud1',
      //   'AuditType': 1,
      //   'StartTime': '2020-06-30T12:00:00.000Z',
      //   'DeviceId': '****************************'
      // });
      // print(body);

      if (isNtlm) {
        sender = client.post('http://12.216.81.220:$portNumber/api/Audit/Schedule',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'X-Requested-With': 'XMLHttpRequest',
            },
            body: jsonEncode(<String, dynamic>{
              'AED': 'A',
              'AgencyNumber': 'A00091',
              'ProgramNumber': 'PY00005',
              'ProgramType': 1,
              'Auditor': 'MXOTestAud1',
              'AuditType': 1,
              'StartTime': '2020-06-30T12:00:00.000Z',
              'DeviceId': '****************************'
            }));
      } else {
        sender = http.post('http://12.216.81.220:$portNumber/api/Audit/Schedule',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'X-Requested-With': 'XMLHttpRequest',
            },
            body: jsonEncode(<String, dynamic>{
              'AED': 'A',
              'AgencyNumber': 'A00091',
              'ProgramNumber': 'PY00005',
              'ProgramType': 1,
              'Auditor': 'MXOTestAud1',
              'AuditType': 1,
              'StartTime': '2020-06-30T12:00:00.000Z',
              'DeviceId': '****************************'
            }));
      }

      sender.then((http.Response res) {
        print(res.body);
        setState(() {
          result = res.body;
        });
      }).catchError((dynamic e) {
        setState(
          () {
            result = e.toString();
          },
        );
      });
    }

////////////////////////////////////////////////////////////////
    void deleteScheduledAudit() {
      String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
      result = "";
      dynamic body = jsonEncode(<String, dynamic>{
        'AED': 'D',
        'AgencyNumber': 'A00091',
        'ProgramNumber': 'PY00005',
        'ProgramType': 1,
        'Auditor': 'MXOTestAud1',
        'AuditType': 1,
        'StartTime': '2020-06-30T12:00:00.000Z',
        'DeviceId': '****************************'
      });

      if (isNtlm) {
        sender = client.post('http://12.216.81.220:$portNumber/api/Audit/Schedule',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'X-Requested-With': 'XMLHttpRequest',
            },
            body: body as String);
      } else {
        sender = http.post('https://cors-anywhere.herokuapp.com/http://12.216.81.220:$portNumber/api/Audit/Schedule',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'X-Requested-With': 'XMLHttpRequest',
            },
            body: body as String);
      }
      sender.then((http.Response res) {
        print(res.body);
        setState(() {
          result = res.body;
        });
      }).catchError((String e) {
        setState(
          () {
            result = e.toString();
          },
        );
      });
    }

////////////////////////////////////////////////////////////////
    void sendFullAudit() {
      String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
      result = "";
      String body = jsonEncode(auditToSend);

      if (isNtlm) {
        sender = client.post('http://12.216.81.220:$portNumber/api/Audit/',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'X-Requested-With': 'XMLHttpRequest',
            },
            body: body);
      } else {
        sender = http.post('https://cors-anywhere.herokuapp.com/http://12.216.81.220:$portNumber/api/Audit/',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'X-Requested-With': 'XMLHttpRequest',
            },
            body: body);
      }
      sender.then((http.Response res) {
        print(res.body);
        setState(() {
          result = res.body;
        });
      }).catchError((dynamic e) {
        setState(
          () {
            result = e.toString();
          },
        );
      });
    }

////////////////////////////////////////////////////////////////
    void getFullAudit() async {
      String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
      result = "";
      var queryParameters = {
        "MyDeviceId": "aaabbbccc",
        "QueryType": "1",
      };

      if (isNtlm) {
        sender = client.get(
            "http://12.216.81.220:$portNumber/api/Audit/Query?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
      } else {
        sender = http.get(
            "http://12.216.81.220:$portNumber/api/Audit/Query?MyDeviceId=${queryParameters['MyDeviceId']}&QueryType=${queryParameters['QueryType']}");
      }

      sender.then(
        (http.Response res) {
          print(res.body);
          setState(
            () {
              result = res.body;
            },
          );
        },
      ).catchError((dynamic e) {
        setState(
          () {
            result = e.toString();
          },
        );
      });

      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(result);
      print(prettyprint);
      // print(respo,nse);
      setState(() {
        result = prettyprint;
      });
    }

////////////////////////////////////////////////////////////////
    void getAuditors() {
      String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
      result = "";

      if (isNtlm) {
        sender = client.get("http://12.216.81.220:$portNumber/api/GetAuditors");
      } else {
        sender = http.get("http://12.216.81.220:$portNumber/api/GetAuditors");
      }
      sender.then(
        (http.Response res) {
          print(res.body);
          setState(
            () {
              result = res.body;
            },
          );
        },
      ).catchError((dynamic e) {
        setState(
          () {
            result = e.toString();
          },
        );
      });

      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(result);
      print(prettyprint);
      // print(respo,nse);
      setState(() {
        result = prettyprint;
      });
    }

    void deleteEverything() async {
      String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
      result = "";
      bool doIt = false;
      if (portNumber == "88") {
        Function callBack = () {
          doIt = true;
        };
        await Dialogs.messageContinue(
            context: context,
            continueCallBack: callBack,
            message: "THIS WILL ERASE ALL THE DATA ON THE PRODUCTION SERVER. ARE YOU SURE YOU WANT TO DO THIS!");
      } else if (portNumber == '90') {
        doIt = true;
      }

      if (doIt) {
        if (isNtlm) {
          sender = client.get("http://12.216.81.220:$portNumber/api/Audit/DeleteAll");
        } else {
          sender = http.get("http://12.216.81.220:$portNumber/api/Audit/DeleteAlls");
        }
        sender.then(
          (http.Response res) {
            print(res.body);
            setState(
              () {
                result = res.body;
              },
            );
          },
        ).catchError((dynamic e) {
          setState(
            () {
              result = e.toString();
            },
          );
        });

        JsonEncoder encoder = new JsonEncoder.withIndent('  ');
        String prettyprint = encoder.convert(result);
        print(prettyprint);
        // print(respo,nse);
        setState(() {
          result = prettyprint;
        });
      }
    }

    String portNumber = Provider.of<GeneralData>(context, listen: false).portNumber;
////////////////////////////////////////////////////////////////
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        client
                            // http
                            .get(
                          "http://12.216.81.220:$portNumber/api/AuthenticateUser",
                        )
                            .then((res) {
                          print(res.body);
                          setState(() {
                            result = res.body;
                          });
                        }).catchError((dynamic e) {
                          setState(
                            () {
                              result = e.toString();
                            },
                          );
                        });
                      },
                      child: Text("Authenticate"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // client
                        getSiteInfo();
                      },
                      child: Text("siteInfo"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        scheduleAudit();
                      },
                      child: Text("schedule audit"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        deleteScheduledAudit();
                      },
                      child: Text("delete same audit"),
                    ),
                    ElevatedButton(onPressed: () => pickImage(), child: Text("pick Image")),
                    ElevatedButton(onPressed: () => uploadPic(), child: Text("send Image upload2")),
                    ElevatedButton(
                        onPressed: () {
                          downloadSched();
                        },
                        child: Text("get appointments")),
                    ElevatedButton(
                        onPressed: () {
                          sendFullAudit();
                        },
                        child: Text("send Full Audit")),
                    ElevatedButton(
                        onPressed: () {
                          getFullAudit();
                        },
                        child: Text("get Full Audit")),
                    ElevatedButton(
                        onPressed: () {
                          getAuditors();
                        },
                        child: Text("get Auditors")),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(builder: (context) => ListSchedulingPage()),
                    );
                  },
                  child: Text("Go to scheduling page")),
              Container(
                height: 800,
                width: 600,
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [Container(child: Text(result, style: ColorDefs.textBodyWhite20))]),
              ),
              RaisedButtonX(
                  colorx: Colors.red,
                  onPressedx: () async {
                    AlertDialog alert = AlertDialog(
                      elevation: 6.0,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'This will delete all data in the remote database.  Are you sure you want to do this?',
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text("YES"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            deleteEverything();
                          },
                        ),
                        TextButton(
                          child: Text("NO"),
                          onPressed: () {
                            Navigator.of(context).pop();
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
                  },
                  childx: Text("CAREFUL - DELETE REMOTE DATABASE - CAREFUL", style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> auditToSend = <String, dynamic>{
    "AgencyNumber": "A00091",
    "ProgramNumber": "PY00005",
    "ProgramType": 1,
    "Auditor": "charlieChaplin",
    "AuditType": 1,
    "StartTime": "2020-06-05T13:00:00.000Z",
    "DeviceId": "100bottlesOfBeerOnTheWall",
    "PantryFollowUp": null,
    "CongregateDetail": null,
    "PPCDetail": null,
    "PantryDetail": {
      "DateOfSiteVisit": "2020-05-29",
      "StartOfAudit": "13:00:00.000",
      "EndOfAudit": "14:00:00.000",
      "GCFDAuditorID": "jchang",
      "ProgramContact": "Emily",
      "PersonInterviewed": "Nicky",
      "ServiceArea": "60607",
      "GCFDEstablishedServiceArea": "true",
      "GCFDEstablishedServiceAreaComments": "",
      "PantryServesOutsideServiceArea": "true",
      "PantryServesOutsideServiceAreaComments": "",
      "HowManyGuestsTravel": "",
      "HowOftenGuestsReceiveFood": "true",
      "PantryAllowsFoodAtLeast30Days": "true",
      "PantryAllowsFoodAtLeast30DaysComments": "",
      "ReferralsRequired": "false",
      "ReferralsRequiredComments": "testing",
      "AppointmentsRequired": "",
      "AppointmentsRequiredComments": "",
      "DocumentationRequired": "",
      "DocumentationRequiredComments": "",
      "DocumentationDescription": "",
      "UnderRuralExemption": "true",
      "UnderRuralExemptionComments": "",
      "HasSoupKitchen": "",
      "HasSoupKitchenComments": "",
      "FoodProperlySeperatedAndTracked": "",
      "FoodProperlySeperatedAndTrackedComments": "",
      "OnFoodRescueAgencyEnabled": "",
      "OnFoodRescueAgencyEnabledComments": "",
      "FoodServiceSanitationManagerCerts": "",
      "RemoveField": "",
      "LastOrderDate": "",
      "NumberOfDeliveriesPerMonth": "",
      "OrderHasBeenPlacedInLastMonth": "",
      "OrderHasBeenPlacedInLastMonthComments": "",
      "IntakeSystemUsedInLastMonth": "",
      "IntakeSystemUsedInLastMonthComments": "",
      "AgencyLocatorAccurate": "",
      "EntranceClearlyMarked": "",
      "EntranceClearlyMarkedComments": "",
      "OperationHoursDaysPosted": "",
      "OperationHoursDaysPostedComments": "",
      "ServiceRequirementsPosted": "",
      "ServiceRequirementsPostedComments": "",
      "GCFDContactInfoPosted": "",
      "GCFDContactInfoPostedComments": "",
      "TypeOfOutreachUsed": "false",
      "TEFAPPostersAccessible": "",
      "TEFAPPostersAccessibleComments": "",
      "ActivitiesIndicatingFeesRequired": "",
      "ActivitiesIndicatingFeesRequiredComments": "",
      "OnlineIntakeUtilized": "",
      "OnlineIntakeUtilizedComments": "",
      "DHSSignatureDocsUsed": "",
      "DHSSignatureDocsUsedComments": "",
      "GuestSignsName": "",
      "GuestSignsNameComments": "",
      "AddressRecordedUponReceipt": "false",
      "AddressRecordedUponReceiptComments": "",
      "HouseholdSizeRecordedUponReceipt": "",
      "HouseholdSizeRecordedUponReceiptComments": "",
      "GuestSignsEvenForPrivateDonation": "",
      "GuestSignsEvenForPrivateDonationComments": "",
      "OriginalDHSSigDocsSubmitted": "",
      "OriginalDHSSigDocsSubmittedComments": "",
      "TEFAPManualAccessible": "",
      "TEFAPManualAccessibleComments": "",
      "ProxyFormsUsed": "",
      "ProxyFormsUsedComments": "",
      "ProxyFormsOriginalSignature": "",
      "ProxyFormsOriginalSignatureComments": "",
      "ProxySignedInPresenceOfPantryPersonnel": "",
      "ProxySignedInPresenceOfPantryPersonnelComments": "",
      "ProxyFormSignedAtTimeOfDistribution": "",
      "ProxyFormSignedAtTimeOfDistributionComments": "",
      "TANFCommoditiesDistributed": "",
      "TANFCommoditiesDistributedComments": "",
      "GuestsCompleteRequiredTANFInfo": "",
      "GuestsCompleteRequiredTANFInfoComments": "",
      "GuestsWithoutChildrenCompletingTANFInfo": "",
      "GuestsWithoutChildrenCompletingTANFInfoComments": "",
      "NumberOfTabletsBeingUsed": "",
      "NumberOfComputersBeingUsed": "",
      "GuestDisposition": "",
      "GuestsServedDuringVisit": "",
      "GuestServedEachMonth": "",
      "VolunteerDispotion": "",
      "NumberOfIntakeVolunteers": "",
      "NumberOfDistributionVolunteers": "",
      "HowDoesPantryRecruitVolunteers": "",
      "ActivitiesOtherThanTEFAPDisruping": "",
      "ActivitiesOtherThanTEFAPDisrupingComments": "Good",
      "DistributionActivitiesAreAppropriate": "",
      "DistributionActivitiesAreAppropriateComments": "",
      "DistributionStyle": "",
      "DistributionNotClientChoiceReason": "",
      "FloorsPalletsShelvesClean": "",
      "FloorsPalletsShelvesCleanComments": "",
      "StorageOrganized": "",
      "StorageOrganizedComments": "",
      "PestProofContainersUsed": "",
      "PestProofContainersUsedComments": "",
      "NonFoodItemsStoredSeparately": "",
      "NonFoodItemsStoredSeparatelyComments": "",
      "DryFoodRotatedFIFO": "",
      "DryFoodRotatedFIFOComments": "",
      "DryFoodSixInchesFromFloor": "",
      "DryFoodSixInchesFromFloorComments": "",
      "DryFoodKeptFromWalls": "",
      "DryFoodKeptFromWallsComments": "",
      "ProperTempForDryFood": "",
      "ProperTempForDryFoodComments": "",
      "DryFoodStoredSecurely": "",
      "DryFoodStoredSecurelyComments": "",
      "DryFoodClearlyMarked": "",
      "DryFoodClearlyMarkedComments": "",
      "StorageAreaOnlyForApprovedFood": "",
      "StorageAreaOnlyForApprovedFoodComments": "",
      "DryEquipmentWellMaintained": "",
      "DryEquipmentWellMaintainedComments": "",
      "AppropriateAmountOfFood": "",
      "AppropriateAmountOfFoodComments": "",
      "NumCasesOfDryFood": "",
      "NumCasesOfMeat": "",
      "NumCasesOfPerishableItems": "",
      "PantryHasOtherFoodToDistribute": "",
      "PantryHasOtherFoodToDistributeComments": "",
      "AreaOneComments": "",
      "AreaTwoComments": "",
      "AreaThreeComments": "",
      "AreaFourComments": "",
      "UnitsClean": "",
      "UnitsCleanComments": "",
      "UnitsDefrosted": "",
      "UnitsDefrostedComments": "",
      "UnitsOrganized": "",
      "UnitsOrganizedComments": "",
      "ColdFoodRotatedFIFO": "",
      "ColdFoodRotatedFIFOComments": "",
      "UnitsHaveThermometers": "",
      "UnitsHaveThermometersComments": "",
      "UnitsOnlyForApprovedPrograms": "",
      "UnitsOnlyForApprovedProgramsComments": "",
      "ColdFoodAppropriatelyLabeled": "",
      "ColdFoodAppropriatelyLabeledComments": "",
      "ColdFoodAppropriatelyStocked": "",
      "ColdFoodAppropriatelyStockedComments": "",
      "UnitsNumbered": "",
      "UnitsNumberedComments": "",
      "ColdEquipmentWellMaintained": "",
      "ColdEquipmentWellMaintainedComments": "",
      "RefrigeratedItemsCorrectTemp": "",
      "RefrigeratedItemsCorrectTempComments": "",
      "FrozenItemsCorrectTemp": "",
      "FrozenItemsCorrectTempComments": "",
      "ColdStorageUnitOneComments": "",
      "ColdStorageUnitOneTemp": "",
      "ColdStorageUnitTwoComments": "",
      "ColdStorageUnitTwoTemp": "",
      "ColdStorageUnitThreeComments": "",
      "ColdStorageUnitThreeTemp": "",
      "ColdStorageUnitFourComments": "",
      "ColdStorageUnitFourTemp": "",
      "ColdStorageUnitFiveComments": "",
      "ColdStorageUnitFiveTemp": "",
      "ColdStorageUnitSixComments": "",
      "ColdStorageUnitSixTemp": "",
      "ColdStorageUnitSevenComments": "",
      "ColdStorageUnitSevenTemp": "",
      "ColdStorageUnitEightComments": "",
      "ColdStorageUnitEightTemp": "",
      "ColdStorageUnitNineComments": "",
      "ColdStorageUnitNineTemp": "",
      "ColdStorageUnitTenComments": "",
      "ColdStorageUnitTenTemp": "",
      "WalkInFreezerCoolerComments": "",
      "USDATagNumberOne": "",
      "SerialNumberOne": "",
      "TypeOne": "",
      "USDATagNumberTwo": "",
      "SerialNumberTwo": "",
      "TypeTwo": "",
      "USDATagNumberThree": "",
      "SerialNumberThree": "",
      "TypeThree": "",
      "USDATagNumberFour": "",
      "SerialNumberFour": "",
      "TypeFour": "",
      "PlumbingComments": "",
      "SewageComments": "",
      "GarbageRefusalDisposalComments": "",
      "PestControlReportComments": "",
      "BuildingWellSealed": "",
      "BuildingWellSealedComments": "",
      "AppropriateLightingComments": "",
      "VentilationComments": "",
      "AccessToAllPertinentAreasComments": "",
      "PestControlCompany": "",
      "EvidenceOfPests": "",
      "EvidenceOfPestsComments": "",
      "DiscriminationComplaints": "",
      "DiscriminationComplaintsComments": "",
      "PantryKnowsResolutionDiscriminationComplaint": "",
      "PantryKnowsResolutionDiscriminationComplaintComments": "",
      "PantryHasFoodDepositoryContactInfoComments": "",
      "IssuesFromLastSiteVisit": "",
      "DistributionSiteStaffComments": "",
      "FoodDepositoryComments": "",
      "Donors": "",
      "DateTaxExemptionVerified": "",
      "ReVerifiedBy": "",
      "GCFDMonitor": "",
      "ReviewedBy": "",
      "FindingsFound": "",
      "CorrectiveActionPlanDueDate": "2020/6/30",
      "SiteRepresentativeSignature": "2020/6/6",
      "SiteVisitRequired": "false",
      "FollowUpItems": "",
    }
  };
}

// Field Name	Field Type	Nullable	Desc	Example
// AED	string(1)	No	"A: Create
// E: Edit (not use for now)
// D: Delete"

// Auditor	string	No	Users under AppAudit Groups

// AuditType	int	No
//	"1: Annual
// 2: Food Rescue
// 3: CEDA
// 4: Bi-Annual
// 5: Complaint
// 6: Follow Up
// 7: Grant"

// ProgramType	int	No	"1: Pantry
// 2: Congregate
// 3: Older Adults
// 4: Healthy Student Market"

// AgencyNumber	string	No

// ProgramNumber	string	No

// StartTime	Datetime	No	Start Date + Start Time

// "{
// 	""AgencyNumber"": ""A00091"",
// 	""ProgramNumber"": ""PY00005"",
// 	""ProgramType"": 1,
// 	""Auditor"": ""jchang"",
// 	""AuditType"": 1,
// 	""StartTime"": ""2020-06-05T13:00:00.000Z"",
// 	""DeviceId"": ""xxxyyyzzz"",
// 	PantryDetail:
// 	{
// 		DateOfSiteVisit:""2020-05-29"",
// 		StartOfAudit:""13:00:00.000"",
// 		EndOfAudit:""14:00:00.000"",
// 		GCFDAuditorID:""jchang"",
// 		ProgramContact:""Emily"",
// 		PersonInterviewed:""Nicky"",
// 		ServiceArea:""60607"",
// 		GCFDEstablishedServiceArea:""true"",
// 		GCFDEstablishedServiceAreaComments:"""",
// 		PantryServesOutsideServiceArea:""true"",
// 		PantryServesOutsideServiceAreaComments:"""",
// 		HowManyGuestsTravel:"""",
// 		HowOftenGuestsReceiveFood:""true"",
// 		PantryAllowsFoodAtLeast30Days:""true"",
// 		PantryAllowsFoodAtLeast30DaysComments:"""",
// 		ReferralsRequired:""false"",
// 		ReferralsRequiredComments:""testing"",
// 		AppointmentsRequired:"""",
// 		AppointmentsRequiredComments:"""",
// 		DocumentationRequired:"""",
// 		DocumentationRequiredComments:"""",
// 		DocumentationDescription:"""",
// 		UnderRuralExemption:""true"",
// 		UnderRuralExemptionComments:"""",
// 		HasSoupKitchen:"""",
// 		HasSoupKitchenComments:"""",
// 		FoodProperlySeperatedAndTracked:"""",
// 		FoodProperlySeperatedAndTrackedComments:"""",
// 		OnFoodRescueAgencyEnabled:"""",
// 		OnFoodRescueAgencyEnabledComments:"""",
// 		FoodServiceSanitationManagerCerts:"""",
// 		RemoveField:"""",
// 		LastOrderDate:"""",
// 		NumberOfDeliveriesPerMonth:"""",
// 		OrderHasBeenPlacedInLastMonth:"""",
// 		OrderHasBeenPlacedInLastMonthComments:"""",
// 		IntakeSystemUsedInLastMonth:"""",
// 		IntakeSystemUsedInLastMonthComments:"""",
// 		AgencyLocatorAccurate:"""",
// 		EntranceClearlyMarked:"""",
// 		EntranceClearlyMarkedComments:"""",
// 		OperationHoursDaysPosted:"""",
// 		OperationHoursDaysPostedComments:"""",
// 		ServiceRequirementsPosted:"""",
// 		ServiceRequirementsPostedComments:"""",
// 		GCFDContactInfoPosted:"""",
// 		GCFDContactInfoPostedComments:"""",
// 		TypeOfOutreachUsed:""false"",
// 		TEFAPPostersAccessible:"""",
// 		TEFAPPostersAccessibleComments:"""",
// 		ActivitiesIndicatingFeesRequired:"""",
// 		ActivitiesIndicatingFeesRequiredComments:"""",
// 		OnlineIntakeUtilized:"""",
// 		OnlineIntakeUtilizedComments:"""",
// 		DHSSignatureDocsUsed:"""",
// 		DHSSignatureDocsUsedComments:"""",
// 		GuestSignsName:"""",
// 		GuestSignsNameComments:"""",
// 		AddressRecordedUponReceipt:""false"",
// 		AddressRecordedUponReceiptComments:"""",
// 		HouseholdSizeRecordedUponReceipt:"""",
// 		HouseholdSizeRecordedUponReceiptComments:"""",
// 		GuestSignsEvenForPrivateDonation:"""",
// 		GuestSignsEvenForPrivateDonationComments:"""",
// 		OriginalDHSSigDocsSubmitted:"""",
// 		OriginalDHSSigDocsSubmittedComments:"""",
// 		TEFAPManualAccessible:"""",
// 		TEFAPManualAccessibleComments:"""",
// 		ProxyFormsUsed:"""",
// 		ProxyFormsUsedComments:"""",
// 		ProxyFormsOriginalSignature:"""",
// 		ProxyFormsOriginalSignatureComments:"""",
// 		ProxySignedInPresenceOfPantryPersonnel:"""",
// 		ProxySignedInPresenceOfPantryPersonnelComments:"""",
// 		ProxyFormSignedAtTimeOfDistribution:"""",
// 		ProxyFormSignedAtTimeOfDistributionComments:"""",
// 		TANFCommoditiesDistributed:"""",
// 		TANFCommoditiesDistributedComments:"""",
// 		GuestsCompleteRequiredTANFInfo:"""",
// 		GuestsCompleteRequiredTANFInfoComments:"""",
// 		GuestsWithoutChildrenCompletingTANFInfo:"""",
// 		GuestsWithoutChildrenCompletingTANFInfoComments:"""",
// 		NumberOfTabletsBeingUsed:"""",
// 		NumberOfComputersBeingUsed:"""",
// 		GuestDisposition:"""",
// 		GuestsServedDuringVisit:"""",
// 		GuestServedEachMonth:"""",
// 		VolunteerDispotion:"""",
// 		NumberOfIntakeVolunteers:"""",
// 		NumberOfDistributionVolunteers:"""",
// 		HowDoesPantryRecruitVolunteers:"""",
// 		ActivitiesOtherThanTEFAPDisruping:"""",
// 		ActivitiesOtherThanTEFAPDisrupingComments:""Good"",
// 		DistributionActivitiesAreAppropriate:"""",
// 		DistributionActivitiesAreAppropriateComments:"""",
// 		DistributionStyle:"""",
// 		DistributionNotClientChoiceReason:"""",
// 		FloorsPalletsShelvesClean:"""",
// 		FloorsPalletsShelvesCleanComments:"""",
// 		StorageOrganized:"""",
// 		StorageOrganizedComments:"""",
// 		PestProofContainersUsed:"""",
// 		PestProofContainersUsedComments:"""",
// 		NonFoodItemsStoredSeparately:"""",
// 		NonFoodItemsStoredSeparatelyComments:"""",
// 		DryFoodRotatedFIFO:"""",
// 		DryFoodRotatedFIFOComments:"""",
// 		DryFoodSixInchesFromFloor:"""",
// 		DryFoodSixInchesFromFloorComments:"""",
// 		DryFoodKeptFromWalls:"""",
// 		DryFoodKeptFromWallsComments:"""",
// 		ProperTempForDryFood:"""",
// 		ProperTempForDryFoodComments:"""",
// 		DryFoodStoredSecurely:"""",
// 		DryFoodStoredSecurelyComments:"""",
// 		DryFoodClearlyMarked:"""",
// 		DryFoodClearlyMarkedComments:"""",
// 		StorageAreaOnlyForApprovedFood:"""",
// 		StorageAreaOnlyForApprovedFoodComments:"""",
// 		DryEquipmentWellMaintained:"""",
// 		DryEquipmentWellMaintainedComments:"""",
// 		AppropriateAmountOfFood:"""",
// 		AppropriateAmountOfFoodComments:"""",
// 		NumCasesOfDryFood:"""",
// 		NumCasesOfMeat:"""",
// 		NumCasesOfPerishableItems:"""",
// 		PantryHasOtherFoodToDistribute:"""",
// 		PantryHasOtherFoodToDistributeComments:"""",
// 		AreaOneComments:"""",
// 		AreaTwoComments:"""",
// 		AreaThreeComments:"""",
// 		AreaFourComments:"""",
// 		UnitsClean:"""",
// 		UnitsCleanComments:"""",
// 		UnitsDefrosted:"""",
// 		UnitsDefrostedComments:"""",
// 		UnitsOrganized:"""",
// 		UnitsOrganizedComments:"""",
// 		ColdFoodRotatedFIFO:"""",
// 		ColdFoodRotatedFIFOComments:"""",
// 		UnitsHaveThermometers:"""",
// 		UnitsHaveThermometersComments:"""",
// 		UnitsOnlyForApprovedPrograms:"""",
// 		UnitsOnlyForApprovedProgramsComments:"""",
// 		ColdFoodAppropriatelyLabeled:"""",
// 		ColdFoodAppropriatelyLabeledComments:"""",
// 		ColdFoodAppropriatelyStocked:"""",
// 		ColdFoodAppropriatelyStockedComments:"""",
// 		UnitsNumbered:"""",
// 		UnitsNumberedComments:"""",
// 		ColdEquipmentWellMaintained:"""",
// 		ColdEquipmentWellMaintainedComments:"""",
// 		RefrigeratedItemsCorrectTemp:"""",
// 		RefrigeratedItemsCorrectTempComments:"""",
// 		FrozenItemsCorrectTemp:"""",
// 		FrozenItemsCorrectTempComments:"""",
// 		ColdStorageUnitOneComments:"""",
// 		ColdStorageUnitOneTemp:"""",
// 		ColdStorageUnitTwoComments:"""",
// 		ColdStorageUnitTwoTemp:"""",
// 		ColdStorageUnitThreeComments:"""",
// 		ColdStorageUnitThreeTemp:"""",
// 		ColdStorageUnitFourComments:"""",
// 		ColdStorageUnitFourTemp:"""",
// 		ColdStorageUnitFiveComments:"""",
// 		ColdStorageUnitFiveTemp:"""",
// 		ColdStorageUnitSixComments:"""",
// 		ColdStorageUnitSixTemp:"""",
// 		ColdStorageUnitSevenComments:"""",
// 		ColdStorageUnitSevenTemp:"""",
// 		ColdStorageUnitEightComments:"""",
// 		ColdStorageUnitEightTemp:"""",
// 		ColdStorageUnitNineComments:"""",
// 		ColdStorageUnitNineTemp:"""",
// 		ColdStorageUnitTenComments:"""",
// 		ColdStorageUnitTenTemp:"""",
// 		WalkInFreezerCoolerComments:"""",
// 		USDATagNumberOne:"""",
// 		SerialNumberOne:"""",
// 		TypeOne:"""",
// 		USDATagNumberTwo:"""",
// 		SerialNumberTwo:"""",
// 		TypeTwo:"""",
// 		USDATagNumberThree:"""",
// 		SerialNumberThree:"""",
// 		TypeThree:"""",
// 		USDATagNumberFour:"""",
// 		SerialNumberFour:"""",
// 		TypeFour:"""",
// 		PlumbingComments:"""",
// 		SewageComments:"""",
// 		GarbageRefusalDisposalComments:"""",
// 		PestControlReportComments:"""",
// 		BuildingWellSealed:"""",
// 		BuildingWellSealedComments:"""",
// 		AppropriateLightingComments:"""",
// 		VentilationComments:"""",
// 		AccessToAllPertinentAreasComments:"""",
// 		PestControlCompany:"""",
// 		EvidenceOfPests:"""",
// 		EvidenceOfPestsComments:"""",
// 		DiscriminationComplaints:"""",
// 		DiscriminationComplaintsComments:"""",
// 		PantryKnowsResolutionDiscriminationComplaint:"""",
// 		PantryKnowsResolutionDiscriminationComplaintComments:"""",
// 		PantryHasFoodDepositoryContactInfoComments:"""",
// 		IssuesFromLastSiteVisit:"""",
// 		DistributionSiteStaffComments:"""",
// 		FoodDepositoryComments:"""",
// 		Donors:"""",
// 		DateTaxExemptionVerified:"""",
// 		ReVerifiedBy:"""",
// 		GCFDMonitor:"""",
// 		ReviewedBy:"""",
// 		FindingsFound:"""",
// 		CorrectiveActionPlanDueDate:""2020/6/30"",
// 		SiteRepresentativeSignature:""2020/6/6"",
// 		SiteVisitRequired:""false"",
// 		FollowUpItems:"""",

// 	},

// }
// "

// DeviceId	string(500)	Yes

// Field Name	Field Type
// IsSucc	bool
// ErrMsg	string
