class DateUtils{
  static String DateTimeToString({
    required DateTime dateTime,
  }) {
    return '${dateTime.year}-${padInt(number: dateTime.month)}-${padInt(number: dateTime.day)}';
  }


  static String padInt({
    required int number,
  }) {
    return number.toString().padLeft(2, '0');
  }
}