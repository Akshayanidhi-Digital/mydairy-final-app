import 'package:flutter/material.dart';
import '../home/home_src_page.dart';
import 'package:mydairy/export.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Product",
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.w),
          child: LayoutBuilder(
            builder: (context, constraints) => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 500 ? 4 : 2,
                    mainAxisExtent: 140.0.h),
                itemCount: productIcon.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(

                    child: GestureDetector(
                      onTap: () => navigationTo(productIcon[index].page!),
                      child: ListOfProducts(
                          image: productIcon[index].image,
                          data: productIcon[index].txt.toString()),
                    ))),
                  );
                }),
          )),
    );
  }
}
