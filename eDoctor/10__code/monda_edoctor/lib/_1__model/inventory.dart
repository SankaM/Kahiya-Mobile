import 'package:monda_edoctor/_1__model/drug.dart';

class Inventory {
  final String id;

  final Drug? drug;

  final double? availableUnits;

  final double? unitSellPrice;

  final String? unitPriceCurrency;

  final bool? isAvailable;

  Inventory({
    required this.id,
    this.drug,
    this.availableUnits,
    this.unitSellPrice,
    this.unitPriceCurrency,
    this.isAvailable,
  });

  factory Inventory.build(Map<String, dynamic> json) => Inventory(
    id: json['id'],
    drug: json['drug'] != null ? Drug.buildDetail(json['drug']) : null,
    availableUnits: json['availableUnits'],
    unitSellPrice: json['unitSellPrice'],
    unitPriceCurrency: json['unitPriceCurrency'],
    isAvailable: json['isAvailable'],
  );
}