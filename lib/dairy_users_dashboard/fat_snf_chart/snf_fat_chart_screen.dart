// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import '../profile/controller.dart';
import 'cow_snf_chart/snf_chart_controller.dart';
import 'package:mydairy/export.dart';

class SnfAndFatChartScreen extends ConsumerWidget {
  const SnfAndFatChartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(valueSnfProvider);
    return Scaffold(
      appBar: BaseAppBar(
        title: Txt.fat_chart,
      ),
      body: Column(
        children: [
          Container(
              alignment: Alignment.bottomCenter,
              height: 40,
              width: double.infinity,
              color: AppColor.appColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          ref.read(valueSnfProvider.notifier).state = 0;
                        },
                        child: Column(children: [
                          Text("FARMER",
                              style: TextStyle(color: AppColor.whiteClr)),
                          Container(
                              height: 3,
                              color: value == 0
                                  ? AppColor.whiteClr
                                  : AppColor.appColor,
                              width: 100)
                        ])),
                    InkWell(
                        onTap: () {
                          ref.read(valueSnfProvider.notifier).state = 1;
                        },
                        child: Column(children: [
                          Text("BUYER",
                              style: TextStyle(color: AppColor.whiteClr)),
                          Container(
                              height: 3,
                              color: value == 1
                                  ? AppColor.whiteClr
                                  : AppColor.appColor,
                              width: 100)
                        ]))
                  ])),
          FarmerSnfScreen(value: value)
        ],
      ),
    );
  }
}

class FarmerSnfScreen extends ConsumerWidget {
  final int? value;
  const FarmerSnfScreen({super.key, this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(dairyListProvider);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.w),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 140.h),
            itemCount: snfChartIcon.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // screenNavigate(context: context, index: index);AddCowChartScreen=> if chart doesnot exits for user then import from default

                  if (index == 4) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            actionsPadding: EdgeInsets.zero,
                            titlePadding: EdgeInsets.zero,
                            title: Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColor.appColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            topRight: Radius.circular(25.r))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("      "),
                                          Text(
                                            "Select",
                                            style: TextStyle(
                                                color: AppColor.whiteClr,
                                                fontSize: 30.w),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 15.w),
                                            child: IconButton(
                                              onPressed: () => navigationPop(),
                                              icon: Icon(
                                                Icons.cancel_outlined,
                                                size: 30.w,
                                                color: AppColor.whiteClr,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  _types_value(
                                    "cow",
                                    onTap: () {
                                      ref
                                          .read(chartApiProvider)
                                          .chart_download({
                                        "rate_type":
                                            value == 0 ? "Sell" : "Purchase",
                                        "milk_type": "Cow",
                                        "user": user.userId
                                      });
                                    },
                                  ),
                                  Divider(),
                                  _types_value(
                                    "Buffalo",
                                    onTap: () {
                                      ref
                                          .read(chartApiProvider)
                                          .chart_download({
                                        "rate_type":
                                            value == 0 ? "Sell" : "Purchase",
                                        "milk_type": "Buffalo",
                                        "user": user.userId
                                      });
                                    },
                                  ),
                                  Divider(),
                                  _types_value(
                                    "Mix",
                                    onTap: () {
                                      ref
                                          .read(chartApiProvider)
                                          .chart_download({
                                        "rate_type":
                                            value == 0 ? "Sell" : "Purchase",
                                        "milk_type": "Mix",
                                        "user": user.userId
                                      });
                                    },
                                  ),
                                  SizedBox(height: 10.h)
                                ],
                              ),
                            ))

                        // diologBoxAlert(context,
                        //     txt1: "Cow",
                        //     txt2: "Buffalo",
                        //     icon1: SizedBox(),
                        //     icon2: SizedBox(),
                        //     icon3: Icon(Icons.arrow_forward_ios),
                        //     icon4: Icon(Icons.arrow_forward_ios))
                        );
                  } else {
                    navigationTo(snfChartIcon[index].page!);
                  }
                  print("index :: $index");
                },
                child: ListOfCowChart(
                    image: snfChartIcon[index].image,
                    data: snfChartIcon[index].txt),
              );
            }));
  }

  _types_value(String txt, {void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$txt",
              style: TextStyle(
                  color: AppColor.blackClr,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}

class ListOfCowChart extends StatelessWidget {
  final String data;
  final String image;
  const ListOfCowChart({super.key, required this.data, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 1,
                      color: Color.fromARGB(87, 158, 158, 158),
                      offset: Offset(1, 2))
                ]),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RSizedBox(height: 8.h),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Container(
                        height: 60.h,
                        width: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColor.bluelightClr,
                            image: DecorationImage(image: AssetImage(image))),
                      )),
                  RSizedBox(height: 5.h),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                          textAlign: TextAlign.center,
                          data,
                          style: const TextStyle(
                              overflow: TextOverflow.fade,
                              fontWeight: FontWeight.w500)))
                ])));
  }
}
