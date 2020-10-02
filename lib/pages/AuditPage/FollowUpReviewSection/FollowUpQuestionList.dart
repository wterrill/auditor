import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FollowUpQuestionTypes/FollowUpDropDownQuestion.dart';
import 'FollowUpQuestionTypes/FollowUpIssuesNoIssuesQuestion.dart';
import 'FollowUpQuestionTypes/FollowUpYesNoNaQuestion.dart';
import 'FollowUpQuestionTypes/FollowUpYesNoQuestion.dart';

// import 'ReviewQuestionTypes/ReviewCommentSection.dart';

class FollowupQuestionList extends StatefulWidget {
  FollowupQuestionList({Key key}) : super(key: key);
  // final Audit activeAudit;

  @override
  _FollowupQuestionListState createState() => _FollowupQuestionListState();
  // final bool followup;
}

class _FollowupQuestionListState extends State<FollowupQuestionList> {
  List<Question> citations;

  Widget build(BuildContext context) {
    citations = Provider.of<AuditData>(context).previousCitations;
    return ListView.builder(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemCount: citations.length,
      itemBuilder: (context, index) {
        return Container(
            color: index.isEven
                ? ColorDefs.colorAlternateDark
                : ColorDefs.colorAlternateLight,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  if (citations[index].typeOfQuestion == "yesNo")
                    FollowUpYesNoQuestion(
                      index: index,
                      citations: citations,
                    ),
                  if (citations[index].typeOfQuestion == "issuesNoIssues")
                    FollowUpIssuesNoIssuesQuestion(
                      index: index,
                      citations: citations,
                    ),
                  if (citations[index].typeOfQuestion == "dropDown")
                    FollowUpDropDownQuestion(
                      index: index,
                      citations: citations,
                      // questionAutoGroup: questionAutoGroup
                    ),
                  if (citations[index].typeOfQuestion == "yesNoNa")
                    FollowUpYesNoNaQuestion(
                      index: index,
                      citations: citations,
                      // questionAutoGroup: questionAutoGroup,
                    ),
                ])));
      },
    );
  }
}
