import 'package:hive/hive.dart';

part 'Auditor.g.dart';

@HiveType(typeId: 12)
class Auditor extends HiveObject {
  @HiveField(0)
  Map<String, dynamic> auditorMap; //"William Terill"",
  @HiveField(1)
  String username;
  @HiveField(2)
  String firstName;
  @HiveField(3)
  String lastName;
  Auditor({this.auditorMap}) {
    username = auditorMap['UserName'] as String;
    firstName = auditorMap['FirstName'] as String;
    lastName = auditorMap['LastName'] as String;
  }

  String toString() {
    return auditorMap.toString();
  }
}
