import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

class MemberPurchageSrc extends StatelessWidget {
  final Color? color, inerColor;
  final String? price, validity, validity2;
  final dynamic Function()? onTap;
  final bool elevetion;
  final double? height;
  const MemberPurchageSrc(
      {super.key,
      this.color,
      this.inerColor,
      this.price,
      this.validity,
      this.validity2,
      this.height,
      this.elevetion = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      height: height ?? 213.0.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7.0.w),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: elevetion == true
                  ? null
                  : [
                      const BoxShadow(
                        color: Color(0xff2F2F2F),
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
              color: inerColor,
            ),
            height: 37.0.h,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "Category - $validity2",
                style: TextStyle(color: AppColor.whiteClr, fontSize: 18.sp),
              ),
            ),
          ),
          RSizedBox(height: 30.0.h),
          RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(1, -20),
                  child: Text(
                    'Rs.',
                    style: TextStyle(color: AppColor.whiteClr, fontSize: 10.sp),
                    //superscript is usually smaller in size
                    textScaleFactor: 2.5,
                  ),
                ),
              ),
              TextSpan(
                text: "$price/-",
                style: TextStyle(color: AppColor.whiteClr, fontSize: 36.sp),
              ),
            ]),
          ),
          Text(
            textAlign: TextAlign.center,
            "Validity: $validity",
            style: TextStyle(color: AppColor.whiteClr, fontSize: 16.sp),
          ),
          RSizedBox(height: 10.0.h),
          elevetion == true
              ? buttonContainer(
                  hight: 32.0.h,
                  width: 105.0.w,
                  onTap: onTap,
                  txt: "Purchase",
                  fontSize: 15.sp,
                  color: const Color(0xffF7422D))
              : const RSizedBox()
        ],
      ),
    );
  }
}
