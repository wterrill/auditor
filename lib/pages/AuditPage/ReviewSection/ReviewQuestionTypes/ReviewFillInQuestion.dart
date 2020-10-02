import 'package:auditor/Definitions/AuditClasses/Question.dart';

import 'package:auditor/Definitions/colorDefs.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ReviewCommentSection.dart';

class ReviewFillInQuestion extends StatefulWidget {
  final int index;
  final List<Question> questions;
  final AutoSizeGroup questionAutoGroup;
  ReviewFillInQuestion(
      {Key key, this.index, this.questions, this.questionAutoGroup})
      : super(key: key);

  @override
  _ReviewFillInQuestionState createState() => _ReviewFillInQuestionState();
}

class _ReviewFillInQuestionState extends State<ReviewFillInQuestion> {
  @override
  void initState() {
    super.initState();
    // widget.questions[widget.index].textBoxRollOut = true;
    response = getResponse();
  }

  String response;

  String getResponse() {
    String response = widget.questions[widget.index].userResponse.toString();
    if (widget.questions[widget.index].typeOfQuestion.toLowerCase() == "date" &&
        widget.questions[widget.index].userResponse != null) {
      DateTime dateTime =
          DateTime.parse(widget.questions[widget.index].userResponse as String);
      if (dateTime == null) {
        response = "";
      } else {
        response = DateFormat('EEE, MMM-dd-yyyy').format(dateTime);
      }
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    List<Question> questions = widget.questions;
    int index = widget.index;

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
                GestureDetector(
                  onTap: () {
                    if (questions[index].userResponse != null) {
                      questions[index].textBoxRollOut =
                          !questions[index].textBoxRollOut;
                      print(questions[index].textBoxRollOut);
                      setState(() {});
                    }
                  },
                  child: Container(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: (response.length > 20)
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        if (response.length <= 20) Text(getResponse()),
                        if (response.length > 20) Text(" "),
                        if (response.length > 20)
                          Icon(Icons.chat_bubble,
                              color: questions[index].userResponse == null
                                  ? ColorDefs.colorChatNeutral
                                  : ColorDefs.colorChatSelected),
                      ],
                    ),
                  ),
                )
              ],
            ),
            if (response.length > 30)
              ReviewCommentSection(
                  index: index,
                  questions: questions,
                  key: UniqueKey(),
                  numKeyboard: false,
                  mandatory: true,
                  actionItem: false)
          ],
        ),
      ),
    );
  }
}
