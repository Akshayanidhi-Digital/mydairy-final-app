import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/Myslider.dart';
import 'package:mydairy/dairy_users_dashboard/home/home_drawer.dart';

import '../../authentication/auth_controller.dart';
import '../profile/controller.dart';
import '../qr_screens/qr_scan_screen.dart';
import '../setting/controller.dart';
import 'home_src_page.dart';
import 'package:mydairy/export.dart';

// bool childDairyVAlue = false;

final childDairyVAlueProvider = StateProvider<bool>((ref) => false);

class HomeScreenPage extends ConsumerStatefulWidget {
  final bool childDairy;
  const HomeScreenPage({super.key, this.childDairy = false});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends ConsumerState<HomeScreenPage> {
  @override
  void initState() {
    // ref.read(locationProvider.notifier).getCurrentLocation();
    checkValue();
    super.initState();
  }

  checkValue() {
    Future(() => ref.read(profileApiProvider));
    Future(() {
      widget.childDairy == true
          ? ref.read(childDairyVAlueProvider.notifier).state = true
          : ref.read(childDairyVAlueProvider.notifier).state = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationlsProvider);
    final user = ref.watch(dairyListProvider);
    print(" user   :; ${user.accessToken}");
    print("location ::::::::: $location");
    return Scaffold(
      appBar: BaseAppBar(lead: true, title: Txt.mydairy, actionList: [
        PopupMenuButton(
            elevation: 7,
            color: AppColor.whiteClr,
            itemBuilder: (context) => [
                  PopupMenuItem(
                      onTap: () async {
                        setState(() {
                          ref.read(settingApiProvider).settingUpdate(
                              {"lang": "en"},
                              lang: true, bhasa: "en");
                          context.setLocale(const Locale('en', 'US'));
                        });
                        // // final profile_data =
                        // //     await MyStorage().readData("profile_data");
                        // // final profile_datas = await MyStorage().readAll();
                        // final map = profile_data.toString().split(' ');

                        // final profiles = profile_data.toString() as Map;
                        // print(" profile data   ${map}");
                      },
                      child: const Text("English")),
                  PopupMenuItem(
                      onTap: () {
                        setState(() {
                          ref.read(settingApiProvider).settingUpdate(
                              {"lang": "hi"},
                              lang: true, bhasa: "hi");
                          context.setLocale(const Locale('ta', 'IN'));
                        });
                      },
                      child: const Text("हिंदी")),
                ],
            child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: const Row(
                  children: [
                    Text(
                      "Language",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Icon(Icons.translate),
                  ],
                )))
      ]),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            RSizedBox(height: 10.h),
            Myslider(imgList: images),
            RSizedBox(height: 10.h),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.whiteClr,
                        border: Border.all(
                            width: 1,
                            color: AppColor.appColor,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: ListTile(
                        onTap: () => navigationTo(const QRViewExample()),
                        leading: Image.asset(width: 50, Img.scaner),
                        title: Text(user.profile == null
                            ? "Dairy Name"
                            : user.profile!.dairyName!),
                        subtitle: Text("Computer_Login".tr()),
                        trailing: const Icon(Icons.arrow_forward_ios)))),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: LayoutBuilder(builder: (context, constraint) {
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraint.maxWidth > 500 ? 4 : 3),
                      itemCount: homeicons.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: GestureDetector(
                                      onTap: () {
                                        navigationTo(homeicons[index].page!);
                                      },
                                      child: ListOfProducts(
                                          image: homeicons[index].image,
                                          data: homeicons[index].txt.tr())))),
                        );
                      });
                })),
            RSizedBox(height: 20.h),
          ])),
      drawer: const Drawer(
          shape: RoundedRectangleBorder(), child: HomeDrawerScreen()),
    );
  }
}
