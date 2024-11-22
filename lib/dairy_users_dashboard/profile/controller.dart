// ignore_for_file: unused_result

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';
import 'package:mydairy/dairy_users_dashboard/model/profile_model.dart';
import 'package:mydairy/export.dart';
import '../../authentication/onboard_screen.dart';
import 'profile_screen.dart';

final dairyListProvider =
    StateProvider.autoDispose<ProfileModel>((ref) => ProfileModel.fromJson({}));

final profileApiProvider =
    FutureProvider.autoDispose<ProfileModel>((ref) async {
  // ref.keepAlive();
  return ProfileApiNotifier(ref).profileApi();
});

final profileProvider =
    StateNotifierProvider.autoDispose((ref) => ProfileApiNotifier(ref));

class ProfileApiNotifier extends StateNotifier {
  Ref ref;
  ProfileApiNotifier(this.ref) : super('');
  TextEditingController nameController = TextEditingController();
  TextEditingController fathernameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dairyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  profileData({ProfileModel? data}) {
    Future(() {
      nameController.text = data!.name.toString();
      fathernameController.text = data.fatherName.toString();
      mobileController.text = data.mobile.toString();
      dairyNameController.text = data.profile!.dairyName.toString();
      emailController.text = data.email.toString();
      addressController.text = data.profile!.address.toString();
    });
  }

  Future<ProfileModel> profileApi() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.profileget);

    if (response.success == true) {
      if (response.data['profile'] == null) {
        return navigationRemoveUntil(OnboardScreen());
      } else {
        final lst = ref.read(dairyListProvider.notifier).state =
            ProfileModel.fromJson(response.data);
        return lst;
      }
    } else {
      errorSnacMsg(response);
      return ProfileModel.fromJson({});
    }
  }

  Future profileUpdateApi({File? image}) async {
    FormData data = FormData.fromMap(ProfileEditModel(
      countryCode: '+91',
      latitude: 'p',
      longitude: 'p'.trim(),
      name: tt(nameController),
      fathername: tt(fathernameController),
      mobile: tt(mobileController),
      dairyname: tt(dairyNameController),
      email: tt(emailController),
      address: tt(addressController),
      profileImage: image != null
          ? await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last)
          : null,
    ).toJson());
    print("res...${data}");
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.profileUpdate, data: data);

    if (response.success == true) {
      ref.refresh(profileApiProvider);
      navigationTo(const ProfileScreen());
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  @override
  void dispose() {
    state = '';
    super.dispose();
  }
}

listtilefn({IconData? icon, String? text, widgets, String? title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RSizedBox(height: 5.sp),
      Padding(
        padding: EdgeInsets.only(left: 50.sp),
        child: Text(
          title!,
          style: TextStyle(color: AppColor.blackClr),
        ),
      ),
      RSizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RSizedBox(width: 10.sp),
            Icon(
              icon,
              color: AppColor.appColor,
              size: 30,
            ),
            RSizedBox(width: 15.sp),
            Expanded(
              child: Text(
                // overflow: TextOverflow.ellipsis,
                "$text",
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ],
        ),
        // height: 60.sp,
        // child: ListTile(
        //   dense: true,
        //   leading: Icon(
        //     icon,
        //     color: AppColor.appColor,
        //     size: 30,
        //   ),
        //   title: Text(
        //     // overflow: TextOverflow.ellipsis,
        //     "$text",
        //     style: TextStyle(fontSize: 20.sp),
        //   ),
        // ),
      ),
    ],
  );
}
