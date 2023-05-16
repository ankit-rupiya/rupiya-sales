class ApiEndpoints {
  static const String authBaseURL = 'http://test-admin.rupiyatech.link';
  static const String salesBaseURL = 'http://test-agritech.rupiyatech.link';
  // static const String apiKey = '?rupiya_api=jfKeaHiNmdBezUy5FR6pXfOOParDTMcw';
  static const String apiKey = '';
  static const String login = '$authBaseURL/rupiya/v1/login$apiKey';
  static const String logOut =
      '$authBaseURL/rupiya/v1/access/logout_access_key/';
  static const String addCustomerData =
      '$salesBaseURL/rupiya/v1/agri_tech/salesman/add_customer_details$apiKey';
  static const String updateCustomerData =
      '$salesBaseURL/rupiya/v1/agri_tech/salesman/update_customer_details$apiKey';
  static const String salesmanSales =
      '$salesBaseURL/rupiya/v1/agri_tech/salesman/get_salesman_customers_details$apiKey';
  static const String teamSales =
      '$salesBaseURL/rupiya/v1/agri_tech/salesman/get_customers_details$apiKey';
  static const String salesmanLocation =
      '$salesBaseURL/rupiya/v1/agri_tech/salesman/insert_salesman_live_location$apiKey';
  static String usernameList(String role) =>
      '$authBaseURL/rupiya-admin/v1/get_user_name_by_role?admin_role=$role';
  static String locationLogs(String salesman, String date) =>
      '$authBaseURL/rupiya-admin/v1/get_user_location_details_by_date?user_name=$salesman&select_date=$date';
  static String pinData(String pin) =>
      'https://api.postalpincode.in/pincode/$pin';
}
