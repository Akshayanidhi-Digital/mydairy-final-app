class PlanPurchageListModel {
  int? id;
  String? planId;
  String? userId;
  String? paymentId;
  String? tnxId;
  String? paymentMethod;
  int? paymentStatus;
  double? amount;
  String? startDate;
  String? endDate;
  int? status;
  String? createdAt;
  String? updatedAt;
  Plan? plan;

  PlanPurchageListModel(
      {this.id,
      this.planId,
      this.userId,
      this.paymentId,
      this.tnxId,
      this.paymentMethod,
      this.paymentStatus,
      this.amount,
      this.startDate,
      this.endDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.plan});

  PlanPurchageListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'];
    userId = json['user_id'];
    paymentId = json['payment_id'];
    tnxId = json['tnx_id'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    amount = json['amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }
}

class Plan {
  int? id;
  String? planId;
  String? name;
  String? category;
  String? userCount;
  double? price;
  int? duration;
  String? durationType;
  String? description;
  String? status;
  String? farmerCount;
  dynamic moduleAccess;
  String? createdAt;
  String? updatedAt;

  Plan(
      {this.id,
      this.planId,
      this.name,
      this.category,
      this.userCount,
      this.price,
      this.duration,
      this.durationType,
      this.description,
      this.status,
      this.farmerCount,
      this.moduleAccess,
      this.createdAt,
      this.updatedAt});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'];
    name = json['name'];
    category = json['category'];
    userCount = json['user_count'];
    price = json['price'];
    duration = json['duration'];
    durationType = json['duration_type'];
    description = json['description'];
    status = json['status'];
    farmerCount = json['farmer_count'];
    moduleAccess = json['module_access'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
