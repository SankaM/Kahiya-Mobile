
import 'package:intl/intl.dart';
import 'package:monda_epatient/_1__model/diagnosis.dart';
import 'package:monda_epatient/_1__model/doctor.dart';
import 'package:monda_epatient/_1__model/dosage.dart';
import 'package:monda_epatient/_1__model/patient.dart';

class Prescription {
  final String id;

  final Doctor? doctor;

  final Patient? patient;

  final Diagnosis? diagnosis;

  final String? illnessSeverity;

  final DateTime? prescriptionDate;

  final String? notes;

  final String? attachmentId;

  final double? doctorCost;

  final double? drugCost;

  final double? totalCost;

  final List<Dosage>? dosageList;

  int get illnessSeverityAsInteger {
    int returnValue = 1;

    if(illnessSeverity == null) {
      returnValue = 1;
    } else if(illnessSeverity == 'LOW') {
      returnValue = 1;
    } else if(illnessSeverity == 'MEDIUM') {
      returnValue = 2;
    } else if(illnessSeverity == 'HIGH') {
      returnValue = 3;
    }

    return returnValue;
  }

  bool get isPrescribed {
    return dosageList != null && dosageList!.isNotEmpty;
  }

  String get diagnosticNonNull {
    return diagnosis == null ? '' : diagnosis!.name == null ? '' : diagnosis!.name!;
  }

  String get prescriptionDateNonNull {
    return prescriptionDate == null ? '' : DateFormat('dd MMM, yyyy').format(prescriptionDate!);
  }

  Prescription({
    required this.id,
    this.doctor,
    this.patient,
    this.diagnosis,
    this.illnessSeverity,
    this.prescriptionDate,
    this.notes,
    this.attachmentId,
    this.doctorCost,
    this.drugCost,
    this.totalCost,
    this.dosageList,
  });

  factory Prescription.buildDetail(Map<String, dynamic> json) => Prescription(
    id: json['id'],
    doctor: json['doctor'] != null ? Doctor.buildDetail(json['doctor']) : null,
    patient: json['patient'] != null ? Patient.buildDetail(json['patient']) : null,
    diagnosis: json['diagnosis'] != null ? Diagnosis.buildDetail(json['diagnosis']) : null,
    illnessSeverity: json['illnessSeverity'],
    prescriptionDate: json['prescriptionDate'] != null ? DateTime.parse(json['prescriptionDate']) : null,
    notes: json['notes'],
    attachmentId: json['attachmentId'],
    doctorCost: json['doctorCost'],
    drugCost: json['drugCost'],
    totalCost: json['totalCost'],
    dosageList: json['dosageList'] != null ? (json['dosageList'] as List).map((e) => Dosage.buildDetail(e)).toList() : null,
  );
}
