class ApiConstants {
  static const String baseUrl = 'https://vcare.integration25.com/api';

  // Auth Module
  static const String loginEndPoint = '/auth/login';
  static const String registerEndPoint = '/auth/register';
  static const String logoutEndPoint = '/auth/logout';

  // User Module
  static const String userProfileEndPoint = '/user/profile';
  static const String updateProfileEndPoint = '/user/update';

  // Home Module
  static const String homeEndPoint = '/home/index';

  // Governrate Module
  static const String governrateEndPoint = '/governrate/index';

  // City Module
  static const String cityEndPoint = '/city/index';
  static const String cityByGovEndPoint = '/city/show'; // append /{id}

  // Specialization Module
  static const String specializationEndPoint = '/specialization/index';
  static const String specializationShowEndPoint = '/specialization/show'; // append /{id}

  // Doctor Module
  static const String doctorEndPoint = '/doctor/index';
  static const String doctorShowEndPoint = '/doctor/show'; // append /{id}
  static const String doctorFilterEndPoint = '/doctor/doctor-filter';
  static const String doctorSearchEndPoint = '/doctor/doctor-search';

  // Appointment Module
  static const String appointmentEndPoint = '/appointment/index';
  static const String storeAppointmentEndPoint = '/appointment/store';
}