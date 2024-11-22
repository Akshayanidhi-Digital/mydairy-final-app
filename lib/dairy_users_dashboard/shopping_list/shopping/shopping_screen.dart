import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';
import 'package:mydairy/export.dart';

import '../../model/product_list_model.dart';
import '../cart/shopping_cart.dart';
import '../controller/cart_controller.dart';
import '../controller/controller.dart';

class ShoppingScreen extends ConsumerWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Shopping",
        actionList: [
          Padding(
            padding: EdgeInsets.only(right: 30.0.w),
            child: GestureDetector(
                onTap: () => navigationTo(const ShoppingCartScreen()),
                child: const Image(image: AssetImage(Img.shopping_cart))),
          )
        ],
      ),
      body: const ShopingListOfProduct(),
    );
  }
}

class ShopingListOfProduct extends ConsumerWidget {
  const ShopingListOfProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopingBuild = ref.watch(shopingListProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: LoadingdataScreen(
        varBuild: shopingBuild,
        data: (mydata) {
          List<ProductList> data = [];
          for (var i = 0; i < mydata.length; i++) {
            data.add(ProductList.fromJson(mydata[i]));
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RSizedBox(height: 20.h),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraint) {
                    return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: constraint.maxWidth > 500 ? 5 : 3,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 20.h,
                            mainAxisExtent: 180.h),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                    child: Container(
                                  height: 130.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColor.grey),
                                      borderRadius: BorderRadius.circular(4.r)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        bottom: 10.w,
                                        top: 15.w,
                                        right: 10.w),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                              child: CircleAvatar(
                                                  radius: 30.r,
                                                  backgroundImage: NetworkImage(
                                                    "${Url.image}${data[index].imageBase}/${data[index].image}",
                                                  ),
                                                  backgroundColor:
                                                      const Color(0xFFC3F7FF))),
                                          Text(
                                            "${data[index].name.toString()}",
                                            style: const TextStyle(
                                                color: AppColor.blackClr),
                                          ),
                                          Text(
                                            "\u{20B9} ${df(data[index].price.toString())}",
                                            style: TextStyle(
                                                color: AppColor.blackClr),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              ref
                                                  .read(shoping_apis_Provider)
                                                  .cart_add({
                                                "item": data[index].id,
                                                "quantity": 1
                                              });
                                            },
                                            child: Container(
                                                width: 300,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 5, 51, 87),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                height: 20.0.h,
                                                // width: 76.0.w,
                                                child:
                                                    // Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment
                                                    //             .spaceAround,
                                                    //     children: [
                                                    Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("Add",
                                                        style: TextStyle(
                                                            fontSize: 13.w,
                                                            color: AppColor
                                                                .whiteClr)),
                                                  ],
                                                )
                                                //   Container(
                                                //       decoration: BoxDecoration(
                                                //           border: Border.all(
                                                //               color: AppColor
                                                //                   .whiteClr),
                                                //           borderRadius:
                                                //               BorderRadius
                                                //                   .circular(
                                                //                       20)),
                                                //       child: const Icon(
                                                //           Icons.add,
                                                //           color: AppColor
                                                //               .whiteClr,
                                                //           size: 10))
                                                // ])
                                                ),
                                          ),
                                        ]),
                                  ),
                                ))),
                          );
                        });
                  }),
                ),
              ]);
        },
      ),
    );
  }
}
