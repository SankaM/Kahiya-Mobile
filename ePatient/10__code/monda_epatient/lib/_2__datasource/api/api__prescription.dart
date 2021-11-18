import 'package:get/get.dart' as _;
import 'package:monda_epatient/_0__infra/api_endpoint.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/api_datasource.dart';
import 'package:monda_epatient/_0__infra/util/template_string.dart';
import 'package:monda_epatient/_0__infra/util/util__api.dart';
import 'package:monda_epatient/_1__model/taken_medicine.dart';

class PrescriptionApi extends ApiDataSource {
  static PrescriptionApi get instance => _.Get.find();

  PrescriptionApi.newInstance();

  // ===========================================================================
  Future<ResponseWrapper<List<TakenMedicine>>> findAllTakenMedicine({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.TAKEN_MEDICINE__FIND_ALL, params: {'patientId': patientId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<TakenMedicine>>.success(data: (json['data'] as List).map((e) => TakenMedicine.build(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<void>> updateTakenMedicineStatus({required String takenMedicineId, required bool taken}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.TAKEN_MEDICINE__UPDATE).toString();
    var data = {'takenMedicineId': takenMedicineId, 'taken': taken};
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<void>.success(data: null);
    };

    return ApiUtil.post(url: url, postData: data, options: options, responseDataBuilder: responseDataBuilder);
  }
}
