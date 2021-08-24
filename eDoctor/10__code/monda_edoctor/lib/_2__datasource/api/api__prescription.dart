import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as _;
import 'package:http_parser/http_parser.dart';
import 'package:monda_edoctor/_0__infra/api_endpoint.dart';
import 'package:monda_edoctor/_0__infra/util/ResponseWrapper.dart';
import 'package:monda_edoctor/_0__infra/util/api_datasource.dart';
import 'package:monda_edoctor/_0__infra/util/template_string.dart';
import 'package:monda_edoctor/_0__infra/util/util__api.dart';
import 'package:monda_edoctor/_1__model/prescription.dart';
import 'package:monda_edoctor/_4__presentation/page/_4__prescription/controller__add_prescription.dart';

class PrescriptionApi extends ApiDataSource {
  static PrescriptionApi get instance => _.Get.find();

  PrescriptionApi.newInstance();

  // ===========================================================================
  Future<ResponseWrapper<List<Prescription>>> getLastPrescriptionByPatient({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.LAST_PRESCRIPTION_PATIENT, params: {'patientId': patientId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Prescription>>.success(data: (json['data'] as List).map((e) => Prescription.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<List<Prescription>>> getCurrentPrescriptionByPatient({required String patientId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.CURRENT_PRESCRIPTION_PATIENT, params: {'patientId': patientId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Prescription>>.success(data: (json['data'] as List).map((e) => Prescription.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<Prescription>> getPrescriptionById({required String prescriptionId}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PRESCRIPTION_SEARCH_BY_ID, params: {'prescriptionId': prescriptionId}).toString();
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Prescription>.success(data: Prescription.buildDetail(json['data']));
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }

  // ===========================================================================
  Future<ResponseWrapper<Prescription>> newPrescription({required String doctorId, required String patientId, required String diagnosisId, required String illnessSeverity, required String notes, required List<TreatmentItem> treatmentItemList, File? attachmentFile, String? appointmentId,}) async {
    String url = TemplateString(stringWithParams: ApiEndPoint.PRESCRIPTION_NEW, params: {'doctorId': doctorId, 'patientId': patientId, }).toString();
    var data = {
      'diagnosisId': diagnosisId,
      'illnessSeverity': illnessSeverity,
      'notes': notes,
      'treatmentItemList': treatmentItemList,
      'appointmentId': appointmentId,
    };

    // ===========================================================================
    FormData formData = FormData.fromMap({
      'data': MultipartFile.fromString(jsonEncode(data), contentType: MediaType('application', 'json')),
      if(attachmentFile != null) 'fileAttachment': await MultipartFile.fromFile(attachmentFile.path),
    });
    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<Prescription>.success(data: Prescription.buildDetail(json['data']));
    };

    return ApiUtil.postWithFormData(url: url, responseDataBuilder: responseDataBuilder, options: options, formData: formData);
  }

  // ===========================================================================
  Future<ResponseWrapper<List<Prescription>>> getSearchPrescription({required String doctorId, required int page, required int itemPerPage, String? queryValue,}) async {
    String url;
    if(queryValue == null) {
      url = TemplateString(stringWithParams: ApiEndPoint.PRESCRIPTION_LIST, params: {
        'doctorId': doctorId,
        'page': page.toString(),
        'itemPerPage': itemPerPage.toString(),
      }).toString();
    } else {
      url = TemplateString(stringWithParams: ApiEndPoint.PRESCRIPTION_SEARCH, params: {
        'doctorId': doctorId,
        'page': page.toString(),
        'itemPerPage': itemPerPage.toString(),
        'queryValue': queryValue,
      }).toString();
    }

    var options = await ApiUtil.generateDioOptions();
    var responseDataBuilder = (Map<String, dynamic> json) {
      return ResponseWrapper<List<Prescription>>.success(data: (json['data'] as List).map((e) => Prescription.buildDetail(e)).toList());
    };

    return ApiUtil.get(url: url, options: options, responseDataBuilder: responseDataBuilder);
  }
}
