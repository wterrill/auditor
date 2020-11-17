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

class FillInEmail extends StatefulWidget {
  final int index;
  final Section activeSection;
  final AutoSizeGroup questionAutoGroup;
  FillInEmail({Key key, this.index, this.activeSection, this.questionAutoGroup}) : super(key: key);

  @override
  _FillInEmailState createState() => _FillInEmailState();
}

class _FillInEmailState extends State<FillInEmail> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.activeSection.questions[widget.index].textBoxRollOut = true;
  // }

  @override
  Widget build(BuildContext context) {
    // bool emailValidated(String emailString) {
    //   bool emailValidated = true;
    //   List<String> emailList = emailString.split(";");
    //   for (String email in emailList) {
    //     email = email.replaceAll(" ", "");
    //     if ((!email.contains(RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')) && email != "")) {
    //       emailValidated = false;
    //     }
    //   }
    //   print(emailList);
    //   print("wtf?");
    //   print(emailValidated);
    //   // Provider.of<GeneralData>(context, listen: false).emailValidated = emailValidated;
    //   return emailValidated;
    // }

    int index = widget.index;
    // Section activeSection = widget.activeSection;
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
                          : "Enter Site Contact Email(s) separated by ';'"),
                  controller: controller,
                  onChanged: (value) {},
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
