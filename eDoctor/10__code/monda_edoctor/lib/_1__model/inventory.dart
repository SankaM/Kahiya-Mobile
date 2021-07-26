import 'package:monda_edoctor/_1__model/drug.dart';
import 'package:monda_edoctor/_1__model/inventoryBatch.dart';

class Inventory {
  final String id;

  final Drug? drug;

  final double? availableUnits;

  final double? unitSellPrice;

  final String? unitPriceCurrency;

  final bool? isAvailable;

  final List<InventoryBatch>? inventoryBatchList;

  Inventory({
    required this.id,
    this.drug,
    this.availableUnits,
    this.unitSellPrice,
    this.unitPriceCurrency,
    this.isAvailable,
    this.inventoryBatchList,
  });

  factory Inventory.build(Map<String, dynamic> json) => Inventory(
    id: json['id'],
    drug: json['drug'] != null ? Drug.buildDetail(json['drug']) : null,
    availableUnits: json['availableUnits'],
    unitSellPrice: json['unitSellPrice'],
    unitPriceCurrency: json['unitPriceCurrency'],
    isAvailable: json['isAvailable'],
    inventoryBatchList: json['inventoryBatchList'] != null ? (json['inventoryBatchList'] as List).map((e) => InventoryBatch.build(e)).toList() : null,
  );
}
