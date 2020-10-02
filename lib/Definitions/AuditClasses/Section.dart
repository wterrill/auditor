import 'Question.dart';
import 'package:hive/hive.dart';
part 'Section.g.dart';

@HiveType(typeId: 9)
enum Status {
  @HiveField(0)
  disabled,
  @HiveField(1)
  selected,
  @HiveField(2)
  available,
  @HiveField(3)
  inProgress,
  @HiveField(4)
  completed
}

@HiveType(typeId: 7)
class Section extends HiveObject {
  @HiveField(0)
  Map<String, List<Map<String, dynamic>>> section;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Question> questions;

  @HiveField(3)
  var status = Status.disabled;

  @HiveField(4)
  Status lastStatus;

  @HiveField(5)
  int maxPoints;

  @HiveField(6)
  int currentPoints;

  @HiveField(7)
  double sectionScore;

  Section({this.section}) {
    List<Map<String, dynamic>> questionsList = section.values.toList()[0];
    questions = questionsList.map<Question>((question) {
      return Question(questionMap: question);
    }).toList();
    name = section.keys.toList()[0];
    if (name == "Confirm Details") {
      status = Status.selected;
    }
  }
}
