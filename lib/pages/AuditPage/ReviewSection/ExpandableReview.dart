import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:flutter/material.dart';

import 'ReviewQuestionTypes/ReviewFillInQuestion.dart';
import 'ReviewQuestionTypes/ReviewIssuesNoIssuesQuestion.dart';
import 'ReviewQuestionTypes/ReviewYesNoQuestion.dart';

class ExpandableReviewContent extends StatefulWidget {
  const ExpandableReviewContent({Key key, this.sectionData}) : super(key: key);
  final Section sectionData;

  @override
  _ExpandableReviewContentState createState() =>
      _ExpandableReviewContentState();
}

class _ExpandableReviewContentState extends State<ExpandableReviewContent> {
  @override
  Widget build(BuildContext context) {
    List<Question> questions = widget.sectionData.questions;

    // bool happyPath(Question question) {
    //   bool isHappy = true;
    //   if (question.happyPathResponse != null) {
    //     if (!question.happyPathResponse.contains(question.userResponse)) {
    //       isHappy = false;
    //     }
    //   }
    //   return isHappy;
    // }

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.sectionData.questions.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (questions[index]?.userResponse != null &&
                  (questions[index].typeOfQuestion == "yesNo" ||
                      questions[index].typeOfQuestion == "yesNoNa"))
                ReviewYesNoQuestion(
                  index: index,
                  questions: questions,
                ),
              if (questions[index]?.userResponse != null &&
                  (questions[index].typeOfQuestion == "issuesNoIssues" ||
                      questions[index].typeOfQuestion == "issuesNoIssues"))
                ReviewIssuesNoIssuesQuestion(
                  index: index,
                  questions: questions,
                ),
              if (questions[index]?.userResponse != null &&
                  (questions[index].typeOfQuestion == "fillIn" ||
                      questions[index].typeOfQuestion == "fillInNum" ||
                      questions[index].typeOfQuestion == "date"))
                if (questions[index]?.userResponse != null)
                  ReviewFillInQuestion(
                    index: index,
                    questions: questions,
                  ),
            ],
          );
        });
  }
}
