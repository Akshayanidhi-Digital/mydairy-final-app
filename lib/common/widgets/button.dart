// ! Button For Everything Screen
import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

buttonContainer(
    {String? txt,
    Widget? widget,
    Function()? onTap,
    bool? loder,
    Color? loaderColor,
    Color? color,
    Color? txtColor,
    BoxBorder? border,
    double? fontSize,
    double? width,
    EdgeInsetsGeometry? margin,
    FontWeight? fontWeight,
    double? hight,
    BorderRadiusGeometry? borderRadius}) {
  return GestureDetector(
    onTap: loder == true ? null : onTap,
    child: Container(
      margin: margin,
      alignment: Alignment.center,
      height: hight ?? 46.0.h,
      width: width ?? 150.0.w,
      decoration: BoxDecoration(
          border: border,
          color: color ?? AppColor.appColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8.r)),
      child: loder == true
          ? CircularProgressIndicator(color: loaderColor ?? AppColor.whiteClr)
          : widget ??
              Text(
                "$txt".tr(),
                style: TextStyle(
                    fontWeight: fontWeight,
                    color: txtColor ?? AppColor.whiteClr,
                    fontSize: fontSize ?? 18.sp),
              ),
    ),
  );
}

// ignore_for_file: must_be_immutable

class FarmerHMbtn extends StatelessWidget {
  Function()? onPressed;
  ImageProvider<Object> image;
  String? labeltext;
  FarmerHMbtn(
      {super.key,
      required this.onPressed,
      required this.image,
      required this.labeltext});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Image(
            image: image,
            width: 40.w,
            height: 40.h,
          ),
          RSizedBox(height: 5.h),
          Text(
            '$labeltext',
            style: TextStyle(fontSize: 14.0.sp),
          )
        ],
      ),
    );
  }
}

class CustomAppBarBtn extends StatelessWidget {
  final void Function()? onTap;
  final String? title;
  final String? txt2;

//  final double? width;
  final bool name;
  const CustomAppBarBtn(
      {super.key, this.onTap, this.title, this.name = false, this.txt2});

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: GestureDetector(
          onTap: onTap,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 5, 51, 87),
                  borderRadius: BorderRadius.circular(10.r)),
              height: 35.0.sp,
              // width:width?? 80.w,
              child: name == true
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Text(txt2!),
                    ))
                  : RSizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                title != null
                                    ? title.toString().tr()
                                    : 'Add'.tr(),
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              RSizedBox(width: 5.w),
                              Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColor.whiteClr),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Icon(Icons.add, size: 20))
                            ]),
                      ),
                    ))),
    );
  }
}

class Load {
  static LoadBtN(
      {String? txt,
      Widget? widget,
      Function()? onTap,
      bool? loder,
      Color? loaderColor,
      Color? color,
      Color? txtColor,
      BoxBorder? border,
      double? fontSize,
      double? width,
      EdgeInsetsGeometry? margin,
      FontWeight? fontWeight,
      double? hight,
      BorderRadiusGeometry? borderRadius}) {
    return GestureDetector(
      onTap: loder == true ? null : onTap,
      child: Container(
        margin: margin,
        alignment: Alignment.center,
        height: hight ?? 46.0.h,
        width: width ?? 150.0.w,
        decoration: BoxDecoration(
            border: border,
            color: color ?? AppColor.appColor,
            borderRadius: borderRadius ?? BorderRadius.circular(8.r)),
        child: loder == true
            ? CircularProgressIndicator(color: loaderColor ?? AppColor.whiteClr)
            : widget ??
                Text(
                  "$txt".tr(),
                  style: TextStyle(
                      fontWeight: fontWeight,
                      color: txtColor ?? AppColor.whiteClr,
                      fontSize: fontSize ?? 18.sp),
                ),
      ),
    );
  }
}
