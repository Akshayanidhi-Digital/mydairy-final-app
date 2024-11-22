import 'package:flutter/material.dart';
import 'package:mydairy/dairy_users_dashboard/model/routes_list_model.dart';
import '../../../export.dart';
import '../../model/transportlist_model.dart';
import '../apis.dart';
import '../controller.dart';
import 'add_transporter_screen.dart';

class TransPorterManagementScreen extends ConsumerWidget {
  const TransPorterManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transportApi = ref.watch(transportListApiProvider);
    final data = ref.watch(transportListProvider);
    return Scaffold(
      appBar: BaseAppBar(title: "Transporter Management"),
      body: LoadingdataScreen(
        varBuild: transportApi,
        data: (mydata) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              RSizedBox(height: 10.sp),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
                  child: Text("Transporter Management",
                      style: TextStyle(
                          color: AppColor.appColor, fontSize: 20.sp))),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Transporter List",
                          style: TextStyle(
                              color: AppColor.appColor, fontSize: 16.sp),
                        ),
                        buttonContainer(
                            onTap: () {
                              navigationTo( AddTransporterScreen());
                            },
                            hight: 22.sp,
                            width: 49.sp,
                            txt: "Add",
                            fontSize: 12.sp)
                      ])),
              ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                                child: TranportListSrc(data: data[index])),
                          )))
            ],
          );
        },
      ),
    );
  }
}

class TranportListSrc extends ConsumerWidget {
  final TranportListModel data;
  const TranportListSrc({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: AppColor.ligthClr,
                borderRadius: BorderRadius.circular(20.sp)),
            height: 140.sp,
            width: double.infinity,
            child: Row(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.sp),
                  child: Container(
                    height: 70.sp,
                    width: 70.sp,
                    decoration: BoxDecoration(
                      color: AppColor.whiteClr,
                      border: Border.all(
                          color: data.isBlocked == 0
                              ? AppColor.appColor
                              : AppColor.redClr,
                          width: 2.0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.person,
                        size: 50.sp,
                        color: data.isBlocked == 0
                            ? AppColor.appColor
                            : AppColor.redClr),
                  )),
              RSizedBox(width: 15.sp),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  width: 230.sp,
                  child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Text("Transport ID : ${data.transporterId} ",
                            overflow: TextOverflow.ellipsis),
                        Text("Transport Name : ${data.transporterName}",
                            overflow: TextOverflow.ellipsis),
                        Text("Name : ${data.name}",
                            overflow: TextOverflow.ellipsis),
                        Text("Mobile No. : ${data.mobile}",
                            overflow: TextOverflow.ellipsis),
                        RSizedBox(height: 8.sp),
                        Padding(
                            padding: EdgeInsets.only(right: 70.sp),
                            child: buttonContainer(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          TransportAlertBox(data: data));
                                  print("id:::  ${data.id}");
                                },
                                borderRadius: BorderRadius.circular(30.r),
                                hight: 26.sp,
                                txt: "Status Update",
                                fontSize: 11.sp)),
                      ]))
            ])));
  }
}

class TransportAlertBox extends ConsumerWidget {
  final TranportListModel? data;
  final RouteListModel? route_data;
  final bool route;
  const TransportAlertBox(
      {super.key, this.data, this.route_data, this.route = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: RSizedBox(
        height: 130.h,
        child: Column(
          children: [
            Icon(size: 25.sp, Icons.block_sharp, color: Colors.orange),
            Text(
              "Are you sure?",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.appColor),
            ),
            Text(
                "You want to ${data!.isBlocked == 0 ? "block" : "unblock"} user",
                style: TextStyle(fontSize: 17.sp)),
            RSizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonContainer(
                    onTap: () => navigationPop(),
                    color: AppColor.redClr,
                    hight: 26.sp,
                    width: 50.sp,
                    fontSize: 14.sp,
                    txt: "No"),
                RSizedBox(width: 20.h),
                buttonContainer(
                    onTap: () {
                      if (route) {
                        // ref
                        //     .read(routeListModelProvider.notifier)
                        //     .updateRouteStatus(
                        //         data!.id, data!.isBlocked == 0 ? 1 : 0);
                      } else {
                        ref
                            .read(masterApiProvider)
                            .transportStatus(data!.transporterId!)
                            .then((value) => navigationPop());
                      }
                      print("data.id : ${data!.isBlocked}");
                    },
                    color: AppColor.appColor,
                    hight: 26.sp,
                    width: 50.sp,
                    fontSize: 14.sp,
                    txt: "Yes"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
