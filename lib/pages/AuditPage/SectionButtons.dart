import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:auditor/Definitions/AuditClasses/Audit.dart';
// import 'package:auditor/AuditClasses/Section.dart';
// import 'package:auditor/Definitions/colorDefs.dart';
// import 'package:auditor/providers/AuditData.dart';

import 'SectionButton.dart';

class SectionButtons extends StatefulWidget {
  SectionButtons({Key key, this.activeAudit}) : super(key: key);
  final Audit activeAudit;

  @override
  _SectionButtonsState createState() => _SectionButtonsState();
}

class _SectionButtonsState extends State<SectionButtons> {
  @override
  void initState() {
    super.initState();
    // List<Section> buttonSections = widget.activeAudit.sections;
    if (widget.activeAudit.calendarResult.auditType == "Follow Up") {
      for (Section section in widget.activeAudit.sections) {
        if (section.name == "Review") {
          section.name = "Follow Up Review";
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle getScoreColor(double auditScore) {
      TextStyle scoreStyle = ColorDefs.textRedScore;
      if (auditScore >= 40) {
        scoreStyle = ColorDefs.textOrangeScore;
      }
      if (auditScore > 70) {
        scoreStyle = ColorDefs.textGreenScore;
      }
      return scoreStyle;
    }

    print("building SectionButtons");
    AutoSizeGroup buttonAutoGroup = AutoSizeGroup();
    Widget built;
    (widget.activeAudit == null)
        ? built = Text("")
        : built = Padding(
            padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        LimitedBox(
                          maxHeight: 80,
                          child: Image(
                            image: AssetImage('assets/images/GCFD_Logo_vertical.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: Text(
                                    widget.activeAudit?.calendarResult?.agencyName ?? "",
                                    style: ColorDefs.textGreen25,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          widget.activeAudit?.calendarResult?.agencyNumber ?? "",
                                          style: ColorDefs.textGreen25,
                                        ),
                                        Text(
                                          "/",
                                          style: ColorDefs.textGreen25,
                                        ),
                                        Text(
                                          widget.activeAudit?.calendarResult?.programNum ?? "",
                                          style: ColorDefs.textGreen25,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.activeAudit?.name ?? "",
                                  style: ColorDefs.textBodyBlack20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (widget.activeAudit.calendarResult.programType != "Older Adults Program" &&
                            widget.activeAudit.calendarResult.programType != "Healthy Student Market" &&
                            widget.activeAudit.calendarResult.auditType != "Follow Up")
                          Container(
                            // height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Internal", style: ColorDefs.textBodyBlack20),
                                Text('${widget.activeAudit?.auditScore?.toStringAsFixed(2) ?? ""}',
                                    style: getScoreColor(widget.activeAudit.auditScore)),
                                Text(
                                    '${widget.activeAudit?.currentPoints?.toString() ?? ""} / ${widget.activeAudit?.maxPoints?.toString() ?? ""}',
                                    style: ColorDefs.textBodyBlack20),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    height: 101,
                    child: ListView.separated(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Container(width: 5, color: Colors.transparent),
                      itemCount: widget.activeAudit.sections.length,
                      itemBuilder: (context, index) {
                        SectionButton sectionButton = SectionButton(
                            section: widget.activeAudit.sections[index],
                            buttonAutoGroup: buttonAutoGroup,
                            activeAudit: widget.activeAudit);
                        if (index == 0) return Padding(padding: EdgeInsets.only(left: 10.0), child: sectionButton);
                        if (index == widget.activeAudit.sections.length - 1)
                          return Padding(padding: EdgeInsets.only(right: 10.0), child: sectionButton);
                        return sectionButton;
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
    return built;
  }
}
