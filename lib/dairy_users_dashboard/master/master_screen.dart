import 'package:flutter/material.dart';
import '../home/home_src_page.dart';
import 'package:mydairy/export.dart';

class MasterScreen extends ConsumerWidget {
  const MasterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterItems = ref.watch(masterItemsProvider);
    return Scaffold(
      appBar: BaseAppBar(title: "Master"),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 5.0,
                  crossAxisCount: 2,
                  mainAxisExtent: 130),
              itemCount: masterItems.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                          child: GestureDetector(
                        onTap: () {
                          navigationTo(masterItems[index].page!);
                        },
                        child: ListOfProducts(
                            image: masterItems[index].image,
                            data: masterItems[index].txt.toString().tr()),
                      ))),
                );
              })),
    );
  }
}
