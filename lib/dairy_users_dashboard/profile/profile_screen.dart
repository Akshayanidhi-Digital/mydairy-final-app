import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import 'package:mydairy/export.dart';

import 'profile_edit_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dairyListProvider);

    final profileBuild = ref.watch(profileApiProvider);
    return Scaffold(
      appBar: BaseAppBar(
        centerTitle: true,
        title: "Profile",
        actionList: [
          Padding(
            padding: EdgeInsets.only(right: 15.sp),
            child: buttonContainer(
                color: AppColor.whiteClr,
                onTap: () => navigationTo(ProfileEditScreen(data: data)),
                hight: 30.0.h,
                width: 60.sp,
                txtColor: AppColor.blackClr,
                txt: "Edit"),
          )
        ],
      ),
      body: LoadingdataScreen(
        varBuild: profileBuild,
        data: (mydata) => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.appColor,
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.elliptical(200, 90))),
                  height: 201.h,
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      showImageViewer(
                          useSafeArea: true,
                          backgroundColor: Colors.white60,
                          context,
                          NetworkImage(
                              Url.image + data.profile!.imagePath.toString(),
                              scale: 0.10),
                          swipeDismissible: true,
                          closeButtonColor: AppColor.blackClr,
                          doubleTapZoomable: true);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          Url.image + data.profile!.imagePath.toString()),
                    ),
                  ))),
              RSizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(children: [
                  listtilefn(
                      title: "Name", icon: Icons.person, text: data.name),
                  Divider(color: AppColor.appColor),
                  listtilefn(
                      title: "Father Name",
                      icon: Icons.person,
                      text: data.fatherName),
                  Divider(color: AppColor.appColor),
                  listtilefn(
                      title: "Mobile Number",
                      icon: Icons.phone_android,
                      text: data.mobile),
                  Divider(color: AppColor.appColor),
                  listtilefn(
                      title: "Dairy Name",
                      icon: Icons.home,
                      text: data.profile!.dairyName),
                  Divider(color: AppColor.appColor),
                  listtilefn(
                      title: "Email", icon: Icons.email, text: data.email),
                  Divider(color: AppColor.appColor),
                  listtilefn(
                      title: "Address",
                      icon: Icons.location_on,
                      text: data.profile!.address == null
                          ? ""
                          : data.profile!.address.toString()),
                  Divider(color: AppColor.appColor),
                  // listtilefn(
                  //     icon: Icons.password,
                  //     text: "password",
                  //     trailing:
                  //         const Image(image: AssetImage(Img.password))),
                  // Divider(color: AppColor.appColor),
                  RSizedBox(height: 60.h),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
