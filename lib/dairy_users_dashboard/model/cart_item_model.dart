 class CartItemModel {
  CartItemModel({
    this.id,
    this.userId,
    this.sellerId,
    this.productId,
    this.name,
    this.image,
    this.unitType,
    this.price,
    this.weight,
    this.tax,
    this.discount,
    this.quantity,
    this.total,
    this.select,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? userId;
  final String? sellerId;
  final String? productId;
  final String? name;
  final String? image;
  final String? unitType;
  dynamic price;
  final int? weight;
  dynamic tax;
  dynamic discount;
  late final int? quantity;
  dynamic total;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  bool? select;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json["id"],
      userId: json["user_id"],
      sellerId: json["seller_id"],
      productId: json["product_id"],
      name: json["name"],
      image: json["image"],
      unitType: json["unit_type"],
      price: json["price"],
      weight: json["weight"],
      tax: json["tax"],
      discount: json["discount"],
      quantity: json["quantity"],
      total: json["total"],
      select: json['select'] ?? false,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "seller_id": sellerId,
        "product_id": productId,
        "name": name,
        "image": image,
        "unit_type": unitType,
        "price": price,
        "weight": weight,
        "tax": tax,
        "discount": discount,
        "quantity": quantity,
        "total": total,
        "select": select,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
