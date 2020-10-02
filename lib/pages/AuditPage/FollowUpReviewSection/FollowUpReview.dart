import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';

import 'FollowUpQuestionList.dart';
import 'FollowupCitationsSections.dart';

class FollowUpReviewPage extends StatelessWidget {
  final Audit activeAudit;
  const FollowUpReviewPage({Key key, this.activeAudit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Question> citations = Provider.of<AuditData>(context).citations;
    return Expanded(
      child: ListView(
        children: [
          Container(
            height: 70,
            color: ColorDefs.colorAudit1,
            width: double.infinity,
            child: Center(
              child: Text(
                "Current Citations",
                style: ColorDefs.textBodyBlack30,
              ),
            ),
          ),
          Container(
            height: 350,
            child: FollowupCitationsSections(followup: false),
          ),
          Container(
            height: 70,
            width: double.infinity,
            color: ColorDefs.colorAudit2,
            child: Center(
              child: Text(
                "Cited Questions",
                style: ColorDefs.textBodyBlack30,
              ),
            ),
          ),
          Container(
            height: 350,
            // flex: 1,
            child: FollowupQuestionList(),
          ),
          Container(
            height: 200,
          )
        ],
      ),
    );

    // return Expanded(
    //   child: Column(
    //     children: [
    //       Container(
    //         color: ColorDefs.colorAudit1,
    //         width: double.infinity,
    //         child: Center(
    //           child: Text(
    //             "Current Citations",
    //             style: ColorDefs.textBodyBlack30,
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         child: FollowupCitationsSections(followup: false),
    //       ),
    //       Container(
    //         width: double.infinity,
    //         color: ColorDefs.colorAudit2,
    //         child: Center(
    //           child: Text(
    //             "Cited Questions",
    //             style: ColorDefs.textBodyBlack30,
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         flex: 1,
    //         child: FollowupQuestionList(),
    //       ),
    //     ],
    //   ),
    // );
  }
}
