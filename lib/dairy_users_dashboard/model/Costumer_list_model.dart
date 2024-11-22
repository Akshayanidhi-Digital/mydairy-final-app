class CostumerModel {
  dynamic costumer_id;
  String? name;
  String? fatherName;
  String? countryCode;
  String? mobile;
  String? email;
  var isFixedRate;
  var fixedRateType;
  var rate;
  var fatRate;

  CostumerModel(
      {this.costumer_id,
      this.name,
      this.fatherName,
      this.countryCode,
      this.mobile,
      this.email,
      this.isFixedRate,
      this.fixedRateType,
      this.rate,
      this.fatRate});

  CostumerModel.fromJson(Map<String, dynamic> json) {
    costumer_id = json['user_id'];
    name = json['name'] ?? '';
    fatherName = json['father_name'] ?? '';
    countryCode = json['country_code'] ?? '';
    mobile = json['mobile'] ?? '';
    email = json['email'] ?? '';
    isFixedRate = json['is_fixed_rate'];
    fixedRateType = json['fixed_rate_type'] ?? '';
    rate = json['rate'] ?? '';
    fatRate = json['fat_rate'] ?? '';
  }
}
