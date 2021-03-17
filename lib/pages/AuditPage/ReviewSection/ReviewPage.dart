import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';

import 'ExpandableReview.dart';

class ReviewPage extends StatelessWidget {
  final Audit activeAudit;
  const ReviewPage({Key key, this.activeAudit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Question> citations = Provider.of<AuditData>(context).citations;
    return Expanded(
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text("Audit Summary", style: ColorDefs.textBodyBlack20, textAlign: TextAlign.center),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: activeAudit.sections.length - 4, // this should be 4 after "*Developer*" is taken away (5 with)
              itemBuilder: (context, i) {
                return Container(
                  decoration: BoxDecoration(
                      color: ColorDefs.colorAlternateLight,
                      border: Border.all(color: ColorDefs.colorAlternateDark, width: 3)),
                  child: ExpansionTile(
                    trailing: Icon(Icons.arrow_drop_down),
                    backgroundColor: ColorDefs.colorChatSelected,
                    title: Text(activeAudit.sections[i + 1].name, style: ColorDefs.textBodyBlack20),
                    children: <Widget>[
                      ExpandableReviewContent(sectionData: activeAudit.sections[i + 1]),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(height: 20),

          // Text(
          //   "Generated Citations",
          //   style: ColorDefs.textBodyBlack20,
          //   textAlign: TextAlign.center,
          // ),
          // Container(
          //     height: MediaQuery.of(context).size.height / 3,
          //     child: FollowupCitationsSections(
          //         // activeAudit: activeAudit,
          //         )),
          // Container(height: 300),
          // Container(
          //   height: 800,
          // )
        ],
      ),
    );
  }
}
