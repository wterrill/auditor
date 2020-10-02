import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ReviewQuestionTypes/ActionItemsCommentSection.dart';

class FollowupActionItems2 extends StatefulWidget {
  FollowupActionItems2({Key key}) : super(key: key);
  // final Audit activeAudit;

  @override
  _FollowupActionItems2State createState() => _FollowupActionItems2State();
}

class _FollowupActionItems2State extends State<FollowupActionItems2> {
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    List<Question> citations = Provider.of<AuditData>(context).citations;
    return Container(
        // height: 100,
        child: ListView.builder(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemCount: citations.length,
      itemBuilder: (context, index) {
        return Container(
          color: index.isEven ? ColorDefs.colorAlternateDark : ColorDefs.colorAlternateLight,
          child: Container(
            child: Column(
              children: [
                ActionItemsCommentSection(
                    index: index,
                    questions: citations,
                    key: UniqueKey(),
                    numKeyboard: false,
                    mandatory: false,
                    actionItem: true),
              ],
            ),
            // leading: new Text(question.userResponse),
          ),
        );
      },
    ));
  }
}
