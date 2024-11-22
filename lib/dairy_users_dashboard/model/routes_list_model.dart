class RouteListModel {
  int? id;
  String? routeId;
  String? parentId;
  String? routeName;
  int? isAssigned;
  String? transporterId;
  int? isDriver;
  dynamic driverId;
  String? createdAt;
  String? updatedAt;
  List<Dairies>? dairies;

  RouteListModel(
      {this.id,
      this.routeId,
      this.parentId,
      this.routeName,
      this.isAssigned,
      this.transporterId,
      this.isDriver,
      this.driverId,
      this.createdAt,
      this.updatedAt,
      this.dairies});

  RouteListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['route_id'];
    parentId = json['parent_id'];
    routeName = json['route_name'];
    isAssigned = json['is_assigned'];
    transporterId = json['transporter_id'] ?? '';
    isDriver = json['is_driver'];
    driverId = json['driver_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['dairies'] != null) {
      dairies = <Dairies>[];
      json['dairies'].forEach((v) {
        dairies!.add(new Dairies.fromJson(v));
      });
    }
  }
}

class Dairies {
  int? id;
  String? dairyId;
  String? routeId;
  String? parentId;
  String? createdAt;
  String? updatedAt;

  Dairies(
      {this.id,
      this.dairyId,
      this.routeId,
      this.parentId,
      this.createdAt,
      this.updatedAt});

  Dairies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dairyId = json['dairy_id'];
    routeId = json['route_id'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
