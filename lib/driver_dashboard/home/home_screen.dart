import 'package:flutter/material.dart';
import '../../common/services/model.dart';
import '../../common/widgets/Myslider.dart';
import '../../dairy_users_dashboard/home/home_src_page.dart';
import '../../export.dart';
import 'home_src.dart';

class DriverHomeScreen extends ConsumerWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(
        lead: true,
        title: Txt.driver,
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
                      itemCount: driver_HomeIcon.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: GestureDetector(
                                      onTap: () {
                                        // navigationTo(
                                        //     driver_HomeIcon[index].page!);
                                      },
                                      child: ListOfProducts(
                                          image: driver_HomeIcon[index].image,
                                          data: driver_HomeIcon[index]
                                              .txt
                                              .tr())))),
                        );
                      });
                })),
            RSizedBox(height: 20.h),
          ])),
      drawer:
          const Drawer(shape: RoundedRectangleBorder(), child: DriverHomeScr()),
    );
  }
}

final List<MasterItem> driver_HomeIcon = [
  MasterItem(txt: Txt.driver, image: Img.driver_person, page: Container()),
  MasterItem(txt: Txt.vehicle, image: Img.vehicle_transport, page: Container()),
  MasterItem(txt: Txt.route, image: Img.routes_transport, page: Container()),
  MasterItem(txt: Txt.setting, image: Img.setting_transport, page: Container())
];
