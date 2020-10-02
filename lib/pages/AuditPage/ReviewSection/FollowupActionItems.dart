// import 'package:auditor/Definitions/AuditClasses/Audit.dart';
// import 'package:auditor/Definitions/AuditClasses/Question.dart';
// // import 'package:auditor/Definitions/AuditClasses/Question.dart';
// // import 'package:auditor/Definitions/AuditClasses/Section.dart';
// import 'package:auditor/Definitions/colorDefs.dart';
// import 'package:flutter/material.dart';

// import 'ReviewQuestionTypes/ReviewCommentSection.dart';

// class FollowupActionItems extends StatefulWidget {
//   FollowupActionItems({Key key, this.activeAudit}) : super(key: key);
//   final Audit activeAudit;

//   @override
//   _FollowupActionItemsState createState() => _FollowupActionItemsState();
// }

// class _FollowupActionItemsState extends State<FollowupActionItems> {
//   // @override
//   bool notHappyPath(Question question) {
//     bool isHappy = true;
//     if (question.happyPathResponse != null) {
//       if (!question.happyPathResponse.contains(question.userResponse)) {
//         isHappy = false;
//       }
//     }
//     return !isHappy;
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return Container(
//         height: 100,
//         child: ListView.builder(
//           shrinkWrap: true,
//           // physics: NeverScrollableScrollPhysics(),
//           itemCount: widget.activeAudit.citations.length,
//           itemBuilder: (context, index) {
//             return Container(
//               color: index.isEven
//                   ? ColorDefs.colorAlternateDark
//                   : ColorDefs.colorAlternateLight,
//               child: Container(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Flexible(
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Text(
//                               widget.activeAudit.citations[index].actionItem,
//                               style: TextStyle(fontSize: 15.0),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 55,
//                           width: 80,
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     widget.activeAudit.citations[index]
//                                             .textBoxRollOut =
//                                         !widget.activeAudit.citations[index]
//                                             .textBoxRollOut;
//                                     print(widget.activeAudit.citations[index]
//                                         .textBoxRollOut);
//                                     setState(() {});
//                                   },
//                                   child: Icon(Icons.feedback,
//                                       size: 40.0,
//                                       color: widget.activeAudit.citations[index]
//                                                   .actionItem ==
//                                               null
//                                           ? ColorDefs.colorDarkBackground
//                                           : ColorDefs.colorChatSelected),
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                     ReviewCommentSection(
//                         index: index,
//                         questions: widget.activeAudit.citations,
//                         key: UniqueKey(),
//                         numKeyboard: false,
//                         mandatory: false,
//                         actionItem: true)
//                   ],
//                 ),
//                 // leading: new Text(question.userResponse),
//               ),
//             );
//           },
//         ));
//   }
// }
