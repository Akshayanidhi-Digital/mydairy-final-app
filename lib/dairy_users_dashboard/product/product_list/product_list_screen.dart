import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import '../../model/product_list_model.dart';
import 'add_product_screen.dart';
import 'controller.dart';
import 'product_view_screen.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopingApi = ref.watch(productListApiProvider);
    return Scaffold(
        appBar: BaseAppBar(
          title: "Products",
          actionList: [
            GestureDetector(
                onTap: () => navigationTo(const AddProductScreen()),
                child: const CustomAppBarBtn(title: "Add Products"))
          ],
        ),
        body: LoadingdataScreen(
          varBuild: shopingApi,
          data: (mydata) {
            List<ProductList> data = [];
            for (var i = 0; i < mydata.length; i++) {
              // print("name${data[i].groupName}");
              data.add(ProductList.fromJson(mydata[i]));
            }

            return Container(
              child: data.isEmpty
                  ? emptyList()
                  : LayoutBuilder(builder: (context, constraint) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 15.sp),
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        constraint.maxWidth > 500 ? 4 : 2,
                                    // childAspectRatio: 0.8,
                                    mainAxisSpacing: 20.w,
                                    // crossAxisSpacing: 10,
                                    crossAxisSpacing: 20.w,
                                    // mainAxisSpacing: 20.h,
                                    mainAxisExtent: 220.h),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                        child: GestureDetector(
                                            onTap: () {
                                              // navigationTo(const ProductViewScreen());
                                            },
                                            child: ProductListSrc(
                                                data: data[index])))),
                              );
                            }),
                      );
                    }),
            );
          },
        ));
  }
}

class ProductListSrc extends StatelessWidget {
  final ProductList data;
  const ProductListSrc({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 178.h,
      // width: 100.w,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.grey),
          borderRadius: BorderRadius.circular(4.r)),
      child: Padding(
        padding:
            EdgeInsets.only(left: 10.w, bottom: 10.w, top: 15.w, right: 10.w),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                  child: CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColor.greenlight,
                backgroundImage: NetworkImage(
                  "${Url.image}${data.imageBase}/${data.image}",
                ),
                // child: Icon(Icons.person, size: 40.r),
              )),
              Text(data.groupName!,
                  style: TextStyle(color: AppColor.blackClr, fontSize: 16.sp)),
              Text("\u{20B9} ${data.price}",
                  style: TextStyle(color: AppColor.blackClr)),
              buttonContainer(
                  onTap: () {
                    navigationTo(ProductViewScreen(data: data));
                  },
                  hight: 25.0.h,
                  txt: "View",
                  fontSize: 12.sp,
                  color: AppColor.bluedarkClr)
            ]),
      ),
    );
  }
}
