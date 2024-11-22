import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import '../../model/plan_membership_model.dart';
import '../membership_src.dart';

class PlanStatusScreen extends ConsumerStatefulWidget {
  final String id;
  final MemberShipModel? data;
  const PlanStatusScreen({super.key, required this.id, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlanStatusScreenState();
}

class _PlanStatusScreenState extends ConsumerState<PlanStatusScreen> {
  @override
  void initState() {
    _plangst(widget.data!.price!.toDouble());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: "Plan Status"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              MemberPurchageSrc(
                validity2: widget.data!.category.toString(),
                height: 159.0.h,
                price: widget.data!.price!.toStringAsFixed(2),
                validity:
                    "${widget.data!.duration.toString()} ${widget.data!.durationType.toString()}",
                color: const Color(0xff5A5757),
                inerColor: const Color(0xff5A5757),
              ),
              RSizedBox(height: 40.h),
              Container(
                  height: 182,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff5A5757),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      RSizedBox(height: 10.0.h),
                      planStatusFn(
                          txt1: "Pre-GST Amount:",
                          txt2: (double.parse(widget.data!.price.toString()) -
                                  gstValue)
                              .toStringAsFixed(2)),
                      const Divider(color: AppColor.whiteClr),
                      planStatusFn(
                          txt1: "GST(18%) :",
                          txt2: gstValue.toStringAsFixed(2)),
                      const Divider(color: AppColor.whiteClr),
                      planStatusFn(
                          txt1: "Total:", txt2: widget.data!.price.toString())
                    ],
                  )),
              RSizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttonContainer(
                      onTap: () => navigationPop(),
                      txt: "Cancel",
                      width: 145.0.w,
                      color: const Color(0xffF7422D)),
                  buttonContainer(
                      onTap: () {
                        // plangst(399.00);
                        // ref.read(masterApiProvider).planPurchase(id);
                      },
                      txt: "Pay",
                      width: 145.0.w,
                      color: const Color(0xff28A745)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  double gstValue = 0.0;
  _plangst(double price) {
    var plan = price / 100 * 18;
    gstValue = plan;
    print("plan $plan");
  }
}

Widget planStatusFn({
  String? txt1,
  String? txt2,
}) {
  return Column(
    children: [
      RSizedBox(height: 10.0.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              txt1!,
              style: TextStyle(color: AppColor.whiteClr, fontSize: 18.sp),
            ),
            Text(
              txt2!,
              style: TextStyle(color: AppColor.whiteClr, fontSize: 18.sp),
            )
          ],
        ),
      ),
    ],
  );
}
