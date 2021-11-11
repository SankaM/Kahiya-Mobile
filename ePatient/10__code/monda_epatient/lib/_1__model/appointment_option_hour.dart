import 'package:intl/intl.dart';
import 'package:monda_epatient/_1__model/work_hour.dart';

class AppointmentOptionHour {
  final int id;

  final WorkHour workHour;

  final DateTime time;

  AppointmentOptionHour({required this.id, required this.workHour, required this.time});

  String get dateLabel {
    return DateFormat('d MMM, yyy').format(time);
  }

  String get dayLabel {
    return DateFormat('EEEE').format(time).substring(0, 3);
  }

  String get timeLabel {
    return DateFormat('HH:mm').format(time);
  }
}
