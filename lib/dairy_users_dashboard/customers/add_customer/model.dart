class CustomerAddModel {
  String? costumertype;
  String? costumer_id;
  String? countryCode;

  String? name;
  String? fatherName;
  String? mobile;
  String? email;
  int? isFixedRate;
  int? fixedRateType;
  String? rate;
  String? fat_rate;

  CustomerAddModel(
      {this.costumertype,
      this.costumer_id,
      this.countryCode,
      this.name,
      this.fatherName,
      this.mobile,
      this.email,
      this.isFixedRate,
      this.fixedRateType,
      this.fat_rate,
      this.rate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['costumer_type'] = this.costumertype;
    data['costumer_id'] = this.costumer_id;
    data['country_code'] = this.countryCode;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['is_fixed_rate'] = this.isFixedRate ?? 0;
    data['fixed_rate_type'] = this.fixedRateType ?? 0;
    data['rate'] = this.rate ?? "";
    data['fat_rate'] = this.fat_rate ?? 0;
    return data;
  }
}
