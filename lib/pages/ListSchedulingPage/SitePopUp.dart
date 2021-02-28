import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LookAhead.dart';

class SitePopUp extends StatefulWidget {
  const SitePopUp({Key key, @required this.programNumber, @required this.singleSite}) : super(key: key);
  final String programNumber;
  final bool singleSite;

  @override
  _SitePopUpState createState() => _SitePopUpState();
}

class _SitePopUpState extends State<SitePopUp> {
  Site selectedSite;
  @override
  Widget build(BuildContext context) {
    SiteList siteList = Provider.of<SiteData>(context, listen: false).siteList;
    if (widget.programNumber != null) {
      selectedSite = siteList.getSiteFromProgramNumber(programNumber: widget.programNumber);
    }
    if (widget.programNumber != null) {
      selectedSite = siteList.getSiteFromProgramNumber(programNumber: widget.programNumber);
    }
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
      ),
      child: Container(
        decoration:
            BoxDecoration(color: ColorDefs.colorTopHeader, borderRadius: BorderRadius.all(Radius.circular(25.0))),
        width: 650,
        height: (selectedSite == null) ? 200 : 700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  "Agency Directory",
                  style: ColorDefs.textGreen40,
                )),
            if (!widget.singleSite)
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 24, 25.0, 25),
                child: LookAhead(
                    disable: false,
                    // setValue: selectedSiteName,
                    // programNumber: (widget.followup) ? selectedProgramNumber : null,
                    lookAheadCallback: (List<String> val) {
                      String selectedSiteName = val[0];
                      String selectedProgramNumber = val[1];
                      String selectedAgencyNumber = val[2];

                      // Site selectedSite =
                      if (selectedAgencyNumber != null) {
                        selectedAgencyNumber = siteList.agencyNumberFromAgencyName(selectedSiteName);
                      }
                      print(selectedAgencyNumber);
                      setState(() {
                        selectedSite = siteList.getSiteFromProgramNumber(programNumber: selectedProgramNumber);
                        // selectedSite = siteList.getSiteFromAgencyNumber(agencyNumber: selectedAgencyNumber);
                      });
                    }),
              ),
            if (selectedSite != null)
              Expanded(
                child: Scrollbar(
                  thickness: 4.0,
                  child: SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 25.0),
                                child: Text(
                                  selectedSite?.programDisplayName,
                                  style: ColorDefs.textGreen30,
                                )),
                            if (selectedSite.address1 != null)
                              Text(
                                selectedSite?.address1?.replaceAll("\\n", ""),
                                style: ColorDefs.textBodyBlack20,
                              ),
                            if (selectedSite.address2 != null && selectedSite.address2 != "")
                              Text(
                                selectedSite?.address2,
                                style: ColorDefs.textBodyBlack20,
                              ),
                            Row(
                              children: [
                                if (selectedSite.city != null)
                                  Text(
                                    selectedSite?.city ?? "" + ", ",
                                    style: ColorDefs.textBodyBlack20,
                                  ),
                                if (selectedSite.state != null)
                                  Text(
                                    selectedSite?.state ?? "" + " ",
                                    style: ColorDefs.textBodyBlack20,
                                  ),
                                if (selectedSite.zip != null)
                                  Text(
                                    selectedSite?.zip ?? "" + ", ",
                                    style: ColorDefs.textBodyBlack20,
                                  ),
                              ],
                            ),
                            Text(""),
                            if (selectedSite.contact != null)
                              Text(
                                selectedSite?.contact,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            if (selectedSite.contactEmail != null)
                              Text(
                                selectedSite?.contactEmail,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                              ),
                            Text(""),
                            if (!widget.singleSite)
                              TextButton(
                                style: ButtonStyle(
                                  // foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                  //   // text color
                                  //   (Set<MaterialState> states) =>
                                  //       states.contains(MaterialState.disabled) ? Colors.white : Colors.white,
                                  // ),
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    // background color    this is color:
                                    (Set<MaterialState> states) => states.contains(MaterialState.disabled)
                                        ? ColorDefs.colorTopHeader
                                        : ColorDefs.colorTopHeader,
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: BorderSide(color: ColorDefs.colorLogoLightGreen, width: 3.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Dialogs.showScheduledAudit(context: context, siteFromLookupScreen: selectedSite);
                                  selectedSite = null;
                                },
                                child: Text("Schedule Audit", style: ColorDefs.textBodyBlack20),
                              ),
                            // FlatButton(
                            //   color: ColorDefs.colorTopHeader,
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(25.0),
                            //     side: BorderSide(color: ColorDefs.colorLogoLightGreen, width: 3.0),
                            //   ),
                            //   onPressed: () {
                            //     Navigator.of(context).pop();
                            //     Dialogs.showScheduledAudit(context: context, siteFromLookupScreen: selectedSite);
                            //     selectedSite = null;
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0),
                            //     child: Text("Schedule Audit", style: ColorDefs.textBodyBlack20),
                            //   ),
                            // ),
                            Container(height: 10),
                            if (selectedSite.operateHours != null)
                              Text("Hours of Operation:", style: ColorDefs.textBodyBlack30),
                            Container(height: 10),
                            if (selectedSite.operateHours != null)
                              Text(
                                selectedSite?.operateHours
                                        ?.replaceAll("\\n", "\n\n")
                                        ?.replaceAll("||", "   ")
                                        ?.replaceAll("|", "   ") ??
                                    "None Defined",
                                style: ColorDefs.textBodyBlack20,
                              ),
                            Container(height: 60)
                          ],
                        )),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
