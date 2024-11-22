import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/Myslider.dart';
import 'package:mydairy/export.dart';

import '../../common/services/model.dart';
import '../../dairy_users_dashboard/home/home_src_page.dart';
import '../driver/driver_screen.dart';
import '../profile/profile_screen.dart';
import '../route/route_screen.dart';
import '../vehicle/vehicle_screen.dart';
import 'home_src.dart';

// bool childDairyVAlue = false;

class TransPortHomeScreen extends ConsumerWidget {
  const TransPortHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(
        lead: true,
        title: Txt.transport,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            RSizedBox(height: 10.h),
            Myslider(imgList: images),
            RSizedBox(height: 20.h),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: LayoutBuilder(builder: (context, constraint) {
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 120.h,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          crossAxisCount: constraint.maxWidth > 500 ? 4 : 2),
                      itemCount: transportHomeIcon.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: GestureDetector(
                                      onTap: () {
                                        navigationTo(
                                            transportHomeIcon[index].page!);
                                      },
                                      child: ListOfProducts(
                                          image: transportHomeIcon[index].image,
                                          data: transportHomeIcon[index]
                                              .txt
                                              .tr())))),
                        );
                      });
                })),
            RSizedBox(height: 20.h),
          ])),
      drawer: const Drawer(
          shape: RoundedRectangleBorder(), child: TransportHomeScr()),
    );
  }
}

List<MasterItem> transportHomeIcon = [
  MasterItem(
      txt: Txt.driver, image: Img.driver_person, page: const DriverScreen()),
  MasterItem(
      txt: Txt.vehicle,
      image: Img.vehicle_transport,
      page: const VehicleScreen()),
  MasterItem(
      txt: Txt.route,
      image: Img.routes_transport,
      page: const TransportRouteScreen()),
  MasterItem(
      txt: Txt.setting,
      image: Img.setting_transport,
      page: const TransportProfileScreen())
];
