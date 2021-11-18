import 'dart:async';

import 'package:get/get.dart';
import 'package:monda_epatient/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_epatient/_0__infra/util/status_wrapper.dart';
import 'package:monda_epatient/_1__model/taken_medicine.dart';
import 'package:monda_epatient/_2__datasource/api/api__prescription.dart';
import 'package:monda_epatient/_2__datasource/securestorage/secure_storage__user.dart';

class PrescriptionService {
  static PrescriptionService get instance => Get.find();

  PrescriptionService.newInstance();

  // ===========================================================================
  Future<StatusWrapper<Status, List<TakenMedicine>, String>> findAll() {
    var completer = Completer<StatusWrapper<Status, List<TakenMedicine>, String>>();

    var patientId = UserSecureStorage.instance.user!.id;
    PrescriptionApi.instance.findAllTakenMedicine(patientId: patientId).then((ResponseWrapper<List<TakenMedicine>> res) {
      if(res.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS, data: res.data));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }

  // ===========================================================================
  Future<StatusWrapper<Status, void, String>> updateTakenMedicineStatus({required String takenMedicineId, required bool taken}) {
    var completer = Completer<StatusWrapper<Status, void, String>>();

    PrescriptionApi.instance.updateTakenMedicineStatus(takenMedicineId: takenMedicineId, taken: taken).then((ResponseWrapper<void> res) {
      if(res.isSuccess) {
        completer.complete(StatusWrapper(status: Status.SUCCESS,));
      } else {
        completer.complete(StatusWrapper(status: Status.ERROR, error: res.message),);
      }
    });

    return completer.future;
  }
}
