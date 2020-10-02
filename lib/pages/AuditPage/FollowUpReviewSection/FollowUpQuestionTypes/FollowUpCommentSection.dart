import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';

import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';

// import 'commonQuestionMethods.dart';

class FollowUpCommentSection extends StatefulWidget {
  final int index;
  final List<Question> citations;
  final bool mandatory;
  final bool numKeyboard;
  FollowUpCommentSection(
      {Key key, @required this.index, @required this.citations, @required this.mandatory, @required this.numKeyboard})
      : super(key: key);

  @override
  _FollowUpCommentSectionState createState() => _FollowUpCommentSectionState();
}

class _FollowUpCommentSectionState extends State<FollowUpCommentSection> {
  @override
  void initState() {
    super.initState();

    String text;

    if (widget.mandatory) {
      text = widget.citations[widget.index].userResponse?.toString();
    } else {
      text = widget.citations[widget.index].optionalComment;
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
      height: widget.citations[index].textBoxRollOut ? 80 : 0,
      color: Colors.white,
      duration: Duration(milliseconds: 150),
      child: TextField(
        enableInteractiveSelection: true,
        keyboardType: widget.numKeyboard ? TextInputType.number : TextInputType.text,
        controller: controller,
        onChanged: (value) {
          if (Provider.of<AuditData>(context, listen: false).activeAudit.calendarResult.status != "Scheduled") {
            Dialogs.showMessage(
                context: context,
                message: "This audit has already been submitted, and cannot be edited",
                dismissable: true);
          } else {
            if (widget.mandatory) {
              if (widget.numKeyboard) {
                try {
                  widget.citations[index].userResponse = int.parse(value);
                } catch (error) {
                  Dialogs.mustBeNumber(context);
                }
              } else {
                widget.citations[index].userResponse = value;
              }
              // if (activeSection.name != "Confirm Details") {
              //   Status sectionStatus = checkSectionDone(activeSection);
              //   // Provider.of<AuditData>(context, listen: false)
              //   //     .updateSectionStatus(sectionStatus);
              // } else {
              //   Provider.of<AuditData>(context, listen: false)
              //       .activeAudit
              //       .activateConfirmDetails = true;
              // }
            } else {
              widget.citations[index].optionalComment = value;
            }

            Audit thisAudit = Provider.of<AuditData>(context, listen: false).activeAudit;
            Provider.of<AuditData>(context, listen: false).saveAuditLocally(thisAudit);
          }
        },
        maxLines: null,
        style: widget.citations[index].textBoxRollOut ? ColorDefs.textBodyBlack20 : ColorDefs.textTransparent,
        decoration: InputDecoration(
            suffixIcon: (widget.citations[index].textBoxRollOut)
                ? IconButton(
                    onPressed: () {
                      controller.clear();
                      if (widget.mandatory) {
                        widget.citations[widget.index].userResponse = "";
                      } else {
                        widget.citations[widget.index].optionalComment = "";
                      }
                    },
                    icon: Icon(Icons.clear),
                  )
                : null,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: "Enter comments "),
      ),
    );
  }
}
