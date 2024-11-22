import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';

import '../../../export.dart';
import '../../model/cart_item_model.dart';
import '../controller/cart_controller.dart';
import '../controller/controller.dart';
import 'razorpay.dart';

// double pricestotal = 0.0;

class ShoppingCartScreen extends ConsumerStatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    final product = ref.watch(cart_item_Provider);
    final cart_build = ref.watch(cart_list_Provider);

    return Scaffold(
      appBar: BaseAppBar(title: "My Cart"),
      body: LoadingdataScreen(
          varBuild: cart_build,
          data: (mydata) {
            print("product  ${product.length}");
            return Container(
              child: product.isEmpty
                  ? emptyList()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: product.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                            child: InkWell(
                                          onLongPress: () {
                                            print("product ${product.length}");
                                          },
                                          child: Card(
                                              color: AppColor.whiteClr,
                                              child: SizedBox(
                                                  width: double.infinity,
                                                  height: 120.h,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(children: [
                                                        CircleAvatar(
                                                            backgroundColor:
                                                                AppColor
                                                                    .greenlight,
                                                            radius: 35.sp,
                                                            child: Image(
                                                                image: const AssetImage(
                                                                    Img.buffalo),
                                                                width: 70.sp)),
                                                        RSizedBox(width: 10.sp),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 8),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                              padding: EdgeInsets.only(top: 10.sp),
                                                                              child: Text(product[index].name!, style: TextStyle(fontSize: 16.sp, color: AppColor.appColor, fontWeight: FontWeight.w500))),
                                                                          Align(
                                                                              alignment: Alignment.topRight,
                                                                              child: InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      ref.read(cart_item_Provider.notifier).total_amount();
                                                                                      ref.read(cart_item_Provider.notifier).cart_total(index);
                                                                                      // setState(() {});

                                                                                      //   if (data[index]
                                                                                      //           ['select'] ==
                                                                                      //       false) {
                                                                                      //     data[index]
                                                                                      //             ['select'] =
                                                                                      //         true;
                                                                                      //     pricestotal += int
                                                                                      //         .parse(data[index]
                                                                                      //                 [
                                                                                      //                 'price']
                                                                                      //             .toString());

                                                                                      //     cartItem.add(index);
                                                                                      //     print(
                                                                                      //         "cartItem..::: ${cartItem.toSet().toList()}");
                                                                                      //     // cartItemMap.addAll({
                                                                                      //     //   "items": cartItem
                                                                                      //     //       .toSet()
                                                                                      //     //       .toList()
                                                                                      //     // });
                                                                                      //   } else {
                                                                                      //     data[index]
                                                                                      //             ['select'] =
                                                                                      //         false;
                                                                                      //     pricestotal -= int
                                                                                      //         .parse(data[index]
                                                                                      //                 [
                                                                                      //                 'price']
                                                                                      //             .toString());
                                                                                      //     cartItem
                                                                                      //         .remove(index);
                                                                                      //   }
                                                                                      //   print(
                                                                                      //       "cart items :: $cartItem");

                                                                                      //   print(
                                                                                      //       "cart items.....  $cartItemMap");
                                                                                    });
                                                                                  },
                                                                                  child: Icon(product[index].select! ? Icons.check_box : Icons.check_box_outline_blank, color: AppColor.appColor)))
                                                                        ]),
                                                                    const Spacer(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: Text(
                                                                          "\u{20B9} ${df(product[index].total.toString())}",
                                                                          style: TextStyle(
                                                                              fontSize: 16.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColor.blackClr)),
                                                                    ),
                                                                    Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Row(children: [
                                                                                InkWell(
                                                                                    onTap: () {
                                                                                      if (product[index].quantity! > 1) {
                                                                                        ref.read(shoping_apis_Provider).cart_update({
                                                                                          "cart": product[index].id,
                                                                                          "quantity": product[index].quantity! - 1
                                                                                        }, product[index].select);
                                                                                      }
                                                                                    },
                                                                                    child: Icon(Icons.remove_circle, size: 24.sp, color: AppColor.appColor)),
                                                                                RSizedBox(width: 7.w),
                                                                                Text("${product[index].quantity}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.sp)),
                                                                                RSizedBox(width: 7.w),
                                                                                InkWell(
                                                                                    onTap: () {
                                                                                      ref.read(shoping_apis_Provider).cart_update({
                                                                                        "cart": product[index].id,
                                                                                        "quantity": product[index].quantity! + 1
                                                                                      }, product[index].select);
                                                                                    },
                                                                                    child: Icon(Icons.add_circle, size: 24.sp, color: AppColor.appColor))
                                                                              ]),
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                    ref.read(shoping_apis_Provider).cart_item_delete(product[index].id!);
                                                                                  },
                                                                                  child: const Icon(Icons.delete, color: AppColor.redClr))
                                                                            ])),
                                                                  ]),
                                                            ))
                                                      ])))),
                                        ))),
                                  );
                                }),
                            (ref
                                    .watch(cart_item_Provider.notifier)
                                    .cartItem
                                    .isEmpty)
                                ? SizedBox(height: 50.h)
                                : SizedBox(height: 300.h)
                          ])),
            );
          }),
      bottomSheet:
          (product.where((element) => element.select == true).toList().isEmpty)
              ? const SizedBox()
              : bottomSheetItem(ref, product),
    );
  }

  bottomSheetItem(WidgetRef ref, List<CartItemModel>? product) {
    final total_price = double.parse(
        ref.watch(cart_item_Provider.notifier).total_amount().toString());
    var value = product!.where((element) => element.select == true).toList();

    print("::::::::::::::::::: $value");
    return Container(
        height: 271.h,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3))
            ],
            color: AppColor.whiteClr,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              RSizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Item Select", style: TextStyle(fontSize: 16.sp)),
                  Text("${value.length}", style: TextStyle(fontSize: 16.sp)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Total", style: TextStyle(fontSize: 20.sp)),
                Text("\u{20B9} ${total_price.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 20.sp))
              ]),
              RSizedBox(height: 30.h),
              buttonContainer(
                  onTap: () async {
                    try {
                      await ref.read(paymentProvider).intialGataway();

                      await ref.read(paymentProvider).paymentWinodowOpen(
                          cartId: "1",
                          ammount: (total_price * 100).toDouble(),      
                          phone: '7023330560');
                    } catch (e) {
                      print(
                          ":::::::::::::::::::::::::::::::::::: ,${e.toString()}");
                    }
                  },
                  hight: 60.h,
                  borderRadius: BorderRadius.circular(30),
                  width: double.infinity,
                  txt: "Order Now"),
              RSizedBox(height: 20.0.sp)
            ])));
  }
}
