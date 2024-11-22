class TranportListModel {
  int? id;
  String? transporterId;
  String? transporterName;
  String? name;
  String? fatherName;
  String? countryCode;
  String? mobile;
  String? email;
  String? password;
  int? isVerified;
  int? isBlocked;
  String? createdAt;
  String? updatedAt;
  String? parentId;

  TranportListModel(
      {this.id,
      this.transporterId,
      this.transporterName,
      this.name,
      this.fatherName,
      this.countryCode,
      this.mobile,
      this.email,
      this.password,
      this.isVerified,
      this.isBlocked,
      this.createdAt,
      this.updatedAt,
      this.parentId});

  TranportListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transporterId = json['transporter_id'];
    transporterName = json['transporter_name'];
    name = json['name'];
    fatherName = json['father_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    email = json['email']??'';
    password = json['password'];
    isVerified = json['is_verified'];
    isBlocked = json['is_blocked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transporter_id'] = this.transporterId;
    data['transporter_name'] = this.transporterName;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['is_verified'] = this.isVerified;
    data['is_blocked'] = this.isBlocked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['parent_id'] = this.parentId;
    return data;
  }
}
