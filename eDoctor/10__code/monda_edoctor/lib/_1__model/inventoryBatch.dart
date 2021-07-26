

class InventoryBatch {
  final String id;

  final double? unitBuyPrice;

  final String? unitPriceCurrency;

  final double? unitCounts;

  final String? batchDate;

  final String? expiryDate;


  InventoryBatch({
    required this.id,
    this.unitBuyPrice,
    this.unitPriceCurrency,
    this.unitCounts,
    this.batchDate,
    this.expiryDate,
  });

  factory InventoryBatch.build(Map<String, dynamic> json) => InventoryBatch(
    id: json['id'],
    unitBuyPrice: json['unitBuyPrice'],
    unitPriceCurrency: json['unitPriceCurrency'],
    unitCounts: json['unitCounts'],
    batchDate: json['batchDate'],
    expiryDate: json['expiryDate'],
  );
}
