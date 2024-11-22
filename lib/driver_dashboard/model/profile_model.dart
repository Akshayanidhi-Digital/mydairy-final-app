class DriverProfileModel {
  String? userId;
  String? name;
  String? fatherName;
  String? countryCode;
  String? mobile;
  String? email;

  DriverProfileModel(
      {this.userId,
      this.name,
      this.fatherName,
      this.countryCode,
      this.mobile,
      this.email});

  DriverProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['driver_id'];
    name = json['name'];
    fatherName = json['father_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_id'] = this.userId;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}
