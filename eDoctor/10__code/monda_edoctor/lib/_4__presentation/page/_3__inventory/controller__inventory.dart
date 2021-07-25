
import 'package:get/get.dart';
import 'package:monda_edoctor/_1__model/inventory.dart';
import 'package:monda_edoctor/_3__service/service__inventory.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_snackbar.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InventoryController extends AbstractController {
  static const ITEM_PER_PAGE = 10;

  static InventoryController get instance => Get.find();

  bool progressDialogShow = false;
  
  int page = 0;

  String? queryValue;
  
  SearchDrugField? searchDrugField;

  final searchForm = FormGroup({
    'queryValue': FormControl<String>(value: null),
  });

  List<Inventory> inventoryList = [];

  init() {
    this.page = 0;
    this.queryValue = null;
    this.searchDrugField = null;
    this.searchForm.reset(value: {'queryValue': null});

    retrieveInventory();
  }

  @override
  void reset() {
  }

  void search({required SearchDrugField field}) {
    if(searchForm.control('queryValue').value == null || (searchForm.control('queryValue').value as String).length == 0) {
      retrieveInventory();
      return;
    }

    this.page = 0;
    this.queryValue = searchForm.control('queryValue').value;
    this.searchDrugField = field;
    searchInventory();
  }

  void retrieveInventory() async {
    _changeProgressBarShow(true);

    var wrapperStatus = await InventoryService.instance.getSearchInventory(page: page, itemPerPage: ITEM_PER_PAGE);
    if(wrapperStatus.status == GetSearchInventoryStatus.SUCCESS) {
      inventoryList.clear();
      inventoryList.addAll(wrapperStatus.data!);

      _changeProgressBarShow(false);
    } else if(wrapperStatus.status == GetSearchInventoryStatus.ERROR) {
      inventoryList.clear();
      MySnackBar.show(Get.context!, wrapperStatus.error!);

      _changeProgressBarShow(false);
    }
  }

  void searchInventory() async {
    _changeProgressBarShow(true);

    var wrapperStatus = await InventoryService.instance.getSearchInventory(page: page, itemPerPage: ITEM_PER_PAGE, queryValue: queryValue, field: searchDrugField);
    if(wrapperStatus.status == GetSearchInventoryStatus.SUCCESS) {
      inventoryList.clear();
      inventoryList.addAll(wrapperStatus.data!);

      _changeProgressBarShow(false);
    } else if(wrapperStatus.status == GetSearchInventoryStatus.ERROR) {
      inventoryList.clear();
      MySnackBar.show(Get.context!, wrapperStatus.error!);

      _changeProgressBarShow(false);
    }
  }
  
  void nextPage() {
    if(inventoryList.isNotEmpty) {
      page++;
      if(queryValue != null && queryValue!.length > 0) {
        searchInventory();
      } else {
        retrieveInventory();
      }
    }
  }

  void prevPage() {
    if(page > 0) {
      page--;
      if(queryValue != null && queryValue!.length > 0) {
        searchInventory();
      } else {
        retrieveInventory();
      }
    }
  }

  void _changeProgressBarShow(bool progressDialogShow) {
    this.progressDialogShow = progressDialogShow;
    update();
  }
}
