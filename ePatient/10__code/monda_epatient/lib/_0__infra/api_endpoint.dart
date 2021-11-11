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
  static const String APPOINTMENT_MAKE_NEW = PREFIX + '/appointment';
}
