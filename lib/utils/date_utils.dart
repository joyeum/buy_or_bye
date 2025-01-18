class DateUtils {
  static String formatDateTime({
    required DateTime dateTime,
  }) {
    final month = padInt(number: dateTime.month);
    final day = padInt(number: dateTime.day);
    final year = dateTime.year;
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = padInt(number: dateTime.minute);
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$year-$month-$day ${hour == 0 ? 12 : hour}:$minute$period';
  }



  static String DateTimeToString({
    required DateTime dateTime,
  }) {
    return '${padInt(number: dateTime.month)}-${padInt(number: dateTime.day)}';
    //return '${dateTime.year}-${padInt(number: dateTime.month)}-${padInt(number: dateTime.day)}';
  }

  static String padInt({
    required int number,
  }) {
    return number.toString().padLeft(2, '0');
  }
}
