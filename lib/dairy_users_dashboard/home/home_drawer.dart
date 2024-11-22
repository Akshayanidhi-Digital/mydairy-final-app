import 'package:flutter/material.dart';
import 'package:mydairy/dairy_users_dashboard/milk_buy_sell/milk_buy_screen.dart';
import 'package:mydairy/dairy_users_dashboard/profile/controller.dart';
import 'package:mydairy/dairy_users_dashboard/shopping_list/cart/shopping_cart.dart';
import 'package:mydairy/dairy_users_dashboard/shopping_list/order_history/order_history_screen.dart';
import 'package:mydairy/export.dart';
import 'package:mydairy/authentication/check_user.dart';
import '../master/master_scr_all/membership_screen.dart';
import '../master/plan/plan_purchase_list_screen.dart';
import '../product/product_screen.dart';
import '../profile/profile_screen.dart';
import '../setting/setting_screen.dart';
import '../shopping_list/shopping/shopping_screen.dart';
import '../view_by_entry/view_entry_screen.dart';

class HomeDrawerScreen extends ConsumerWidget {
  const HomeDrawerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(dairyListProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
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
                      Text(Txt.mydairy.tr(),
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
                    style:
                        TextStyle(color: AppColor.whiteClr, fontSize: 18.w))),
            RSizedBox(height: 20.h),
            profileListtile(
                onTap: () => navigationTo(const ProfileScreen()),
                title: "Profile",
                icon: Icons.person),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(const MilkBuyScreen()),
                title: Txt.milk_buy,
                image: Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: Image(
                        image: const AssetImage(Img.milk_buy),
                        width: 13.w,
                        color: AppColor.whiteClr))),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(const MilkBuyScreen(buyerValue: 1)),
                title: Txt.milk_sell,
                image: Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: Image(
                        image: const AssetImage(Img.milk_sell),
                        width: 15.w,
                        color: AppColor.whiteClr))),
            const Divider(color: AppColor.whiteClr),

            profileListtile(
                onTap: () => navigationTo(const CustomersScreen()),
                title: Txt.userManagment.tr(),
                icon: Icons.people_alt),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(const ViewByEntryScreen()),
                title: "Records",
                icon: Icons.library_books),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(const ShoppingScreen()),
                title: "Online_Shopping",
                icon: Icons.shopping_bag),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(OrderHistoryScreen()),
                title: "Shopping_History",
                icon: Icons.work_history),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(const ShoppingCartScreen()),
                title: "Shopping_Cart",
                icon: Icons.shopping_cart),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(const ProductScreen()),
                title: "Products",
                icon: MdiIcons.box),
            const Divider(color: AppColor.whiteClr),
            // profileListtile(title: "Orders", icon: Icons.shopping_bag_outlined),
            // const Divider(color: AppColor.whiteClr),
            // profileListtile(title: "My Ads", icon: MdiIcons.advertisements),
            // const Divider(color: AppColor.whiteClr),
            // profileListtile(title: "Khata", icon: Icons.menu_book),
            // const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(const NotificationScreen()),
                title: "Notification",
                icon: Icons.notifications),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(const SettingScreen()),
                title: "Setting",
                icon: Icons.settings),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () => navigationTo(const MemberShipScreen()),
                title: "Plans",
                icon: Icons.checklist),
            const Divider(color: AppColor.whiteClr),
            profileListtile(
                onTap: () {
                  navigationTo(const PlanPurchaseScreen());
                },
                title: "Plan_Records",
                icon: Icons.description),
            const Divider(color: AppColor.whiteClr),
            RSizedBox(height: 60.w),
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
                            navigationRemoveUntil(const UserCheckLoginScreen());
                            snackBarMessage(
                                msg: "Logout Successfully",
                                color: AppColor.greenClr);
                          },
                        ),
                      );
                    },
                    width: double.infinity,
                    txt: "Log_Out".tr(),
                    color: AppColor.whiteClr,
                    txtColor: AppColor.appColor)),
            RSizedBox(height: 30.w),
          ],
        ),
      ),
    );
  }
}

Widget profileListtile(
    {IconData? icon,
    required String title,
    Widget? image,
    void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(children: [
      RSizedBox(width: 15.w),
      image ?? Icon(icon, color: AppColor.whiteClr, size: 30.w),
      RSizedBox(width: 20.w),
      Text(title.tr(),
          style: TextStyle(color: AppColor.whiteClr, fontSize: 18.w))
    ]),
  );
}
