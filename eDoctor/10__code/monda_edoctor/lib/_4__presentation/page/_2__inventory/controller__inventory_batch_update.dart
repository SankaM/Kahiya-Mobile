
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_1__model/inventoryBatch.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/controller__inventory_detail.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InventoryBatchUpdateController extends AbstractController {
  static InventoryBatchUpdateController get instance => Get.find();

  Inventory? inventory;

  InventoryBatch? inventoryBatch;

  bool progressDialogShow = false;

  final updateForm = FormGroup({
    'unitSellCurrency': FormControl<String>(value: 'SGD', validators: [Validators.required]),
    'unitSellPrice': FormControl<double>(value: 0.0, validators: [Validators.required]),
    'unitBuyCurrency': FormControl<String>(value: 'SGD', validators: [Validators.required]),
    'unitBuyPrice': FormControl<double>(value: 0.0, validators: [Validators.required]),
    'unitCount': FormControl<int>(value: 0, validators: [Validators.required, Validators.min(1)]),
    'batchDate': FormControl<DateTime>(value: DateTime.now(), validators: [Validators.required]),
    'expiryDate': FormControl<DateTime>(value: DateTime.now(), validators: [Validators.required]),
  });

  void initData({required Inventory inventory, required InventoryBatch inventoryBatch}) {
    this.inventory = inventory;
    this.inventoryBatch = inventoryBatch;
    this.progressDialogShow = false;

    updateForm.reset(value: {
      'unitSellCurrency': inventory.unitPriceCurrency,
      'unitSellPrice': inventory.unitSellPrice,
      'unitBuyCurrency': inventoryBatch.unitPriceCurrency,
      'unitBuyPrice': inventoryBatch.unitBuyPrice,
      'unitCount': inventoryBatch.unitCounts!.toInt(),
      'batchDate': DateTime.parse(inventoryBatch.batchDate!),
      'expiryDate': DateTime.parse(inventoryBatch.expiryDate!),
    });
  }

  void changeUnitCount(int unitCount) {
    this.updateForm.control('unitCount').value = unitCount;
  }

  void submit() async {
    this.progressDialogShow = true;
    update();

    String unitSellCurrency = this.updateForm.control('unitSellCurrency').value;
    double unitSellPrice = this.updateForm.control('unitSellPrice').value;
    String unitBuyCurrency = this.updateForm.control('unitBuyCurrency').value;
    double unitBuyPrice = this.updateForm.control('unitBuyPrice').value;
    int unitCount = this.updateForm.control('unitCount').value;
    String batchDate = DateFormat("yyyy-MM-dd").format(this.updateForm.control('batchDate').value);
    String expiryDate = DateFormat("yyyy-MM-dd").format(this.updateForm.control('expiryDate').value);

    var wrapper = await InventoryService.instance.updateBatchInventory(
        inventoryBatchId: inventoryBatch!.id,
        unitSellPrice: unitSellPrice,
        unitSellCurrency: unitSellCurrency,
        unitBuyPrice: unitBuyPrice,
        unitBuyCurrency: unitBuyCurrency,
        unitCount: unitCount.toDouble(),
        batchDate: batchDate,
        expiryDate: expiryDate);

    if(wrapper.status == UpdateBatchInventoryStatus.SUCCESS) {
      this.progressDialogShow = false;
      update();
      DetailInventoryController.instance.retrieveInventory(inventoryId: inventory!.id);
      DetailInventoryController.instance.update();

      Get.back();
      AlertUtil.showMessage('Inventory batch updated',);
    } else if(wrapper.status == UpdateBatchInventoryStatus.SUCCESS) {
      AlertUtil.showMessage('${wrapper.error}',);
      progressDialogShow = false;
      update();
    }
  }
}
