import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';

import '../../../export.dart';
import '../../model/plan_perchage_list.dart';

class PlanStatusDetails extends ConsumerWidget {
  final PlanPurchageListModel? status;
  const PlanStatusDetails({super.key, this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(title: "Plan Status"),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  planlable("Plan Status"),
                  plantext("${status!.plan!.name}"),
                  RSizedBox(height: 10.0.h),
                  planlable("Payment ID"),
                  plantext("${status!.paymentId}"),
                  RSizedBox(height: 10.0.h),
                  planlable("Payment Method"),
                  plantext("${status!.paymentMethod}"),
                  RSizedBox(height: 10.0.h),

                  //Todo :::::
                  Row(children: [
                    Expanded(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          planlable("Payment staus"),
                          plantext("${_cash()['status']}",
                              color: _cash()['color']),
                        ],
                      ),
                    )),
                    RSizedBox(width: 10.0.w),
                    Expanded(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          planlable("status"),
                          plantext("${_status()['status']}",
                              color: _status()['color'])
                        ],
                      ),
                    )),
                  ]),

                  //Todo::::::::::
                  RSizedBox(height: 10.0.h),
                  planlable("Amount"),
                  plantext(df(status!.amount.toString())),
                  RSizedBox(height: 10.0.h),
                  Row(children: [
                    Expanded(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          planlable("Start Date"),
                          plantext(status!.startDate!
                              .split(" ")
                              .removeAt(0)
                              .toString()
                              .split("-")
                              .reversed
                              .join("-")
                              .toString())
                        ],
                      ),
                    )),
                    RSizedBox(width: 10.0.w),
                    Expanded(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          planlable("End Date"),
                          plantext(status!.endDate!
                              .split(" ")
                              .removeAt(0)
                              .toString()
                              .split("-")
                              .reversed
                              .join("-")
                              .toString())
                        ],
                      ),
                    )),
                  ]),
                  RSizedBox(height: 60.h),
                  if (_cash()['status'] == "Initiated")
                    Align(
                        alignment: Alignment.center,
                        child: buttonContainer(
                            color: AppColor.greenClr,
                            // margin: REdgeInsets.symmetric(horizontal: 10.w),
                            borderRadius: BorderRadius.circular(50),
                            width: 200.w,
                            onTap: () {},
                            txt: "Pay"))
                ]),
          )),
    );
  }

  _cash() {
    // 1 initiated,2 complete,3 cancelled
    switch (status!.paymentStatus) {
      case 1:
        return {"color": AppColor.appColor, "status": "Initiated"};
      case 2:
        return {"color": AppColor.greenClr, "status": "Complete"};

      default:
        return {"color": AppColor.redClr, "status": "Cancelled"};
    }
  }

  _status() {
// 1=active,0=inactive,2=expired
    switch (status!.status) {
      case 0:
        return {"color": AppColor.appColor, "status": "Inactive"};
      case 1:
        return {"color": AppColor.greenClr, "status": "Active"};
      default:
        return {"color": AppColor.redClr, "status": "Expired"};
    }
  }
}

plantext(text, {Color? color}) {
  return Container(
    alignment: Alignment.centerLeft,
    width: double.infinity,
    height: 42.0.h,
    decoration: BoxDecoration(
        color: color ?? AppColor.transparent,
        border: Border.all(),
        borderRadius: BorderRadius.circular(20.r)),
    child: RPadding(
      padding: EdgeInsets.only(left: 10.0.w),
      child: Text(
        text,
        style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.yellowClr),
      ),
    ),
  );
}

planlable(lable) {
  return Text(lable,
      style: TextStyle(
        fontSize: 16.0.sp,
        color: AppColor.appColor,
        overflow: TextOverflow.ellipsis,
      ));
}
