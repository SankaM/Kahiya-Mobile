import 'package:intl/intl.dart';
import 'package:monda_epatient/_1__model/doctor.dart';
import 'package:monda_epatient/_1__model/patient.dart';
import 'package:monda_epatient/_1__model/work_hour.dart';

class Appointment {
  final String id;

  final Patient? patient;

  final WorkHour? workHour;

  final Doctor? doctor;

  final DateTime? appointmentDate;

  String? status;

  final String? prescriptionId;

  Appointment({
    required this.id,
    this.patient,
    this.doctor,
    this.workHour,
    this.appointmentDate,
    this.status,
    this.prescriptionId,
  });

  factory Appointment.build(Map<String, dynamic> json) => Appointment(
    id: json['id'],
    patient: json['patient'] != null ? Patient.buildDetail(json['patient']) : null,
    doctor: json['doctor'] != null ? Doctor.buildDetail(json['doctor']) : null,
    workHour: json['workHour'] != null ? WorkHour.build(json['workHour']) : null,
    status: json['status'],
    appointmentDate: json['appointmentDate'] != null ? DateTime.parse(json['appointmentDate']) : null,
    prescriptionId: json['prescriptionId'],
  );

  String get dateLabel {
    if(appointmentDate == null) {
      return '';
    }

    return DateFormat('d MMM, yyy').format(appointmentDate!);
  }

  String get dayLabel {
    if(appointmentDate == null) {
      return '';
    }

    return DateFormat('EEEE').format(appointmentDate!).substring(0, 3);
  }

  String get timeLabel {
    if(appointmentDate == null) {
      return '';
    }

    return DateFormat('HH:mm').format(appointmentDate!);
  }

  String get statusNonNull {
    return status == null ? '' : status!;
  }
}

class AppointmentStatus {
  static const String REQUESTED = 'REQUESTED';

  static const String ACCEPTED = 'ACCEPTED';

  static const String DECLINED = 'DECLINED';

  static const String PRESCRIBED = 'PRESCRIBED';

  static const String CANCELLED = 'CANCELLED';
}
