class ProductList {
  int? id;
  String? userId;
  String? group;
  String? brand;
  String? name;
  String? desciption;
  String? image;
  String? unitType;
  var price;
  int? isTax;
  int? tax;
  int? isWeight;
  int? weight;
  int? stock;
  int? trash;
  String? createdAt;
  String? updatedAt;
  String? groupName;
  String? brandName;
  String? imageBase;

  ProductList(
      {this.id,
      this.userId,
      this.group,
      this.brand,
      this.name,
      this.desciption,
      this.image,
      this.unitType,
      this.price,
      this.isTax,
      this.tax,
      this.isWeight,
      this.weight,
      this.stock,
      this.trash,
      this.createdAt,
      this.updatedAt,
      this.groupName,
      this.brandName,
      this.imageBase});

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    group = json['group'];
    brand = json['brand'];
    name = json['name'];
    desciption = json['desciption'];
    image = json['image'];
    unitType = json['unit_type'];
    price = json['price'];
    isTax = json['is_tax'];
    tax = json['tax'];
    isWeight = json['is_weight'];
    weight = json['weight'];
    stock = json['stock'];
    trash = json['trash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    groupName = json['group_name'];
    brandName = json['brand_name'];
    imageBase = json['image_base'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['group'] = this.group;
    data['brand'] = this.brand;
    data['name'] = this.name;
    data['desciption'] = this.desciption;
    data['image'] = this.image;
    data['unit_type'] = this.unitType;
    data['price'] = this.price;
    data['is_tax'] = this.isTax;
    data['tax'] = this.tax;
    data['is_weight'] = this.isWeight;
    data['weight'] = this.weight;
    data['stock'] = this.stock;
    data['trash'] = this.trash;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['group_name'] = this.groupName;
    data['brand_name'] = this.brandName;
    data['image_base'] = this.imageBase;
    return data;
  }
}
