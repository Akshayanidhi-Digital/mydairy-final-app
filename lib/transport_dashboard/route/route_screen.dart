import 'package:flutter/material.dart';
import 'package:mydairy/transport_dashboard/model/route_list_model.dart';

import '../../export.dart';
import 'controller.dart';

class TransportRouteScreen extends ConsumerWidget {
  const TransportRouteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routesApi = ref.watch(route_lst_provider);
    final routeData = ref.watch(tr_route_lst_Provider);
    return Scaffold(
      appBar: BaseAppBar(title: 'Routes List'),
      body: LoadingdataScreen(
          varBuild: routesApi,
          data: (mydata) {
            return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  RSizedBox(height: 10.sp),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
                  //     child: Text("Routes",
                  //         style: TextStyle(
                  //             color: AppColor.appColor, fontSize: 20.sp))),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  //     child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             "Routes",
                  //             style: TextStyle(
                  //                 color: AppColor.appColor, fontSize: 16.sp),
                  //           ),
                  //           buttonContainer(
                  //               onTap: () {
                  //                 // navigationTo(const AddRoutesScreen());
                  //               },
                  //               hight: 22.sp,
                  //               width: 49.sp,
                  //               txt: "Add",
                  //               fontSize: 12.sp)
                  //         ])),
                  ListView.builder(
                      // reverse: true,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: routeData.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                      child: TrRoutesListSrc(
                                          data: routeData[index])))))
                ]);
          }),
    );
  }
}

class TrRoutesListSrc extends ConsumerWidget {
  final RouteLstModel data;
  const TrRoutesListSrc({super.key, required this.data});

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
              RSizedBox(width: 15.sp),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  width: 300.sp,
                  child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Text("Route ID : ${data.routeId}",
                            overflow: TextOverflow.ellipsis),
                        Text("Route Name : ${data.routeName}",
                            overflow: TextOverflow.ellipsis),
                        // Text("Transporter : ${data.transporterId}",
                        //     overflow: TextOverflow.ellipsis),
                        Text("Driver : ${data.routeName}",
                            overflow: TextOverflow.ellipsis),
                        RSizedBox(height: 8.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //     buttonContainer(
                            //         onTap: () {
                            //           // showDialog(
                            //           //     context: context,
                            //           //     builder: (context) => TransportAlertBox(
                            //           //         route: true, route_data: data));
                            //           // print("id:::  ${data.id}");
                            //         },
                            //         borderRadius: BorderRadius.circular(30.r),
                            //         hight: 26.sp,
                            //         width: 100.w,
                            //         txt: "Status Update",
                            //         fontSize: 11.sp),
                            // RSizedBox(width: 8.sp),
                            // buttonContainer(
                            //     onTap: () {
                            //       // navigationTo(
                            //       //     AddRoutesScreen(edit: true, data: data));
                            //     },
                            //     borderRadius: BorderRadius.circular(30.r),
                            //     hight: 26.sp,
                            //     width: 100.w,
                            //     txt: "Edit",
                            //     fontSize: 11.sp)
                          ],
                        )
                      ]))
            ])));
  }
}
