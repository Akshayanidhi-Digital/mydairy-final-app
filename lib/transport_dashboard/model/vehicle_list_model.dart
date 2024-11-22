class VehicleListModel {
  int? id;
  String? transporterId;
  String? driverId;
  String? vehicleNumber;
  String? unit;
  int? capacity;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Driver? driver;

  VehicleListModel(
      {this.id,
      this.transporterId,
      this.driverId,
      this.vehicleNumber,
      this.unit,
      this.capacity,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.driver});

  VehicleListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transporterId = json['transporter_id'];
    driverId = json['driver_id'];
    vehicleNumber = json['vehicle_number'];
    unit = json['unit'];
    capacity = json['capacity'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transporter_id'] = this.transporterId;
    data['driver_id'] = this.driverId;
    data['vehicle_number'] = this.vehicleNumber;
    data['unit'] = this.unit;
    data['capacity'] = this.capacity;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    return data;
  }
}

class Driver {
  int? id;
  String? transporterId;
  String? driverId;
  String? name;
  String? fatherName;
  String? countryCode;
  String? mobile;
  String? email;
  int? isVerified;
  int? isBlocked;
  String? createdAt;
  String? updatedAt;

  Driver(
      {this.id,
      this.transporterId,
      this.driverId,
      this.name,
      this.fatherName,
      this.countryCode,
      this.mobile,
      this.email,
      this.isVerified,
      this.isBlocked,
      this.createdAt,
      this.updatedAt});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transporterId = json['transporter_id'];
    driverId = json['driver_id'];
    name = json['name'];
    fatherName = json['father_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    email = json['email'];
    isVerified = json['is_verified'];
    isBlocked = json['is_blocked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transporter_id'] = this.transporterId;
    data['driver_id'] = this.driverId;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['is_verified'] = this.isVerified;
    data['is_blocked'] = this.isBlocked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
