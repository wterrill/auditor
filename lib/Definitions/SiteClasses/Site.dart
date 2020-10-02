import 'package:hive/hive.dart';

part 'Site.g.dart';

@HiveType(typeId: 10)
class Site extends HiveObject {
  @HiveField(0)
  String programNumber; //PY00002",
  @HiveField(1)
  final String programName; // "PROGRESSIVE LIFE GIVING  DNU",
  @HiveField(2)
  final String programDisplayName; // "PROGRESSIVE DNU - PY00002",
  @HiveField(3)
  String agencyNumber; // "A00078",
  @HiveField(4)
  final String agencyName; // "PROGRESSIVE DNU",
  @HiveField(5)
  final String address1; // "P.O. BOX 1059",
  @HiveField(6)
  final String address2; // "C/O Deacon Carl Hale",
  @HiveField(7)
  final String city; // "Maywood",
  @HiveField(8)
  final String state; // null,
  @HiveField(9)
  final String zip; // null,
  @HiveField(10)
  final String contact; // "Deacon Carl Hale",
  @HiveField(11)
  final String operateHours; // "",
  @HiveField(12)
  final String serviceArea; // null
  @HiveField(13)
  final String contactEmail;

  Site(
      {this.programNumber,
      this.programName,
      this.programDisplayName,
      this.agencyNumber,
      this.agencyName,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zip,
      this.contact,
      this.operateHours,
      this.serviceArea,
      this.contactEmail}) {}

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
        programNumber: json['ProgramNumber'] as String,
        programName: json['ProgramName'] as String,
        programDisplayName: json['ProgramDisplayName'] as String,
        agencyNumber: json['AgencyNumber'] as String,
        agencyName: json['AgencyName'] as String,
        address1: json['Address1'] as String,
        address2: json['Address2'] as String,
        city: json['City'] as String,
        state: json['State'] as String,
        zip: json['Zip'] as String,
        contact: json['Contact'] as String,
        operateHours: json['OperateHours'] as String,
        serviceArea: json['ServiceArea'] as String,
        contactEmail: json['ContactEmail'] as String);
  }
}
