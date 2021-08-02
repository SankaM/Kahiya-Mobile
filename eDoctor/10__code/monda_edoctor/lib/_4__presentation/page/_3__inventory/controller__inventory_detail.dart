import 'package:get/get.dart';
import 'package:monda_edoctor/_0__infra/text_string.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_snackbar.dart';

class DetailInventoryController extends AbstractController {
  static DetailInventoryController get instance => Get.find();

  late bool progressDialogShow;

  String? inventoryId;

  Inventory? inventory;

  @override
  void init() {
    this.progressDialogShow = false;
    this.inventoryId = null;
    this.inventory = null;
  }

  @override
  void reset() {
    this.progressDialogShow = false;
  }

  void retrieveInventory(String inventoryId) {
    this.progressDialogShow = true;

    InventoryService.instance.getInventoryDetail(inventoryId: inventoryId).then((statusWrapper) {
      if(statusWrapper.status == GetInventoryDetailStatus.SUCCESS) {
        this.inventory = statusWrapper.data;
        this.progressDialogShow = false;
        update();
      } else if(statusWrapper.status == GetInventoryDetailStatus.ERROR) {
        MySnackBar.show(Get.context!, statusWrapper.error != null ? statusWrapper.error! : TextString.label__error_retrieving_inventory_data);
        this.progressDialogShow = false;
        update();
      }
    });
  }
}
