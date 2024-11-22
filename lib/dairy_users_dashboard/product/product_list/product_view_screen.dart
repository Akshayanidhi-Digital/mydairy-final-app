import 'package:flutter/material.dart';

import '../../../export.dart';
import '../../model/product_list_model.dart';

class ProductViewScreen extends ConsumerWidget {
  final ProductList data;
  const ProductViewScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(title: "Product View"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.grey),
                  borderRadius: BorderRadius.circular(4.r)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "${Url.image}${data.imageBase}/${data.image}",
                              ),
                            ),
                            color: AppColor.greenlight,
                            shape: BoxShape.circle),
                        height: 100.h,
                        width: 100.w,
                      ),
                    ),
                    RSizedBox(height: 10.0.h),
                    Text(
                      "${data.name}",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    Text("${data.desciption}"),
                    RSizedBox(height: 10.0.h),
                    Text(
                      '\u{20B9} ${data.price}',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w400),
                    ),
                    RSizedBox(height: 10.0.h),
                    Row(
                      children: [
                        Expanded(
                            child: buttonContainer(
                                hight: 34.0.h,
                                txt: "Action",
                                color: AppColor.bluedarkClr,
                                txtColor: AppColor.whiteClr)),
                        RSizedBox(width: 10.0.h),
                        Expanded(
                            child: buttonContainer(
                                hight: 34.0.h,
                                txt: "View Order",
                                border: Border.all(),
                                color: AppColor.whiteClr,
                                txtColor: AppColor.bluedarkClr))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
