import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoringPopUp extends StatefulWidget {
  const ScoringPopUp({
    Key key,
    @required this.audit,
  }) : super(key: key);
  final Audit audit;

  @override
  _ScoringPopUpState createState() => _ScoringPopUpState();
}

class _ScoringPopUpState extends State<ScoringPopUp> {
  @override
  Site selectedSite;
  @override
  Widget build(BuildContext context) {
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
                  "Scoring Details",
                  style: ColorDefs.textGreen40,
                )),
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
                            Text(
                              "Details of scoring here",
                              style: ColorDefs.textBodyBlack30,
                            )
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
