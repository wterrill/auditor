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
                  onChanged: (value) {
                    // widget.activeSection.questions[index].userResponse = value;

                    // Provider.of<AuditData>(context, listen: false).contactEmail = value;

                    // if (value.length > 0) {
                    //   if (Provider.of<GeneralData>(context, listen: false).confirmButtonEnabled == false) {
                    //     if (Provider.of<GeneralData>(context, listen: false).personInterviewed != null &&
                    //         Provider.of<GeneralData>(context, listen: false).personInterviewed != "") {
                    //       Provider.of<GeneralData>(context, listen: false).enableConfirmButton();
                    //     }
                    //   }
                    // }
                    // if ((!emailValidated(value) &&
                    //         Provider.of<GeneralData>(context, listen: false).confirmButtonEnabled == true) ||
                    //     Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status !=
                    //         "Scheduled") {
                    //   Provider.of<GeneralData>(context, listen: false).disableConfirmButton();
                    // }
                  },
                ),
              ),
            )
            // GestureDetector(
            //   onTap: () {
            //     if (Provider.of<AuditData>(context, listen: false)
            //             .activeAudit
            //             .calendarResult
            //             .status !=
            //         "Scheduled") {
            //       Dialogs.showMessage(
            //           context: context,
            //           message:
            //               "This audit has already been submitted, and cannot be edited",
            //           dismissable: true);
            //     } else {
            //       String result = setQuestionValue(
            //           widget.activeSection.questions[index].userResponse
            //               as String,
            //           'N/A');
            //       widget.activeSection.questions[index].userResponse = result;
            //       Provider.of<AuditData>(context, listen: false)
            //           .updateSectionStatus(
            //               checkSectionDone(widget.activeSection));
            //       Audit thisAudit =
            //           Provider.of<AuditData>(context, listen: false)
            //               .activeAudit;
            //       Provider.of<AuditData>(context, listen: false)
            //           .saveAuditLocally(thisAudit);
            //       setState(() {});
            //     }
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
            //     child: Container(
            //       margin: EdgeInsets.symmetric(horizontal: 4.0),
            //       decoration: BoxDecoration(
            //         color: buttonColorPicker(
            //             widget.activeSection.questions[index], 'N/A'),
            //         borderRadius: BorderRadius.circular(20.0),
            //         // border:
            //         //     Border.all(width: 2.0, color: Colors.grey)
            //       ),
            //       width: 80,
            //       child: Center(
            //           child: Text("N/A", style: ColorDefs.textBodyBlack20)),
            //     ),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     widget.activeSection.questions[index].textBoxRollOut =
            //         !widget.activeSection.questions[index].textBoxRollOut;
            //     Audit thisAudit =
            //         Provider.of<AuditData>(context, listen: false).activeAudit;
            //     Provider.of<AuditData>(context, listen: false)
            //         .saveAuditLocally(thisAudit);
            //     Provider.of<AuditData>(context, listen: false)
            //         .updateSectionStatus(checkSectionDone(activeSection));
            //     setState(() {});
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //     child: Icon(Icons.chat_bubble,
            //         color: widget.activeSection.questions[index].userResponse ==
            //                 null
            //             ? ColorDefs.colorChatRequired
            //             // : ColorDefs.colorChatSelected),
            //             : ColorDefs.colorButtonYes),
            //   ),
            // ),
          ],
        ),
        // CommentSection(
        //     index: index,
        //     activeSection: activeSection,
        //     mandatory: true,
        //     numKeyboard: false,
        //     key: UniqueKey())
      ],
    );
  }
}
