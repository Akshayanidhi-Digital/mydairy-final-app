import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import 'package:mydairy/farmer_buyer_dashboard/profile/FarmerProfile.dart';

import '../../authentication/check_user.dart';
import '../../dairy_users_dashboard/model/farmer_buyer_profile_model.dart';
import '../../farmer_buyer_dashboard/home/controller.dart';
import '../../farmer_buyer_dashboard/home/farmer_home_screen.dart';
import '../../farmer_buyer_dashboard/entry/FarmerEntryRecords.dart';
import 'respond.dart';

Future<Respond> checkStatus(Response response) async {
  log("Url....${response.realUri}");
  log("StatusCode....${response.statusCode}");
  final statusCode = response.statusCode;
  if (statusCode == 200 ||
      statusCode == 201 ||
      statusCode == 202 ||
      statusCode == 204) {
    return Respond.fromJson(response.data);
  } else if (statusCode == 401) {
    navigationRemoveUntil(const UserCheckLoginScreen());
    MyStorage().deleteAll();
    snackBarMessage(
        msg: "Unauthorized: Please log in to access this resource",
        color: AppColor.redClr);
    return Respond(success: false, message: Msg.somethingWrong, data: null);
  } else {
    // DioHandling().dioStatus(response.statusCode ?? 0);
    return Respond(success: false, message: Msg.somethingWrong, data: null);
  }
}

String language = 'en';
tokenWatch(Ref ref) async {
  Map<String, String> _token = {};
  final tkn = await ref.watch(storageProvider).readData(Secure.token);
  _token['Authorization'] = 'Bearer $tkn';
  _token['Accept'] = 'application/json';
  _token['Accept-Language'] = language;
  return _token;
}

tt(TextEditingController name) {
  return name.text.trim();
}

String df(String value) {
  return double.parse(value.toString()).toStringAsFixed(2);
}

class FunctionClass {
  FunctionClass();
  static navi() {
    return null;
  }

  static navigateToProfile() {
    navigationTo(Farmerprofile(farmer: farmer));
  }

  static navigateToRecods() {
    if (dairy_list.length > 1) {
      showDialog(
        context: Keys.navigatorKey().currentState!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text("Select Dairy")),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: dairy_list.map((DairyList? dairy) {
                  return Column(children: [
                    RSizedBox(height: 10.h),
                    Container(
                        decoration: BoxDecoration(
                          color: AppColor.appColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                            title: Text(dairy!.dairyName!),
                            onTap: () {
                              navigationTo(Farmerentryrecords(
                                  farmer: farmer,
                                  title: dairy.dairyName!,
                                  dairy_id: dairy.userId!));
                            }))
                  ]);
                }).toList(),
              ),
            ),
          );
        },
      );
    } else {
      navigationTo(Farmerentryrecords(
          farmer: farmer, title: dairy_list.first.dairyName));
    }
  }
}
