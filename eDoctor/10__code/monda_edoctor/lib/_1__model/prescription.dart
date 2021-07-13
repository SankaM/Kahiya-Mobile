import 'package:monda_edoctor/_1__model/diagnosis.dart';
import 'package:monda_edoctor/_1__model/doctor.dart';
import 'package:monda_edoctor/_1__model/dosage.dart';
import 'package:monda_edoctor/_1__model/patient.dart';

class Prescription {
  final String id;

  final Doctor? doctor;

  final Patient? patient;

  final Diagnosis? diagnosis;

  final String? illnessSeverity;

  final String? prescriptionDate;

  final String? notes;

  final String? attachmentUrl;

  final double? doctorCost;

  final double? drugCost;

  final double? totalCost;

  final List<Dosage>? dosageList;

  Prescription({
    required this.id,
    this.doctor,
    this.patient,
    this.diagnosis,
    this.illnessSeverity,
    this.prescriptionDate,
    this.notes,
    this.attachmentUrl,
    this.doctorCost,
    this.drugCost,
    this.totalCost,
    this.dosageList,
  });

  factory Prescription.buildDetail(Map<String, dynamic> json) => Prescription(
    id: json['id'],
    doctor: json['doctor'] != null ? Doctor.buildDetail(json['doctor']) : null,
    patient: json['patient'] != null ? Patient.buildDetail(json['patient']) : null,
    diagnosis: json['diagnosis'] != null ? Diagnosis.buildDetail(json['dosageList']) : null,
    illnessSeverity: json['illnessSeverity'],
    prescriptionDate: json['prescriptionDate'],
    notes: json['notes'],
    attachmentUrl: json['attachmentUrl'],
    doctorCost: json['doctorCost'],
    drugCost: json['drugCost'],
    totalCost: json['totalCost'],
    dosageList: json['dosageList'] != null ? (json['dosageList'] as List).map((e) => Dosage.buildDetail(e)).toList() : null,
  );
}
