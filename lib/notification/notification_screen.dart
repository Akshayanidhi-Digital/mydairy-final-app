import 'package:flutter/material.dart';
import 'package:mydairy/dairy_users_dashboard/model/notification_model.dart';
import 'package:mydairy/export.dart';
import 'package:mydairy/notification/notification_services.dart';
import 'web_shocket.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notify = ref.watch(notificationApiProvider);
    return Scaffold(
        appBar: BaseAppBar(title: "Notification", actionList: [
          CustomAppBarBtn(
              name: true,
              txt2: "Delete All",
              onTap: () {
                navigationTo(WebShocketScreen());
              })
        ]),
        body: LoadingdataScreen(
          varBuild: notify,
          data: (mydata) {
            print(" data :: ${mydata}");

            List<NotificationModel> _notyfy = [];
            for (var i = 0; i < mydata.length; i++) {
              _notyfy.add(NotificationModel.fromJson(mydata[i]));
            }
            return _notyfy.isEmpty
                ? emptyList()
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _notyfy.length,
                    itemBuilder: (context, index) =>
                        AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                              child: InkWell(
                                  onTap: () {
                                    // Future.delayed(const Duration(seconds: 2)).then((s) {
                                    //   NotificationService().showNotification(
                                    //     id: 1,
                                    //     body: "Welcome",
                                    //     payload: "now",
                                    //     title: "My Dairy");});
                                  },
                                  child: _notificatiionFn(_notyfy[index])))),
                    ),
                  );
          },
        ));
  }

  Widget _notificatiionFn(NotificationModel notify) {
    return Column(
      children: [
        RSizedBox(height: 10.h),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50.h,
                width: 46.w,
                decoration: BoxDecoration(
                  color: AppColor.whiteClr,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                      width: 1,
                      color: AppColor.appColor,
                      style: BorderStyle.solid),
                ),
                child: const Image(image: AssetImage(Img.milk_sell)),
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${notify.userId}",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    Text("${notify.message}", style: TextStyle(fontSize: 14.sp))
                  ]))
        ]),
        // RSizedBox(height: 5.h),
        const Divider()
      ],
    );
  }
}
