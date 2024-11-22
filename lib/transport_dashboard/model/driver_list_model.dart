class DriverListModel {
  DriverListModel({
    this.id,
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
    this.updatedAt,
    this.fcmToken,
  });

  final int? id;
  final String? transporterId;
  final String? driverId;
  final String? name;
  final String? fatherName;
  final String? countryCode;
  final String? mobile;
  final dynamic email;
  final int? isVerified;
  int? isBlocked;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic fcmToken;

  factory DriverListModel.fromJson(Map<String, dynamic> json) {
    return DriverListModel(
      id: json["id"],
      transporterId: json["transporter_id"],
      driverId: json["driver_id"] ?? '',
      name: json["name"] ?? '',
      fatherName: json["father_name"] ?? '',
      countryCode: json["country_code"] ?? '',
      mobile: json["mobile"] ?? '',
      email: json["email"] ?? 'NA',
      isVerified: json["is_verified"],
      isBlocked: json["is_blocked"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      fcmToken: json["fcm_token"] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        "driver_id": driverId,
        "name": name,
        "father_name": fatherName,
        "country_code": countryCode,
        "mobile": mobile,
        "email": email,
      };
}
