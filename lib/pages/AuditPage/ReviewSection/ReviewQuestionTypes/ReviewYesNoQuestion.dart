import 'package:auditor/Definitions/AuditClasses/Question.dart';

import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';

import 'ReviewCommentSection.dart';

class ReviewYesNoQuestion extends StatefulWidget {
  final int index;
  final List<Question> questions;
  // final AutoSizeGroup questionAutoGroup;
  ReviewYesNoQuestion({
    Key key,
    this.index,
    this.questions,
    // this.questionAutoGroup,
  }) : super(key: key);

  @override
  _ReviewYesNoQuestionState createState() => _ReviewYesNoQuestionState();
}

class _ReviewYesNoQuestionState extends State<ReviewYesNoQuestion> {
  @override
  Widget build(BuildContext context) {
    bool happyPath(Question question) {
      bool isHappy = true;
      if (question.happyPathResponse != null) {
        if (!question.happyPathResponse.contains(question.userResponse)) {
          isHappy = false;
        }
      }
      return isHappy;
    }

    int index = widget.index;
    List<Question> questions = widget.questions;
    return Container(
      color: index.isEven
          ? ColorDefs.colorAlternateDark
          : ColorDefs.colorAlternateLight,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      questions[index].text,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                Container(
                  height: 35,
                  width: 110,
                  child: Row(
                    children: [
                      Container(
                          height: double.infinity,
                          color: ColorDefs.colorButtonNeutral,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: happyPath(questions[index])
                                ? Icon(Icons.done, color: Colors.green)
                                : Icon(Icons.close, color: Colors.red),
                          )),
                      if (questions[index].userResponse != null &&
                          questions[index].typeOfQuestion.toLowerCase() !=
                              "date")
                        Expanded(
                            child: Center(
                                child: Text(
                                    questions[index].userResponse.toString()))),

                      // if (questions[index].typeOfQuestion.toLowerCase() == "date" &&
                      //     questions[index].userResponse != null) {
                      //   DateTime dateTime = DateTime.parse(questions[index].userResponse as String);
                      //   if (dateTime == null) {
                      //     dateString = "";
                      //   } else {
                      //     dateString = DateFormat('EEE, MMM-dd-yyyy').format(dateTime);
                      //   }
                      // }

                      // if (questions[index].typeOfQuestion.toLowerCase() ==
                      //         "date" &&
                      //     dateString != null)
                      //   Text(dateString),

                      GestureDetector(
                        onTap: () {
                          if (questions[index].optionalComment != null) {
                            questions[index].textBoxRollOut =
                                !questions[index].textBoxRollOut;
                            print(questions[index].textBoxRollOut);
                            setState(() {});
                          }
                        },
                        child: Icon(Icons.chat_bubble,
                            color: questions[index].optionalComment == null
                                ? ColorDefs.colorChatNeutral
                                : ColorDefs.colorChatSelected),
                      )
                    ],
                  ),
                )
              ],
            ),
            ReviewCommentSection(
                index: index,
                questions: questions,
                key: UniqueKey(),
                numKeyboard: false,
                mandatory: false,
                actionItem: false)
          ],
        ),
        // leading: new Text(question.userResponse),
      ),
    );
  }
}
