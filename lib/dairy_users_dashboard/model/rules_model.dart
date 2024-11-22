class RulesModel {
  List<RulesData>? data;

  RulesModel({this.data});

  RulesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RulesData>[];
      json['data'].forEach((v) {
        data!.add(new RulesData.fromJson(v));
      });
    }
  }
}

class RulesData {
  String? roleId;
  String? shortName;
  String? name;

  RulesData({this.roleId, this.shortName, this.name});

  RulesData.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    shortName = json['short_name'];
    name = json['name'];
  }
}
