import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/role_controller.dart';

class HelpScreen extends ConsumerWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helpApi = ref.watch(helpApiGetProvider);
    final data = ref.watch(helpdataProvider);
    return Scaffold(
      appBar: BaseAppBar(title: "Help"),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0.h),
        child: LoadingdataScreen(
          varBuild: helpApi,
          data: (mydata) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                            child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 10.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            height: 86.h,
                            decoration: BoxDecoration(
                                color: AppColor.greenlight,
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    // color: AppColor.whiteClr,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(Url.image +
                                                data[index].imagePath!))),
                                    width: 50),
                                Expanded(
                                  child: Text(
                                    data[index].name!,
                                    style: TextStyle(fontSize: 17.w),
                                  ),
                                ),
                                buttonContainer(
                                    onTap: () {
                                      final Uri url =
                                          Uri.parse(data[index].url.toString());
                                      launchUrl(url);
                                    },
                                    width: 49.0.w,
                                    hight: 42.0.h,
                                    txt: "Play")
                              ],
                            ),
                          ),
                        ))),
                  )),
        ),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 15.0.w, bottom: 15.0.h),
          child: buttonContainer(
              onTap: () async {
                final Uri phoneUrl = Uri(scheme: 'tel', path: '+917234567893');

                if (await canLaunch(phoneUrl.toString())) {
                  await launch(phoneUrl.toString());
                } else {
                  throw "Can't phone that number.";
                }
              },
              hight: 45.0.h,
              width: 45.0.w,
              borderRadius: BorderRadius.circular(50.0.r),
              widget: const Image(image: AssetImage(Img.call)))),
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
