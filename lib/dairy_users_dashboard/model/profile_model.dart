import 'package:dio/dio.dart';

class ProfileModel {
  int? id;
  String? userId;
  dynamic parentId;
  String? name;
  String? countryCode;
  String? mobile;
  String? email;
  int? isVerified;
  int? isBlocked;
  String? planId;
  String? planCreated;
  String? planExpired;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? fatherName;
  String? roleName;
  String? accessToken;
  List<Costumers>? costumers;
  Profile? profile;

  ProfileModel(
      {this.id,
      this.userId,
      this.parentId,
      this.name,
      this.countryCode,
      this.mobile,
      this.email,
      this.isVerified,
      this.isBlocked,
      this.planId,
      this.planCreated,
      this.planExpired,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.fatherName,
      this.roleName,
      this.costumers,
      this.accessToken,
      this.profile});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    parentId = json['parent_id'];
    name = json['name'] ?? 'user';
    countryCode = json['country_code'];
    mobile = json['mobile'] ?? '';
    email = json['email'] ?? '';
    isVerified = json['is_verified'];
    isBlocked = json['is_blocked'];
    planId = json['plan_id'];
    planCreated = json['plan_created'];
    planExpired = json['plan_expired'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fatherName = json['father_name'] ?? '';
    roleName = json['role_name'];
    accessToken = json['access_token'];
    if (json['costumers'] != null) {
      costumers = <Costumers>[];
      json['costumers'].forEach((v) {
        costumers!.add(new Costumers.fromJson(v));
      });
    }
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }
}

class Costumers {
  String? userType;
  String? name;

  Costumers({this.userType, this.name});

  Costumers.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'] ?? '';
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['name'] = this.name;
    return data;
  }
}

class Profile {
  int? id;
  String? userId;
  String? dairyName;
  String? image;
  String? address;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  Profile(
      {this.id,
      this.userId,
      this.dairyName,
      this.image,
      this.address,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.imagePath});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    dairyName = json['dairy_name'] ?? 'Dairy Name';
    image = json['image'];
    address = json['address'] ?? '';
    latitude = json['latitude'] ?? '';
    longitude = json['longitude'] ?? '';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = json['image_path'];
  }
}

//! Profile Edit Model ====

class ProfileEditModel {
  String? name;
  String? fathername;
  MultipartFile? profileImage;
  String? countryCode;
  String? mobile;
  String? email;
  String? dairyname;
  String? address;
  String? latitude;
  String? longitude;

  ProfileEditModel(
      {this.name,
      this.fathername,
      this.countryCode,
      this.mobile,
      this.email,
      this.profileImage,
      this.dairyname,
      this.address,
      this.latitude,
      this.longitude});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['father_name'] = this.fathername;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['dairy_name'] = this.dairyname;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.profileImage;
    // this.profileImage != null ? data['image'] = this.imgae : '';

    return data;
  }
}
