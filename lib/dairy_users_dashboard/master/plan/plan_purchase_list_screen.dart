import 'package:flutter/material.dart';
import '../../../export.dart';
import '../controller.dart';
import 'plan_ctr.dart';
import 'plan_status_details.dart';

class PlanPurchaseScreen extends ConsumerWidget {
  const PlanPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan_list = ref.watch(planPurchageListApiProvider);
    final data = ref.watch(plan_purchage_list_Provider);
    return Scaffold(
      appBar: BaseAppBar(title: "Plan Recharge"),
      body: LoadingdataScreen(
        varBuild: plan_list,
        data: (mydata) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColor.whiteClr,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: AppColor.grey, offset: Offset(0, 2), blurRadius: 6)
                ]),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Plan Recharge",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold)))),
                // const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: InkWell(
                                onTap: () {
                                  navigationTo(
                                      PlanStatusDetails(status: data[index]));
                                },
                                child: Column(children: [
                                  Row(children: [
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Container(
                                            child: Column(children: [
                                      const Icon(
                                        Icons.circle,
                                        color: AppColor.appColor,
                                      ),
                                      Container(
                                          width: 3,
                                          height: 70.w,
                                          color: AppColor.blackClr)
                                    ]))),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        flex: 9,
                                        child: Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                  "${data[index].plan!.name} ( ${data[index].plan!.category} )",
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 18)),
                                              Text(
                                                "${data[index].plan!.description}",
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 18),
                                              ),
                                              Row(children: [
                                                const Icon(
                                                    Icons.watch_later_outlined),
                                                RSizedBox(width: 5.h),
                                                Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    "${data[index].plan!.duration} ${data[index].plan!.durationType} before")
                                              ]),
                                              SizedBox(height: 10.h)
                                            ]))),
                                    RSizedBox(width: 30..w)
                                  ])
                                ]),
                              ))),
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
