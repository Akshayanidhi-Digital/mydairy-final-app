import 'package:flutter/material.dart';
import 'package:mydairy/common/services/model.dart';

import '../../../export.dart';
import '../controller/controller.dart';

// ignore: must_be_immutable
class OrderHistoryScreen extends ConsumerWidget {
  OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(tabChangeProvider);
    return Scaffold(
        appBar: BaseAppBar(title: "My Order"),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(left: 15.r, right: 15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        3,
                        (index) => _onchangeTxt(
                          fontweight: tab == index
                              ? FontWeight.w500
                              : FontWeight.normal,
                          orderTxt[index].txt,
                          tab == index ? AppColor.appColor : AppColor.blackClr,
                          onTap: () {
                            ref.read(tabChangeProvider.notifier).state = index;
                          },
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          3,
                          (index) => _tabBar(tab == index
                              ? AppColor.appColor
                              : AppColor.transparent))),
                ),
                SizedBox(height: 20.h),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, inerindex) {
                      return AnimationConfiguration.staggeredList(
            position: inerindex,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(

                        child: Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Column(
                            children: [
                              Row(children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: AppColor.ligthClr,
                                        ),
                                        height: 86.h,
                                        width: 86.w,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            child: const Icon(Icons.access_alarms)
                                            //  CachedNetworkImage(
                                            //   fit: BoxFit
                                            //       .fill,
                                            //   imageUrl:
                                            //       "${ApiUser.netUrl}${getorderList.data!.activeOrder![index].items![inerindex].image}",
                                            //   placeholder:
                                            //       (context, url) =>
                                            //           const SizedBox(),
                                            //   errorWidget: (context,
                                            //           url,
                                            //           error) =>
                                            //       const Icon(Icons.error),
                                            // )
                        
                                            )),
                                  ),
                                ),
                                RSizedBox(width: 15.w),
                                Expanded(
                                  flex: 3,
                                  child: InkWell(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Sanchi Gold Milk"),
                                          const Text("Quantity: "),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("\u{20B9} 30.20"),
                                              buttonContainer(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  hight: 31.h,
                                                  width: 90.w,
                                                  txt: "Order Status",
                                                  fontSize: 12.w,
                                                  fontWeight: FontWeight.normal),
                                            ],
                                          )
                                        ]),
                                  ),
                                ),
                              ]),
                              const Divider()
                            ],
                          ),
                        ))),
                      );
                    }),
              ],
            ),
          ),
        ));
  }

  List<TxtModel> orderTxt = [
    TxtModel(txt: "Active"),
    TxtModel(txt: "Complete"),
    TxtModel(txt: "Cancel"),
  ];

  Widget _tabBar(Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: 5.h,
      ),
    );
  }

  Widget _onchangeTxt(String txt, Color color,
      {void Function()? onTap, FontWeight? fontweight}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        txt,
        style: TextStyle(fontSize: 16.sp, color: color, fontWeight: fontweight),
      ),
    );
  }
}
