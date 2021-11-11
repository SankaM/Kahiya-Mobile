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
}

class AppointmentStatus {
  static const String REQUESTED = 'REQUESTED';

  static const String ACCEPTED = 'ACCEPTED';

  static const String DECLINED = 'DECLINED';

  static const String PRESCRIBED = 'PRESCRIBED';
}
