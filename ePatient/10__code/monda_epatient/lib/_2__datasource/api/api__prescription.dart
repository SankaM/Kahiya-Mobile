import 'package:get/get.dart' as _;
import 'package:monda_epatient/_0__infra/util/api_datasource.dart';

class PrescriptionApi extends ApiDataSource {
  static PrescriptionApi get instance => _.Get.find();

  PrescriptionApi.newInstance();

  // ===========================================================================
}
