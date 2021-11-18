import 'package:intl/intl.dart';
import 'package:monda_epatient/_1__model/dosage.dart';

class TakenMedicine {
  final String id;

  final Dosage? dosage;

  final String? takenStatus;

  final DateTime? scheduledTakenDate;

  final DateTime? takenStatusDate;

  TakenMedicine({
    required this.id,
    this.dosage,
    this.takenStatus,
    this.scheduledTakenDate,
    this.takenStatusDate,
  });

  factory TakenMedicine.build(Map<String, dynamic> json) => TakenMedicine(
    id: json['id'],
    dosage: json['dosage'] != null ? Dosage.buildDetail(json['dosage']) : null,
    takenStatus: json['status'],
    scheduledTakenDate: json['scheduledTakenDate'] != null ? DateTime.parse(json['scheduledTakenDate']) : null,
    takenStatusDate: json['takenStatusDate'] != null ? DateTime.parse(json['takenStatusDate']) : null,
  );

  bool isFuture() {
    if(scheduledTakenDate == null) {
      return false;
    }

    return scheduledTakenDate!.isAfter(DateTime.now());
  }

  String get scheduledTakenDateLabel {
    if(scheduledTakenDate == null) {
      return '';
    }

    return DateFormat('d MMM, yyy HH:mm').format(scheduledTakenDate!);
  }
}

class TakenStatus {
  static const String TAKEN = 'TAKEN';

  static const String NOT_TAKEN = 'NOT_TAKEN';
}
