class RouteLstModel {
  RouteLstModel({
    this.id,
    this.routeId,
    this.parentId,
    this.routeName,
    this.isAssigned,
    this.transporterId,
    this.isDriver,
    this.driverId,
    this.createdAt,
    this.updatedAt,
    this.driver,
  });

  int? id;
  String? routeId;
  String? parentId;
  String? routeName;
  int? isAssigned;
  dynamic transporterId;
  int? isDriver;
  dynamic driverId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic driver;

  factory RouteLstModel.fromJson(Map<String, dynamic> json) {
    return RouteLstModel(
      id: json["id"],
      routeId: json["route_id"],
      parentId: json["parent_id"],
      routeName: json["route_name"],
      isAssigned: json["is_assigned"],
      transporterId: json["transporter_id"],
      isDriver: json["is_driver"],
      driverId: json["driver_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      driver: json["driver"],
    );
  }
}
