class Url {
  //  developemnt local server
  // static const String Base = "http://192.168.29.243:8000/api/v1/";
  // static const String image = "http://192.168.29.243:8000/";

  // for relase mode
  static const String Base = "https://mydairy.digital/api/v1/";
  static const String image = "https://mydairy.digital/";

  // for dev server
  // static const String Base = "https://development.mydairy.tech/api/v1/";
  // static const String image = "https://development.mydairy.tech/";

//Todo ========================> Base Urls <===========================!
  static const dairy_baseUrl = '${Base}dairy/';
  static const farmer_baseUrl = '${Base}farmer/';
  static const buyer_baseUrl = '${Base}buyer/';
  static const transport_baseUrl = '${Base}transport/';
  static const driver_base = '${Base}driver/';
//Todo ===> Authentication APIs
  static const String otp = "${Base}otp/verify";
  static const String resendOtp = "${Base}otp/resend";
  static const String forget = "${Base}forgot-password";
  static const String checkUser = '${Base}check-user';
  static const String login = '${Base}login';
  static const String passwordUpdate = '${Base}password-update';
  static const String signUp = '${Base}signup';

//?TODO! ============================> Dairy APIs <=============================!

  static const String notification_dairy = "${dairy_baseUrl}user/notification";
  static const String onboard_dairy = "${dairy_baseUrl}user/onboard";
  static const String get_chart = "${dairy_baseUrl}rate-chart";
  static const String rate_chart_update = "${dairy_baseUrl}rate-chart/update";
  static const String uploadChart = "${dairy_baseUrl}rate-chart/upload";
  static const String chart_download = "${dairy_baseUrl}rate-chart/download";
  static const String sample_chart = "${dairy_baseUrl}rate-chart/sample";
  static const String profileget = "${dairy_baseUrl}user/profile";
  static const String profileUpdate = "${dairy_baseUrl}user/profile/update";
  static const String qrLogin = "${dairy_baseUrl}user/qr-login";
  static const String customerList = "${dairy_baseUrl}costumers";
  static const String customerAdd = "${dairy_baseUrl}costumers/add";
  // static const String farmerAdd = "${dairy_baseUrl}farmer/add";
  static const String cutomerUpdate = "${dairy_baseUrl}costumers/update";
  static const String cutomerDelete = "${dairy_baseUrl}costumers/delete";
  static const String farmerList = "${dairy_baseUrl}farmer";
  // static const String farmerDelete = "${dairy_baseUrl}farmer/delete";
  // static const String farmerProfileUpdate = "${dairy_baseUrl}farmer/update";
  static const String rateUpdate = "${dairy_baseUrl}farmer/rate-update";
  static const String productGroupAdd = "${dairy_baseUrl}products/group/add";
  static const String productGroupList = "${dairy_baseUrl}products/group";
  static const String productItem = "${dairy_baseUrl}products";
  static const String productAdd = "${dairy_baseUrl}products/add";
  static const String unitTypeList = "${dairy_baseUrl}products/unit-types";
  static const String productBrandAdd = "${dairy_baseUrl}products/brand/add";
  static const String productBrandList = "${dairy_baseUrl}products/brand";
  static const String productgroup_edit = "${dairy_baseUrl}products/group/edit";
  static const String productBrand_edit = "${dairy_baseUrl}products/brand/edit";
  static const String product_brand_update =
      "${dairy_baseUrl}products/brand/update";
  static const String product_group_update =
      "${dairy_baseUrl}products/group/update";
  static const String shopingList = "${dairy_baseUrl}shopping/products";
  static const String cart_list = "${dairy_baseUrl}shopping/cart";
  static const String cart_add = "${dairy_baseUrl}shopping/cart/add";
  static const String cart_update = "${dairy_baseUrl}shopping/cart/update";
  static const String cart_remove = "${dairy_baseUrl}shopping/cart/remove";
  static const String checkout = "${dairy_baseUrl}shopping/checkout";
  static const String productList = "${dairy_baseUrl}products";
  static const String memberShipPlans = "${dairy_baseUrl}plans";
  static const String planPurchase = "${dairy_baseUrl}plans/purchase";
  static const String milkbuyEntryList = "${dairy_baseUrl}milk/buy";
  static const String milkEntryAddList = "${dairy_baseUrl}milk/buy/add";
  static const String milkEntryAddRate = "${dairy_baseUrl}milk/buy/get-price";
  static const String buyerList = "${dairy_baseUrl}buyer";
  // static const String buyerUpdate = "${dairy_baseUrl}buyer/update";
  static const String buyerRateUpdate = "${dairy_baseUrl}buyer/rate-update";
  // static const String buyerDelete = "${dairy_baseUrl}buyer/delete";
  static const String milksellAdd = "${dairy_baseUrl}milk/sell/add";
  static const String milksellList = "${dairy_baseUrl}milk/sell";
  static const String milksellgetPriceList =
      "${dairy_baseUrl}milk/sell/get-price";
  static const String milksellprintPdf = "${dairy_baseUrl}milk/sell/get-print";
  static const String milkbuyprintPdf = "${dairy_baseUrl}milk/buy/get-print";
  static const String settingGet = "${dairy_baseUrl}user/settings";
  static const String settingUpdate = "${dairy_baseUrl}user/settings/update";
  static const String entryByDate = "${dairy_baseUrl}milk/records";
  static const String entryByDatePrint = "${dairy_baseUrl}milk/records/print";
  static const String milksellDelete = "${dairy_baseUrl}milk/buy/trash";
  static const String milkbuyDelete = "${dairy_baseUrl}milk/sell/trash";
  static const String rulesGet = "${dairy_baseUrl}master/role";
  static const String roleViewGet = "${dairy_baseUrl}master/role/view";
  static const String rulesUpdate = "${dairy_baseUrl}master/role/update";
  static const String transportList = "${dairy_baseUrl}master/transporter";
  static const String routesList = "${dairy_baseUrl}master/routes";
  static const String add_routes = "${dairy_baseUrl}master/routes/add";
  static const String edit_routes = "${dairy_baseUrl}master/routes/update";
  static const String add_transporter =
      "${dairy_baseUrl}master/transporter/add";

  static const String transport_status =
      "${dairy_baseUrl}master/transporter/status-update";
  static const String dairy_help = "${dairy_baseUrl}help";
  static const String plan_puchess_list = "${dairy_baseUrl}plans/purchase/list";
  static const String dairy_list = "${dairy_baseUrl}master/routes/dairy-list";

  //?TODO!========================> Farmer APIs <================================

  static const String farmer_info = '${farmer_baseUrl}info';
  static const String farmer_profile_update = '${farmer_baseUrl}update';
  static const String farmer_record = '${farmer_baseUrl}milk-records';
  static const String farmer_record_counts_per_Year =
      '${farmer_baseUrl}milk-records/count';
  static const String farmer_record_detailed =
      '${farmer_baseUrl}milk-records/detailed';

  //!?TODO!=======================> Buyer APIs <=================================

  static const String buyer_info = '${buyer_baseUrl}info';
  static const String buyer_profile_update = '${buyer_baseUrl}update';
  static const String buyer_record = '${buyer_baseUrl}milk-records';
  static const String buyer_record_counts_per_Year =
      '${buyer_baseUrl}milk-records/count';
  static const String buyer_record_detailed =
      '${buyer_baseUrl}milk-records/detailed';

  //!?TODO!==========================> Transport APIs <==========================
  static const String transport_login = '${transport_baseUrl}login';
  static const String transport_verify = '${transport_baseUrl}verify';
  static const String transport_resend_otp = '${transport_baseUrl}resend-otp';
  static const String transport_forget = '${transport_baseUrl}forgot-password';
  static const String transport_profile = '${transport_baseUrl}profile';
  static const String transport_profile_update =
      '${transport_baseUrl}profile/update';
  static const String tr_password_update =
      '${transport_baseUrl}profile/update-password';
  static const String transport_driver_list = '${transport_baseUrl}driver';

  static const String transport_driver_add = '${transport_baseUrl}driver/add';
  static const String transport_driver_update =
      '${transport_baseUrl}driver/update';
  static const String transport_driver_status_update =
      '${transport_baseUrl}driver/status-update';
  static const String transport_vehicle_list = '${transport_baseUrl}vehicle';
  static const String transport_vehicle_status_update =
      '${transport_baseUrl}vehicle/status-update';
  static const String transport_vehicle_add = '${transport_baseUrl}vehicle/add';
  static const String transport_vehicle_update =
      '${transport_baseUrl}vehicle/update';
  static const String transport_vehical_driver_list =
      '${transport_baseUrl}vehicle/drivers';
  static const String transport_routes_list = '${transport_baseUrl}routes';

  //!?TODO!==========================> Driver APIs <==========================
  static const String driver_login = '${driver_base}login';
  static const String driver_verify = '${driver_base}verify';
  static const String driver_resend_otp = '${driver_base}resend-otp';
  static const String driver_forget = '${driver_base}forgot-password';
  static const String dr_profile = '${driver_base}profile';
  static const String dr_profile_update = '${driver_base}profile/update';

  static const String dr_password_update =
      '${driver_base}profile/update-password';
}
