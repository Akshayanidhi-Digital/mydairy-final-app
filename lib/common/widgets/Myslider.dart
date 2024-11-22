import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../export.dart';

class Myslider extends StatefulWidget {
  final List imgList;

  const Myslider({super.key, required this.imgList});
  @override
  State<Myslider> createState() => _MysliderState();
}

class _MysliderState extends State<Myslider> {
  int _current = 0;
  // final CarouselController _controller = CarouselController();
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double viewportFraction = (height > width) ? 0.9 : 0.5;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          items: widget.imgList
              .map((item) => Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the radius as needed
                      child: Image(
                        image: NetworkImage(item),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ))
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 150.sp,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: viewportFraction,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 5.0,
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.bluedarkClr.withOpacity(0.9),
                borderRadius: BorderRadius.circular(50.sp)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.ligthClr
                          .withOpacity(_current == entry.key ? 1 : 0.5),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
