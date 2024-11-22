import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mydairy/export.dart';

BoxDecoration boxDecoration() {
  return const BoxDecoration(
      image:
          DecorationImage(image: AssetImage(Img.wallpaper), fit: BoxFit.fill));
}

class ImageSlider extends StatelessWidget {
  final List<String> imgList;

  const ImageSlider({super.key, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: imgList
            .map((item) => Container(
                  child: Center(
                    child: Image(image: AssetImage(item)),
                  ),
                ))
            .toList());
  }
}

style14({Color? color, double? fontSize}) {
  return TextStyle(
      color: color ?? AppColor.whiteClr, fontSize: fontSize ?? 14.sp);
}
