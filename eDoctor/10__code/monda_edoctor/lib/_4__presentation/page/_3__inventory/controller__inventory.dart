import 'package:get/get.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_snackbar.dart';

class InventoryController extends AbstractController {
  static const ITEM_PER_PAGE = 10;

  static InventoryController get instance => Get.find();

  int page = 0;

  bool progressDialogShow = false;

  List<Inventory> inventoryList = [];

  init() {
    page = 0;
    retrieveInventory();
  }

  @override
  void reset() {
  }

  void retrieveInventory() async {
    progressDialogShow = true;

    var wrapperStatus = await InventoryService.instance.getSearchInventory(page: page, itemPerPage: ITEM_PER_PAGE);
    if(wrapperStatus.status == GetSearchInventoryStatus.SUCCESS) {
      inventoryList.clear();
      inventoryList.addAll(wrapperStatus.data!);
    } else if(wrapperStatus.status == GetSearchInventoryStatus.ERROR) {
      inventoryList.clear();
      MySnackBar.show(Get.context!, wrapperStatus.error!);
    }

    _changeProgressBarShow(false);
  }
  
  void nextInventory() {
    if(inventoryList.isNotEmpty) {
      page++;
      retrieveInventory();
    }
  }

  void prevInventory() {
    if(page > 0) {
      page--;
      retrieveInventory();
    }
  }

  void _changeProgressBarShow(bool progressDialogShow) {
    this.progressDialogShow = progressDialogShow;
    update();
  }
}