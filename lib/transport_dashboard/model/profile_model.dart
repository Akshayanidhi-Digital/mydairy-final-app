class TransporterProfileModel {
  String? userId;
  String? transporterName;
  String? name;
  String? fatherName;
  String? countryCode;
  String? mobile;
  String? email;

  TransporterProfileModel(
      {this.userId,
      this.transporterName,
      this.name,
      this.fatherName,
      this.countryCode,
      this.mobile,
      this.email});

  TransporterProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    transporterName = json['transporter_name'];
    name = json['name'];
    fatherName = json['father_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['transporter_name'] = this.transporterName;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}
