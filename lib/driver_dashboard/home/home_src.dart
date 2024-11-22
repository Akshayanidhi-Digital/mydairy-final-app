import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import '../../authentication/check_user.dart';
import '../../dairy_users_dashboard/home/home_drawer.dart';
import '../../dairy_users_dashboard/profile/controller.dart';
import '../../transport_dashboard/profile/password_update.dart';
import '../profile/profile_screen.dart';

class DriverHomeScr extends ConsumerWidget {
  const DriverHomeScr({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(dairyListProvider);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColor.appColor, Colors.blue],
              end: Alignment.bottomCenter)),
      child: Column(
        children: [
          RSizedBox(height: 10.h),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Txt.transport,
                        style: TextStyle(
                            color: AppColor.whiteClr,
                            fontSize: 18.w,
                            fontWeight: FontWeight.w500)),
                    IconButton(
                        onPressed: () => navigationPop(),
                        icon: Icon(Icons.close,
                            size: 30.w, color: AppColor.whiteClr))
                  ])),
          user.profile == null
              ? Icon(
                  Icons.person,
                  color: AppColor.whiteClr,
                  size: 100.w,
                )
              : CircleAvatar(
                  radius: 40.w,
                  backgroundImage:
                      NetworkImage(Url.image + user.profile!.imagePath!),
                ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user.name!,
                  style: TextStyle(color: AppColor.whiteClr, fontSize: 18.w))),
          RSizedBox(height: 20.h),
          profileListtile(
              onTap: () {},
              title: Txt.driver,
              image: const Image(
                  image: AssetImage(Img.driver_person),
                  color: AppColor.whiteClr)),
          const Divider(color: AppColor.whiteClr),
          profileListtile(
              onTap: () {},
              title: Txt.vehicle,
              image: const Image(
                  image: AssetImage(Img.vehicle_transport),
                  color: AppColor.whiteClr)),
          const Divider(color: AppColor.whiteClr),
          profileListtile(
              onTap: () {},
              title: Txt.route,
              image: const Image(
                  image: AssetImage(Img.routes_transport),
                  color: AppColor.whiteClr)),
          const Divider(color: AppColor.whiteClr),
          profileListtile(
              onTap: () {
                navigationTo(const PasswordUpdateScreen());
              },
              title: "Password Update",
              image: const Image(
                  image: AssetImage(Img.setting1), color: AppColor.whiteClr)),
          const Divider(color: AppColor.whiteClr),
          profileListtile(
              onTap: () => navigationTo(DriverProfileScreen()),
              title: "Profile Setting",
              image: const Image(
                  image: AssetImage(Img.setting_transport),
                  color: AppColor.whiteClr)),
          const Divider(color: AppColor.whiteClr),
          RSizedBox(height: 20.w),
          const Spacer(),
          Padding(
              padding: EdgeInsets.all(25.w),
              child: buttonContainer(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialogBox(
                            title: "  Log Out ?\n",
                            content: 'Are you sure you want to logout ?\n',
                            titleTextStyle: TextStyle(
                                color: AppColor.appColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                            onPressed1: () => navigationPop(),
                            onPressed2: () async {
                              await ref.read(storageProvider).deleteAll();
                              navigationRemoveUntil(
                                  const UserCheckLoginScreen());
                              snackBarMessage(
                                  msg: "Logout Successfully",
                                  color: AppColor.greenClr);
                            }));
                  },
                  width: double.infinity,
                  txt: "Log_Out".tr(),
                  color: AppColor.whiteClr,
                  txtColor: AppColor.appColor)),
          RSizedBox(height: 30.w),
        ],
      ),
    );
  }
}
