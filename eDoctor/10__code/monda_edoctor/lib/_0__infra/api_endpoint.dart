class ApiEndPoint {
  ApiEndPoint._();

  // static const String PREFIX = 'http://ec2-3-14-87-205.us-east-2.compute.amazonaws.com:3005/v1';

  static const String PREFIX = 'http://192.168.0.101:3005/v1';

  // =================================================================== Account
  static const String LOGIN = PREFIX + '/doctor/login';

  static const String CHANGE_PASSWORD = PREFIX + '/doctors/{doctorId}/update-password';

  // =================================================================== Patient
  static const String PATIENT_SUMMARY = PREFIX + '/doctors/{doctorId}/patients/summary';

  static const String PATIENT_SEARCH = PREFIX + '/patients/search?query={queryValue}&field={field}';

  static const String PATIENT_DETAIL = PREFIX + '/doctors/{doctorId}/patients/{patientId}/details';

  static const String PATIENT_REGISTRATION = PREFIX + '/doctors/{doctorId}/patients/register';

  static const String PATIENT_UPDATE_HEALTH_PROFILE = PREFIX + '/patients/update-profile-health';

  // ================================================================= Inventory
  static const String INVENTORY_LIST_PER_PAGE = PREFIX + '/doctors/{doctorId}/inventory?page={page}&itemPerPage={itemPerPage}';

  static const String INVENTORY_LIST_AVAILABLE = PREFIX + '/doctors/{doctorId}/inventory/available';

  static const String INVENTORY_SEARCH = PREFIX + '/doctors/{doctorId}/inventory?page={page}&itemPerPage={itemPerPage}&query={queryValue}&field={field}';

  static const String INVENTORY_DETAIL = PREFIX + '/doctors/{doctorId}/inventory/{inventoryId}';
  
  static const String INVENTORY_BATCH_NEW = PREFIX + '/doctors/{doctorId}/inventory/batch';

  static const String INVENTORY_BATCH_UPDATE = PREFIX + '/doctors/{doctorId}/inventory/batch/{inventoryBatchId}';

  // ====================================================================== Drug
  static const String DRUG_SEARCH = PREFIX + '/drug?name={name}';

  // ================================================================= Diagnosis
  static const String DIAGNOSIS_LIST = PREFIX + '/diagnosis?name={name}';

  // ============================================================== Prescription
  static const String PRESCRIPTION_NEW = PREFIX + '/doctors/{doctorId}/patients/{patientId}/prescription';

  static const String PRESCRIPTION_SEARCH_BY_ID = PREFIX + '/prescription/{prescriptionId}';

  static const String LAST_PRESCRIPTION_PATIENT = PREFIX + '/patients/{patientId}/last-prescription';

  static const String CURRENT_PRESCRIPTION_PATIENT = PREFIX + '/patients/{patientId}/current-prescription';

  static const String PRESCRIPTION_LIST = PREFIX + '/doctors/{doctorId}/prescription?page={page}&itemPerPage={itemPerPage}';

  static const String PRESCRIPTION_SEARCH = PREFIX + '/doctors/{doctorId}/prescription?page={page}&itemPerPage={itemPerPage}&query={queryValue}';

  // ==================================================================== Doctor
  static const String DOCTOR_PROFILE = PREFIX + '/doctors/{doctorId}/profile';

  static const String DOCTOR_APPOINTMENT_PAST = PREFIX + '/doctors/{doctorId}/appointment/past';

  static const String DOCTOR_APPOINTMENT_UPCOMING = PREFIX + '/doctors/{doctorId}/appointment/upcoming';

  static const String APPOINTMENT_UPDATE = PREFIX + '/doctors/{doctorId}/appointment/{appointmentId}';

  // ==================================================================== Attachment
  static const String DOWNLOAD_ATTACHMENT = PREFIX + '/download/{attachmentId}';
}
