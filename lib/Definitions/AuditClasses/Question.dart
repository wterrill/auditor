import 'package:hive/hive.dart';
part 'Question.g.dart';

@HiveType(typeId: 8)
class Question extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  String typeOfQuestion; // yesNo, yesNoNa, fillIn, dropDown, date, display, issuesNoIssues

  @HiveField(2)
  dynamic userResponse; // what the user reponsed on the questionnaire

  @HiveField(3)
  List<String> happyPathResponse; // what the desired response is

  @HiveField(4)
  List<String> dropDownMenu;

  @HiveField(5)
  String optionalComment;

  @HiveField(6)
  String note;

  @HiveField(7)
  bool textBoxRollOut;

  @HiveField(8)
  bool completed = false;

  @HiveField(9)
  bool unflagged = false;

  @HiveField(10)
  Map<String, dynamic> questionMap;

  @HiveField(11)
  String displayVariable;

  @HiveField(12)
  String fromSectionName;

  @HiveField(13)
  String actionItem;

  @HiveField(14)
  bool hideFollowUpActionItem = false;

  @HiveField(15)
  bool hideNa = false;

  @HiveField(16)
  bool highlight = false;

  @HiveField(17)
  int scoring;

  @HiveField(18)
  bool scoreAdded = false;

  Question({this.questionMap}) {
    text = questionMap['text'] as String;
    typeOfQuestion = questionMap['type'] as String;
    if (questionMap['type'] == "dropDown") {
      dropDownMenu = questionMap['menuItems'] as List<String>;
    }
    // if (questionMap['type'] != "fillIn") {
    //   textBoxRollOut = false;
    // } else {
    //   textBoxRollOut = true;
    // }
    textBoxRollOut = false;
    happyPathResponse = questionMap['happyPathResponse'] as List<String>;
    actionItem = questionMap['actionItem'] as String;
    if (questionMap['hideNa'] == 'true') {
      hideNa = true;
    }
    if (questionMap['scoring'] != null) {
      scoring = questionMap['scoring'] as int;
    }
  }

  String toString() {
    return text;
  }
}
