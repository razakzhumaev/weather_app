import 'package:intl/intl.dart';

mixin Utils {

  static double? kelvinToCelsius(double? kelvin) {
    if (kelvin != null) {
      return kelvin - 273.15; // Кельвины в градусы Цельсия
    } else {
      return null;
    }
  }

  static String formatDateTime(int? timestamp) {
    if (timestamp != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      String formattedTime = DateFormat('h:mm a').format(dateTime);

      return formattedTime;
    }

    return 'N/A';
  }

  static String formatDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Устанавливаем локаль (locale) для форматирования на английский язык
    var formatter = DateFormat('EEEE, d MMMM y', 'en_US');

    return formatter.format(dateTime);
  }

  String formatTime(int timestamp, int timezone) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    ).add(Duration(seconds: timezone));

    return DateFormat('h:mm a').format(dateTime);
  }
}
