class RecordsModel {
  int? id;
  String? sellerId;
  String? buyerId;
  int? milkType;
  String? shift;
  dynamic quantity;
  dynamic fat;
  dynamic snf;
  dynamic clr;
  int? bonus;
  dynamic price;
  dynamic totalPrice;
  String? date;
  SellerData? customer;
  // SellerData? buyer;

  RecordsModel(
      {this.id,
      this.sellerId,
      this.buyerId,
      this.milkType,
      this.shift,
      this.quantity,
      this.fat,
      this.snf,
      this.clr,
      this.bonus,
      this.price,
      this.totalPrice,
      this.date,
      this.customer
      });

  RecordsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    buyerId = json['buyer_id'];
    milkType = json['milk_type'];
    shift = json['shift'];
    quantity = json['quantity'];
    fat = json['fat'];
    snf = json['snf'];
    clr = json['clr'];
    bonus = json['bonus'];
    price = json['price'];
    totalPrice = json['total_price'];
    date = json['date'];
    // seller =
    //     json['seller'] != null ? SellerData.fromJson(json['seller']) : null;
    customer = json['costumer'] != null ? SellerData.fromJson(json['costumer']) : null;
  }
}

class SellerData {
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

  SellerData(
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
      this.updatedAt});

  SellerData.fromJson(Map<String, dynamic> json) {
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
  }
}
