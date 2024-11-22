import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

import '../../farmer_buyer_dashboard/home/farmer_home_screen.dart';
// import '../common/utils/services/variable.dart';

class SliderImage extends StatefulWidget {
  const SliderImage({super.key});

  @override
  State<SliderImage> createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: RSizedBox(
            width: double.infinity,
            height: 170.h,
            child: CarouselSlider.builder(
                options: CarouselOptions(
                    animateToClosest: true,
                    enlargeCenterPage: true,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (index, reason) {
                      // ref.read(currentpageProvider.notifier).state = index;
                    },
                    scrollDirection: Axis.horizontal),
                itemCount: images.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        RSizedBox(
                            height: 170.h,
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.asset(
                                    fit: BoxFit.fill,
                                    imgList[itemIndex].toString()))))));
  }
}

class ListOfProducts extends StatelessWidget {
  final String data;
  final String image;
  const ListOfProducts({super.key, required this.data, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Container(
            height: 130.h,
            decoration: BoxDecoration(
              color: AppColor.whiteClr,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                  width: 1, color: AppColor.appColor, style: BorderStyle.solid),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RSizedBox(height: 8.h),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(image),
                                  fit: BoxFit.contain)))),
                  RSizedBox(height: 5.h),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                          textAlign: TextAlign.center,
                          data,
                          style: const TextStyle(overflow: TextOverflow.fade)))
                ])));
  }
}
