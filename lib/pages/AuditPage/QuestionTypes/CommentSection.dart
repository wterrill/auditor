import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/providers/AuditData.dart';
// import 'package:auditor/providers/GeneralData.dart';
// import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';

import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';

// import 'commonQuestionMethods.dart';

class CommentSection extends StatefulWidget {
  final int index;
  final Section activeSection;
  final bool mandatory;
  final bool numKeyboard;
  final Function bubbleCallback;
  int characterLimit = -1;
  CommentSection(
      {Key key,
      @required this.index,
      @required this.activeSection,
      @required this.mandatory,
      @required this.numKeyboard,
      @required this.bubbleCallback,
      this.characterLimit})
      : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  void initState() {
    super.initState();

    String text;

    if (widget.mandatory) {
      text = widget.activeSection.questions[widget.index].userResponse?.toString();
    } else {
      text = widget.activeSection.questions[widget.index].optionalComment;
    }

    if (text != null) {
      controller.text = text;
    }
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    // Section activeSection = widget.activeSection;
    return AnimatedContainer(
      decoration: BoxDecoration(color: ColorDefs.colorTopHeader, borderRadius: BorderRadius.all(Radius.circular(25.0))),
      height: widget.activeSection.questions[index].textBoxRollOut ? 80 : 0,
      duration: Duration(milliseconds: 300),
      child: Focus(
        onFocusChange: (hasFocus) {
          print('hasFocus: $hasFocus');
          if (!hasFocus) {
            print("lost focus");
          }
        },
        child: TextField(
          enableInteractiveSelection: true,
          keyboardType: widget.numKeyboard ? TextInputType.number : TextInputType.text,
          controller: controller,
          onChanged: (value) {
            if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status != "Scheduled") {
              Dialogs.showMessage(
                  context: context,
                  message: "This audit has already been submitted, and cannot be edited",
                  dismissable: true,
                  textStyle: ColorDefs.textWhiteTerminal,
                  bckcolor: ColorDefs.colorDarkBackground);
            } else {
              if (widget.characterLimit != -1) {
                if (value.length > widget.characterLimit - 2) {
                  Dialogs.showMessage(
                      context: context,
                      message:
                          "This comment field has an upper limit of ${widget.characterLimit} characters. Please edit.",
                      dismissable: true,
                      textStyle: ColorDefs.textWhiteTerminal,
                      bckcolor: ColorDefs.colorDarkBackground);
                }
              }
              if (widget.mandatory) {
                if (widget.numKeyboard) {
                  try {
                    if (value != "") {
                      widget.activeSection.questions[index].userResponse = int.parse(value);
                    }
                  } catch (error) {
                    Dialogs.mustBeNumber(context);
                  }
                } else {
                  widget.activeSection.questions[index].userResponse = value;
                }
              } else {
                widget.activeSection.questions[index].optionalComment = value;
              }

              Audit thisAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
              Provider.of<AuditData>(context, listen: false).saveAuditLocally(incomingAudit: thisAudit);
              widget.bubbleCallback(value);
            }
          },
          maxLines: null,
          style: widget.activeSection.questions[index].textBoxRollOut
              ? ColorDefs.textBodyBlack20
              : ColorDefs.textTransparent,
          decoration: InputDecoration(
              suffixIcon: (widget.activeSection.questions[index].textBoxRollOut)
                  ? IconButton(
                      onPressed: () {
                        controller.clear();
                        if (widget.mandatory) {
                          widget.activeSection.questions[widget.index].userResponse = "";
                        } else {
                          widget.activeSection.questions[widget.index].optionalComment = "";
                        }
                      },
                      icon: Icon(Icons.clear),
                    )
                  : null,
              border: InputBorder.none,
              // focusedBorder: InputBorder.none,
              // enabledBorder: InputBorder.none,
              // errorBorder: InputBorder.none,
              // disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: "Enter comments "),
        ),
      ),
    );
  }
}
