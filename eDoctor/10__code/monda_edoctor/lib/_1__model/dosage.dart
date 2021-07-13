import 'package:monda_edoctor/_0__infra/util/util__string.dart';
import 'package:monda_edoctor/_1__model/drug.dart';

class Dosage {
  final String id;

  final Drug? drug;

  final int? treatmentDays;

  final int? timesPerDay;

  final String? dosageRule;

  final double? dosageCount;

  final double? drugCost;

  Dosage({
    required this.id,
    this.drug,
    this.treatmentDays,
    this.timesPerDay,
    this.dosageRule,
    this.dosageCount,
    this.drugCost,
  });

  String get normalizeDosageRule {
    if(dosageRule == null) return '';

    return StringUtil.capitalize(dosageRule!.replaceAll(RegExp('_'), ' '))!;
  }

  factory Dosage.buildDetail(Map<String, dynamic> json) => Dosage(
        id: json['id'],
        drug: json['drug'] != null ? Drug.buildDetail(json['drug']) : null,
        treatmentDays: json['treatmentDays'],
        timesPerDay: json['timesPerDay'],
        dosageRule: json['dosageRule'],
        dosageCount: json['dosageCount'],
        drugCost: json['drugCost'],
      );
}
