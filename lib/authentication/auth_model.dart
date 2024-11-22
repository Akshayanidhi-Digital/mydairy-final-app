class SignUpModel {
  String? name;
  String? mobile;
  String? countryCode;
  String? password;
  String? confirmPassword;
  int? acceptTerms;

  SignUpModel(
      {this.name,
      this.mobile,
      this.countryCode,
      this.password,
      this.confirmPassword,
      this.acceptTerms});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['country_code'] = this.countryCode;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    data['accept_terms'] = this.acceptTerms;
    return data;
  }
}

class QrModel {
  String? browserId;
  String? browserName;

  QrModel({this.browserId, this.browserName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['browser_id'] = this.browserId;
    data['browser_name'] = this.browserName;
    return data;
  }
}

class LoginModel {
  String? countryCode;
  String? mobile;
  String? password;
  String? type;
  String? accountType;
  String? otp;
  String? fcm_token;

  LoginModel(
      {this.countryCode,
      this.mobile,
      this.password,
      this.otp,
      this.type,
      this.accountType,
      this.fcm_token});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['type'] = this.type;
    data['otp'] = this.otp;
    data['account_type'] = this.accountType;
    data['fcm_token'] = this.fcm_token;
    return data;
  }
}

class OtpAndResetModel {
  String? countryCode;
  String? mobile;
  String? account_type;

  OtpAndResetModel({this.countryCode = "+91", this.mobile, this.account_type});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['account_type'] = this.account_type;
    return data;
  }
}

class OnBoardModel {
  String? fatherName;
  String? dairyName;
  String? address;
  String? latitude;
  String? longitude;
  String? fcm_token;

  OnBoardModel(
      {this.fatherName,
      this.dairyName,
      this.address,
      this.latitude,
      this.longitude,
      this.fcm_token});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['father_name'] = this.fatherName;
    data['dairy_name'] = this.dairyName;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['fcm_token'] = this.fcm_token;
    return data;
  }
}
