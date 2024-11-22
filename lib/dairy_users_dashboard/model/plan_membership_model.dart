class MemberShipModel {
  final int? id;
  final String? planId;
  final String? name;
  final String? category;
  final String? userCount;
  final double? price;
  final int? duration;
  final String? durationType;
  final String? description;
  final String? status;
  final String? farmerCount;
  final dynamic moduleAccess;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  MemberShipModel({
    required this.id,
    required this.planId,
    required this.name,
    required this.category,
    required this.userCount,
    required this.price,
    required this.duration,
    required this.durationType,
    required this.description,
    required this.status,
    required this.farmerCount,
    required this.moduleAccess,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MemberShipModel.fromJson(Map<String, dynamic> json) {
    return MemberShipModel(
      id: json["id"] ?? '',
      planId: json["plan_id"] ?? "",
      name: json["name"] ?? '',
      category: json["category"] ?? '',
      userCount: json["user_count"] ?? '',
      price: json["price"] ?? 0.0,
      duration: json["duration"] ?? '',
      durationType: json["duration_type"] ?? '',
      description: json["description"],
      status: json["status"] ?? '',
      farmerCount: json["farmer_count"] ?? '',
      moduleAccess: json["module_access"] ?? '',
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
