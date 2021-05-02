// import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
// import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
// import 'package:auditor/pages/AuditPage/QuestionTypes/commonQuestionMethods.dart';
// import 'package:auditor/providers/AuditData.dart';
// import 'package:auditor/providers/GeneralData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'CommentSection.dart';

class FillInInterview extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  final Function interviewCallback;
  FillInInterview({Key key, this.index, this.activeSection, this.questionAutoGroup, this.interviewCallback})
      : super(key: key);

  @override
  _FillInInterviewState createState() => _FillInInterviewState();
}

class _FillInInterviewState extends State<FillInInterview> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    TextEditingController controller = TextEditingController();
    if (widget.activeSection.questions[index].userResponse != "" &&
        widget.activeSection.questions[index].userResponse != null) {
      controller.text = widget.activeSection.questions[index].userResponse as String;
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: AutoSizeText(widget.activeSection.questions[index].text,
                  maxLines: 1, group: widget.questionAutoGroup, style: ColorDefs.textBodyBlack20),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(25))),
                child: TextField(
                  enableInteractiveSelection: true,
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: ColorDefs.colorAnotherDarkGreen, width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: ColorDefs.colorAudit2, width: 3),
                      ),
                      border: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: (widget.activeSection.questions[index].text == "Person Interviewed:")
                          ? "Enter Person Interviewed for this Audit "
                          : "Enter Site Contact Email"),
                  controller: controller,
                  onEditingComplete: () {
                    setState(() {});
                    print("DDDDOOOONNNNEEEE");
                  },
                  onChanged: (value) {
                    widget.activeSection.questions[index].userResponse = value;
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
