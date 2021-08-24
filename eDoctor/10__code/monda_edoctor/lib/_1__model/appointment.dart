import 'package:monda_edoctor/_1__model/patient.dart';

class Appointment {
  final String id;

  final Patient? patient;

  final DateTime? appointmentDate;

  String? status;

  Appointment({
    required this.id,
    this.patient,
    this.appointmentDate,
    this.status,
  });

  factory Appointment.build(Map<String, dynamic> json) => Appointment(
    id: json['id'],
    patient: json['patient'] != null ? Patient.buildDetail(json['patient']) : null,
    status: json['status'],
    appointmentDate: json['appointmentDate'] != null ? DateTime.parse(json['appointmentDate']) : null,
  );
}
