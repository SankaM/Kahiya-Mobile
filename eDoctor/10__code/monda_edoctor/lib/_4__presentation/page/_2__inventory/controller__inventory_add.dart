
import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monda_edoctor/_0__infra/util/util__alert.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:monda_edoctor/_4__presentation/page/_2__inventory/controller__inventory.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddInventoryController extends AbstractController {
  static AddInventoryController get instance => Get.find();

  final addInventoryForm = FormGroup({
    'drugId': FormControl<String>(value: null, validators: [Validators.required]),
    'unitSellCurrency': FormControl<String>(value: 'SGD', validators: [Validators.required]),
    'unitSellPrice': FormControl<double>(value: 0.0, validators: [Validators.required]),
    'unitBuyCurrency': FormControl<String>(value: 'SGD', validators: [Validators.required]),
    'unitBuyPrice': FormControl<double>(value: 0.0, validators: [Validators.required]),
    'unitCount': FormControl<int>(value: 0, validators: [Validators.required, Validators.min(1)]),
    'unitThresholdWarning': FormControl<int>(value: 0, validators: [Validators.required, Validators.min(1)]),
    'batchDate': FormControl<DateTime>(value: DateTime.now(), validators: [Validators.required]),
    'expiryDate': FormControl<DateTime>(value: DateTime.now(), validators: [Validators.required]),
  });

  bool progressDialogShow = false;

  @override
  void reset() {
    this.addInventoryForm.reset(value: {
      'drugId': null,
      'unitSellCurrency': 'SGD',
      'unitSellPrice': 0.0,
      'unitBuyCurrency': 'SGD',
      'unitBuyPrice': 0.0,
      'unitCount': 0,
      'unitThresholdWarning': 0,
      'batchDate': DateTime.now(),
      'expiryDate': DateTime.now(),
    });

    progressDialogShow = false;

    update();
  }

  void changeDrugId(String drugId) {
    this.addInventoryForm.control('drugId').value = drugId;
  }

  void changeUnitThresholdWarning(int unitThresholdWarning) {
    this.addInventoryForm.control('unitThresholdWarning').value = unitThresholdWarning;
    log('=================================== unitThresholdWarning: ${this.addInventoryForm.control('unitThresholdWarning').value}');
  }

  void changeUnitCount(int unitCount) {
    this.addInventoryForm.control('unitCount').value = unitCount;
  }

  void submit() async {
    this.progressDialogShow = true;
    update();

    String drugId = this.addInventoryForm.control('drugId').value;
    String unitSellCurrency = this.addInventoryForm.control('unitSellCurrency').value;
    double unitSellPrice = this.addInventoryForm.control('unitSellPrice').value;
    String unitBuyCurrency = this.addInventoryForm.control('unitBuyCurrency').value;
    double unitBuyPrice = this.addInventoryForm.control('unitBuyPrice').value;
    int unitCount = this.addInventoryForm.control('unitCount').value;
    int unitThresholdWarning = this.addInventoryForm.control('unitThresholdWarning').value;
    String batchDate = DateFormat("yyyy-MM-dd").format(this.addInventoryForm.control('batchDate').value);
    String expiryDate = DateFormat("yyyy-MM-dd").format(this.addInventoryForm.control('expiryDate').value);

    var wrapper = await InventoryService.instance.newBatchInventory(
        drugId: drugId,
        unitSellPrice: unitSellPrice,
        unitSellCurrency: unitSellCurrency,
        unitBuyPrice: unitBuyPrice,
        unitBuyCurrency: unitBuyCurrency,
        unitCount: unitCount.toDouble(),
        unitThresholdWarning: unitThresholdWarning.toDouble(),
        batchDate: batchDate,
        expiryDate: expiryDate);

    if(wrapper.status == NewBatchInventoryStatus.SUCCESS) {
      reset();
      InventoryController.instance.init();
      Get.back();
      AlertUtil.showMessage('New inventory added',);
    } else if(wrapper.status == NewBatchInventoryStatus.SUCCESS) {
      AlertUtil.showMessage('${wrapper.error}',);
      progressDialogShow = false;
      update();
    }
  }
}
