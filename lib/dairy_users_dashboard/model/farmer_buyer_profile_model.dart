class FarmerBuyerData {
  int? id;
  int? farmerId;
  String? name;
  String? fatherName;
  String? countryCode;
  String? mobile;
  String? email;
  String? parentId;
  int? isFixedRate;
  int? fixedRateType;
  int? rate;
  dynamic fatRate;
  String? createdAt;
  String? updatedAt;
  List<DairyList>? dairyList;
  String? dairy;
  DairyMob? dairyMob;

  FarmerBuyerData(
      {this.id,
      this.farmerId,
      this.name,
      this.fatherName,
      this.countryCode,
      this.mobile,
      this.email,
      this.parentId,
      this.isFixedRate,
      this.fixedRateType,
      this.rate,
      this.fatRate,
      this.createdAt,
      this.updatedAt,
      this.dairyList,
      this.dairy,
      this.dairyMob});

  FarmerBuyerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    name = json['name'];
    fatherName = json['father_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    email = json['email'];
    parentId = json['parent_id'];
    isFixedRate = json['is_fixed_rate'];
    fixedRateType = json['fixed_rate_type'];
    rate = json['rate'];
    fatRate = json['fat_rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['dairy_list'] != null) {
      dairyList = <DairyList>[];
      json['dairy_list'].forEach((v) {
        dairyList!.add(new DairyList.fromJson(v));
      });
    }
    dairy = json['dairy'];
    dairyMob = json['dairy_mob'] != null
        ? new DairyMob.fromJson(json['dairy_mob'])
        : null;
  }
}

class DairyList {
  String? userId;
  String? dairyName;

  DairyList({this.userId, this.dairyName});

  DairyList.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    dairyName = json['dairy_name'];
  }
}

class DairyMob {
  String? mobile;
  String? countryCode;

  DairyMob({this.mobile, this.countryCode});

  DairyMob.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    countryCode = json['country_code'];
  }
}
