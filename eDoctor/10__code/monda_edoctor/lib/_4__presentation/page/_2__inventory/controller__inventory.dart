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

  SearchDrugField searchDrugField = SearchDrugField.NAME;

  String? queryValue;

  int page = 0;

  final searchForm = FormGroup({
    'queryValue': FormControl(),
  });

  List<Inventory> inventoryList = [];

  init() {
    reset(doUpdate: false);
  }

  reset({bool doUpdate = true}) {
    this.searchDrugField = SearchDrugField.NAME;
    this.queryValue = null;
    this.page = 0;
    this.searchForm.reset(value: {'queryValue': '',});

    search();
    if(doUpdate) update();
  }

  void search({bool resetPage = false}) async {
    if(resetPage) {
      this.page = 0;
    }
    if(searchForm.control('queryValue').value != null && searchForm.control('queryValue').value.length > 0) {
      this.queryValue = searchForm.control('queryValue').value;
    } else {
      this.queryValue = null;
    }

    var wrapperStatus = await InventoryService.instance.getSearchInventory(page: page, itemPerPage: ITEM_PER_PAGE, queryValue: queryValue, field: searchDrugField);
    if(wrapperStatus.status == GetSearchInventoryStatus.SUCCESS) {
      inventoryList.clear();
      inventoryList.addAll(wrapperStatus.data!);
      update();
    } else if(wrapperStatus.status == GetSearchInventoryStatus.ERROR) {
      inventoryList.clear();
      MySnackBar.show(Get.context!, wrapperStatus.error!);
      update();
    }
  }

  void nextPage() {
    if(inventoryList.isNotEmpty) {
      page++;
      search();
    }
  }

  void prevPage() {
    if(page > 0) {
      page--;
      search();
    }
  }
}
