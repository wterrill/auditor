import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ReviewCommentSection.dart';

// import 'ReviewQuestionTypes/ReviewCommentSection.dart';

class FollowupCitationsSections extends StatefulWidget {
  FollowupCitationsSections({Key key, @required this.followup})
      : super(key: key);
  // final Audit activeAudit;

  @override
  _FollowupCitationsSectionsState createState() =>
      _FollowupCitationsSectionsState();
  final bool followup;
}

class _FollowupCitationsSectionsState extends State<FollowupCitationsSections> {
  List<Question> citations;

  Widget build(BuildContext context) {
    if (widget.followup == true) {
      citations = Provider.of<AuditData>(context).previousCitations;
    } else {
      citations = Provider.of<AuditData>(context).citations;
    }
    return ListView.builder(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemCount: citations.length,
      itemBuilder: (context, index) {
        return Container(
          color: index.isEven
              ? ColorDefs.colorAlternateDark
              : ColorDefs.colorAlternateLight,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        citations[index].text,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 190,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: ColorDefs.colorButton1Background,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(citations[index].fromSectionName,
                                    // wrapWords: false,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: ColorDefs.textBodyWhite15),
                              ),
                              height: 50,
                              width: 100),
                        ),
                        Container(
                            // height: double.infinity,
                            // color: ColorDefs.colorButtonNeutral,
                            child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Provider.of<AuditData>(context, listen: false)
                                      .toggleFlag(index);
                                });
                              },
                              child: Icon(Icons.flag,
                                  color: citations[index].unflagged
                                      ? ColorDefs.colorChatNeutral
                                      : Colors.red)),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AuditData>(context, listen: false)
                                  .citations[index]
                                  .textBoxRollOut = !Provider.of<AuditData>(
                                      context,
                                      listen: false)
                                  .citations[index]
                                  .textBoxRollOut;
                              print(citations[index].textBoxRollOut);
                              setState(() {});
                            },
                            child: Icon(Icons.chat_bubble,
                                color: citations[index].optionalComment == null
                                    ? ColorDefs.colorChatNeutral
                                    : ColorDefs.colorChatSelected),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                padding: citations[index].textBoxRollOut
                    // (Provider.of<AuditData>(context, listen: false)
                    //         .citations[index]
                    //         .textBoxRollOut)
                    ? EdgeInsets.all(8.0)
                    : null,
                color: index.isEven
                    ? ColorDefs.colorAlternateDark
                    : ColorDefs.colorAlternateLight,
                child: ReviewCommentSection(
                    index: index,
                    questions: citations,
                    key: UniqueKey(),
                    numKeyboard: false,
                    mandatory: false,
                    actionItem: false),
              )
            ],
          ),
        );
      },
    );
  }
}
