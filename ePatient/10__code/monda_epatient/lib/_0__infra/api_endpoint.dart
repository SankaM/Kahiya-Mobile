class ApiEndPoint {
  ApiEndPoint._();

  static const String PREFIX = 'http://192.168.0.101:3005/v1';

  // =================================================================== Account
  static const String LOGIN = PREFIX + '/patient/login';

  static const String SIGNUP = PREFIX + '/patient/signup';

  // =================================================================== Doctors
  static const String DOCTORS__FIND_ALL = PREFIX + '/doctors';

  static const String DOCTORS__SEARCH = PREFIX + '/doctors/search?query={queryValue}&field={field}';

  static const String DOCTORS__PROFILE = PREFIX + '/doctors/{doctorId}/profile';

  static const String DOCTORS__WORK_HOURS = PREFIX + '/doctors/{doctorId}/work-hours';

  static const String DOCTORS__STATISTIC = PREFIX + '/doctors/{doctorId}/statistic';

  // =============================================================== Appointment
  static const String APPOINTMENT__MAKE_NEW = PREFIX + '/appointment';

  static const String APPOINTMENT__UPCOMING_LIST = PREFIX + '/patient/{patientId}/appointment/upcoming';

  static const String APPOINTMENT__PAST_LIST = PREFIX + '/patient/{patientId}/appointment/past';

  static const String APPOINTMENT__CANCEL = PREFIX + '/patient/{patientId}/appointment/{appointmentId}';

  // =========================================================== Medical Records
  static const String PATIENT__DETAIL = PREFIX + '/patient/{patientId}';

  static const String PATIENT__CURRENT_PRESCRIPTION = PREFIX + '/patient/{patientId}/prescription/current';

  static const String PATIENT__PAST_PRESCRIPTION = PREFIX + '/patient/{patientId}/prescription/past';
}
