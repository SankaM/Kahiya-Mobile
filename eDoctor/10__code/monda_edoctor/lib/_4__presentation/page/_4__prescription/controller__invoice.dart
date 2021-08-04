
import 'package:get/get.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_3__service/service__patient.dart';
import 'package:monda_edoctor/_4__presentation/common/abstract_controller.dart';
import 'package:monda_edoctor/_4__presentation/common/widget__my_snackbar.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InvoiceController extends AbstractController {
  static const ITEM_PER_PAGE = 10;

  static InvoiceController get instance => Get.find();

  bool progressDialogShow = false;
  
  int page = 0;

  String? queryValue;
  
  final searchForm = FormGroup({
    'queryValue': FormControl<String>(value: null),
  });

  List<Prescription> prescriptionList = [];

  init() {
    this.page = 0;
    this.queryValue = null;
    this.searchForm.reset(value: {'queryValue': null});

    retrieveInvoice();
  }

  @override
  void reset() {
  }

  void search() {
    if(searchForm.control('queryValue').value == null || (searchForm.control('queryValue').value as String).length == 0) {
      retrieveInvoice();
      return;
    }

    this.page = 0;
    this.queryValue = searchForm.control('queryValue').value;
    searchInvoice();
  }

  void retrieveInvoice() async {
    this.queryValue = null;
    _changeProgressBarShow(true);

    var wrapperStatus = await PatientService.instance.getSearchPrescription(page: page, itemPerPage: ITEM_PER_PAGE);
    if(wrapperStatus.status == GetSearchPrescriptionStatus.SUCCESS) {
      prescriptionList.clear();
      prescriptionList.addAll(wrapperStatus.data!);

      _changeProgressBarShow(false);
    } else if(wrapperStatus.status == GetSearchPrescriptionStatus.ERROR) {
      prescriptionList.clear();
      MySnackBar.show(Get.context!, wrapperStatus.error!);

      _changeProgressBarShow(false);
    }
  }

  void searchInvoice() async {
    _changeProgressBarShow(true);

    var wrapperStatus = await PatientService.instance.getSearchPrescription(page: page, itemPerPage: ITEM_PER_PAGE, queryValue: queryValue,);
    if(wrapperStatus.status == GetSearchPrescriptionStatus.SUCCESS) {
      prescriptionList.clear();
      prescriptionList.addAll(wrapperStatus.data!);

      _changeProgressBarShow(false);
    } else if(wrapperStatus.status == GetSearchPrescriptionStatus.ERROR) {
      prescriptionList.clear();
      MySnackBar.show(Get.context!, wrapperStatus.error!);

      _changeProgressBarShow(false);
    }
  }
  
  void nextPage() {
    if(prescriptionList.isNotEmpty) {
      page++;
      if(queryValue != null && queryValue!.length > 0) {
        searchInvoice();
      } else {
        retrieveInvoice();
      }
    }
  }

  void prevPage() {
    if(page > 0) {
      page--;
      if(queryValue != null && queryValue!.length > 0) {
        searchInvoice();
      } else {
        retrieveInvoice();
      }
    }
  }

  void _changeProgressBarShow(bool progressDialogShow) {
    this.progressDialogShow = progressDialogShow;
    update();
  }
}
