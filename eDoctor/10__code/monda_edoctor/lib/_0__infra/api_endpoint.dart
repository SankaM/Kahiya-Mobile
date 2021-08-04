class ApiEndPoint {
  ApiEndPoint._();

  // static const String PREFIX = 'http://ec2-3-14-87-205.us-east-2.compute.amazonaws.com:3005/v1';

  static const String PREFIX = 'http://192.168.0.8:3005/v1';

  static const String LOGIN = PREFIX + '/doctor/login';

  // Patient
  static const String PATIENT_SUMMARY = PREFIX + '/doctors/{doctorId}/patients/summary';

  static const String PATIENT_SEARCH = PREFIX + '/patients/search?query={queryValue}&field={field}';

  static const String PATIENT_DETAIL = PREFIX + '/doctors/{doctorId}/patients/{patientId}/details';

  static const String PATIENT_REGISTRATION = PREFIX + '/doctors/{doctorId}/patients/register';

  // Inventory
  static const String INVENTORY_ALL_PER_PAGE = PREFIX + '/doctors/{doctorId}/inventory?page={page}&itemPerPage={itemPerPage}';

  static const String INVENTORY_SEARCH = PREFIX + '/doctors/{doctorId}/inventory?page={page}&itemPerPage={itemPerPage}&query={queryValue}&field={field}';

  static const String INVENTORY_ALL = PREFIX + '/doctors/{doctorId}/inventory/all';

  static const String INVENTORY_NEW_BATCH = PREFIX + '/doctors/{doctorId}/inventory/batch';

  static const String INVENTORY_DETAIL = PREFIX + '/doctors/{doctorId}/inventory/{inventoryId}';

  // Drug
  static const String DRUG_SEARCH = PREFIX + '/drug?name={name}';

  // Diagnosis
  static const String DIAGNOSIS_LIST = PREFIX + '/diagnosis';

  // Prescription
  static const String NEW_PRESCRIPTION = PREFIX + '/doctors/{doctorId}/patients/{patientId}/prescription';

  static const String PRESCRIPTION_BY_ID = PREFIX + '/prescription/{prescriptionId}';

  static const String PRESCRIPTION_BY_PATIENT = PREFIX + '/patients/{patientId}/history';

  static const String PRESCRIPTION_ALL_PER_PAGE = PREFIX + '/doctors/{doctorId}/prescription?page={page}&itemPerPage={itemPerPage}';

  static const String PRESCRIPTION_SEARCH = PREFIX + '/doctors/{doctorId}/prescription?page={page}&itemPerPage={itemPerPage}&query={queryValue}';
}
