class HourStringInt {
  String hourString;
  int hour;
  int minute;

  HourStringInt(String hourString) : hourString = hourString {
    String amPm = hourString.split(" ")[1];
    String time = hourString.split(" ")[0];
    if (amPm.length != 2) {
      throw ("am/pm times are not correct");
    }
    hour = int.parse(time.split(":")[0]);
    minute = int.parse(time.split(":")[1]);
    if (amPm.toLowerCase() == "pm") hour += 12;
  }
}
