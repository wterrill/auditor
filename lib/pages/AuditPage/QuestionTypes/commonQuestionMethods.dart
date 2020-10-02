import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';

Color buttonColorPicker(Question questionData, String buttonText) {
  Color finalButtonColor;
  if (((questionData.userResponse == null || questionData.userResponse != buttonText) &&
          (questionData.questionMap['type'] != "fillInNum" && questionData.questionMap['type'] != "date")) ||
      (questionData.questionMap['type'] == "fillInNum" && questionData.userResponse == null)) {
    finalButtonColor = ColorDefs.colorButtonNeutral;
  } else if (questionData.userResponse == buttonText && buttonText == "Yes" ||
      questionData.userResponse == buttonText && buttonText == "No Issues") {
    finalButtonColor = ColorDefs.colorButtonYes;
  } else if (questionData.userResponse == buttonText && buttonText == "No" ||
      questionData.userResponse == buttonText && buttonText == "Issues") {
    finalButtonColor = ColorDefs.colorButtonNo;
  } else if (questionData.userResponse == buttonText && buttonText == 'N/A') {
    finalButtonColor = ColorDefs.colorChatNeutral;
  } else if (questionData.userResponse == "0" && buttonText == 'N/A') {
    finalButtonColor = ColorDefs.colorChatNeutral;
  } else if (questionData.questionMap['type'] == "date" &&
      buttonText == "N/A" &&
      questionData.userResponse != "1972-06-05 00:00:00.000") {
    finalButtonColor = ColorDefs.colorButtonNeutral;
  } else if (questionData.userResponse == "1972-06-05 00:00:00.000" && buttonText == 'N/A') {
    finalButtonColor = ColorDefs.colorChatNeutral;
  }
  return finalButtonColor;
}

String setQuestionValue(String currentValue, String buttonText) {
  bool isNotSameAsText = currentValue != buttonText;
  bool isSameAsText = currentValue == buttonText;

  if (isNotSameAsText) {
    currentValue = buttonText;
  } else if (isSameAsText) {
    currentValue = null;
  } else {
    currentValue ??= buttonText;
  }
  return currentValue;
}

Status checkSectionDone(Section activeSection) {
  bool done = true;
  int numComplete = 0;
  Status result = Status.available;
  int numQuestions = activeSection.questions.length;

  for (Question question in activeSection.questions) {
    if ((question.userResponse == null && question.typeOfQuestion.toLowerCase() != "display") ||
        question.userResponse == "Select") {
      done = false;
    } else {
      numComplete += 1;
    }
  }

  if (!done && numComplete > 0) result = Status.inProgress;
  if (done) result = Status.completed;
  if ((numQuestions - numComplete) < 4) {
    highlightQuestions(activeSection);
  }

  return result;
}

void highlightQuestions(Section activeSection) {
  for (Question question in activeSection.questions) {
    if (question.userResponse == null && question.typeOfQuestion.toLowerCase() != "display") {
      question.highlight = true;
    } else {
      question.highlight = false;
    }
  }
}
