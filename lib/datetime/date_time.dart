// Return today's date as yyyymmdd
String todaysDateYYYYMMDD() {
  // Todays Date
  var DTO = DateTime.now(); // Todays DayTime

  // Year in the format yyyy
  String year = DTO.year.toString();

  // Month in the format of mm
  String month = DTO.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // Day in format dd
  String day = DTO.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // Final Formatting
  String yymmdd = year + month + day;

  return yymmdd;
}

// Convert string yyyymmdd to DateTime object
DateTime createDataTimeObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime DTO = DateTime(yyyy, mm, dd); // Placing this into an object
  return DTO;
}

// Covert DateTimeToYYYYMMDD
String convertDateTimeToYYYYMMDD(DateTime dateTime) {
  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
