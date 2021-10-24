import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/util/api_datasource.dart';

class PatientApi extends ApiDataSource {
  PatientApi.newInstance();

  static PatientApi get instance => Get.find();

  // ===========================================================================
}
