import 'package:intl/intl.dart';

class AppointmentOptionHour {
  final int id;

  final String workHourId;

  final String dayLabel;

  final String timeLabel;

  final DateTime date;

  AppointmentOptionHour({required this.id, required this.workHourId, required this.dayLabel, required this.timeLabel, required this.date});

  String get dateLabel {
    return DateFormat('d MMM, yyy').format(date);
  }
}
