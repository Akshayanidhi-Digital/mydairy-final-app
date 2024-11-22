import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';
import 'package:mydairy/export.dart';

import 'snf_chart_controller.dart';

final allSelectProvider = StateProvider.autoDispose<bool>((ref) => false);
final read_only_Provider = StateProvider.autoDispose<bool>((ref) => false);
final milkRateValue = StateProvider.autoDispose<double>((ref) => 0.0);

class ShowBoxSrc extends ConsumerWidget {
  final String? milkType;
  const ShowBoxSrc({super.key, this.milkType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomAppBarBtn(
        name: true,
        txt2: "Edit Rate",
        onTap: () => showDialog(
            context: context,
            builder: (context) {
              return AlertRSizedBox(
                milkType: milkType,
              );
            }));
  }
}

class AlertRSizedBox extends ConsumerStatefulWidget {
  final String? milkType;
  const AlertRSizedBox({super.key, this.milkType});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlertRSizedBoxState();
}

class _AlertRSizedBoxState extends ConsumerState<AlertRSizedBox> {
  final snf_from = TextEditingController();
  final snf_to = TextEditingController();
  final fat_from = TextEditingController();
  final fat_to = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final allSelectBuild = ref.watch(allSelectProvider);
    final read_only = ref.watch(read_only_Provider);
    final milkRatevalue = ref.watch(milkRateValue);
    return AlertDialogBox(
        actionsAlignment: MainAxisAlignment.start,
        textAlign: TextAlign.center,
        titleTextStyle: TextStyle(fontSize: 22, color: AppColor.blackClr),
        title: "Update Rate",
        actions: [
          Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Checkbox(
                value: allSelectBuild,
                onChanged: (bool? value) {
                  // setState(() {
                  if (value == true) {
                    ref.read(read_only_Provider.notifier).state = true;
                  } else {
                    ref.read(read_only_Provider.notifier).state = false;
                  }
                  ref.read(allSelectProvider.notifier).state = value!;
                  // });
                },
              ),
              const Text("All")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RSizedBox(
                  width: 72.0.w,
                  child: TxtField(
                      controller: snf_from,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      readOnly: read_only,
                      textAlign: TextAlign.center,
                      hintText: "SNF")),
              const Text("To",
                  style: TextStyle(color: AppColor.blackClr, fontSize: 16)),
              RSizedBox(
                  width: 72.0.w,
                  child: TxtField(
                      controller: snf_to,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      readOnly: read_only,
                      textAlign: TextAlign.center,
                      hintText: "SNF")),
            ]),
            RSizedBox(height: 10.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RSizedBox(
                  width: 72.0.w,
                  child: TxtField(
                      controller: fat_from,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      readOnly: read_only,
                      textAlign: TextAlign.center,
                      hintText: "FAT")),
              const Text("To",
                  style: TextStyle(color: AppColor.blackClr, fontSize: 16)),
              RSizedBox(
                  width: 72.0.w,
                  child: TxtField(
                      controller: fat_to,
                      readOnly: read_only,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      textAlign: TextAlign.center,
                      hintText: "FAT")),
            ]),
            const Text("Milk Rate", style: TextStyle(color: AppColor.blackClr)),
            RSizedBox(height: 10.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              buttonContainer(
                  onTap: () => ref.read(milkRateValue.notifier).state--,
                  borderRadius: BorderRadius.circular(4),
                  width: 20.w,
                  hight: 20.h,
                  // loder: true,
                  widget: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.whiteClr),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.remove,
                          size: 10, color: AppColor.whiteClr))),
              buttonContainer(
                  borderRadius: BorderRadius.circular(2),
                  width: 50.0.w,
                  hight: 20.0.h,
                  txt: milkRatevalue.toStringAsFixed(2),
                  fontSize: 12.w,
                  color: AppColor.whiteClr,
                  border: Border.all(),
                  txtColor: AppColor.blackClr),
              buttonContainer(
                  onTap: () {
                    milkRatevalue.toStringAsFixed(2);
                    return ref.read(milkRateValue.notifier).state++;
                  },
                  borderRadius: BorderRadius.circular(4),
                  width: 20.w,
                  hight: 20.h,
                  // loder: true,
                  widget: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.whiteClr),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(
                        Icons.add,
                        size: 10,
                        color: AppColor.whiteClr,
                      )))
            ]),
            RSizedBox(height: 15.h),
            RSizedBox(
              child: Row(children: [
                buttonContainer(
                    onTap: () => navigationPop(),
                    width: 110.0.w,
                    hight: 46.0.h,
                    txt: "Cancel",
                    color: AppColor.whiteClr,
                    border: Border.all(color: AppColor.appColor),
                    txtColor: AppColor.appColor),
                RSizedBox(width: 10.w),
                buttonContainer(
                    onTap: () {
                      final value = ref.watch(valueSnfProvider);
                      if (allSelectBuild == true) {
                        ref.read(chartApiProvider).rate_chart_update({
                          "milk_type": widget.milkType,
                          "rate_type": value == 0 ? "Sell" : "Purchase",
                          "is_all": allSelectBuild,
                          "value": milkRatevalue.toStringAsFixed(2)
                        });
                      } else {
                        if (snf_from.text.isNotEmpty &&
                            snf_to.text.isNotEmpty &&
                            fat_from.text.isNotEmpty &&
                            fat_to.text.isNotEmpty) {
                          ref.read(chartApiProvider).rate_chart_update({
                            "milk_type": widget.milkType,
                            "rate_type": value == 0 ? "Sell" : "Purchase",
                            "is_all": allSelectBuild,
                            "value": milkRatevalue.toStringAsFixed(2),
                            "fat_from": tt(fat_from),
                            "fat_to": tt(fat_to),
                            "snf_from": tt(snf_from),
                            "snf_to": tt(snf_to)
                          });
                        } else {
                          snackBarMessage(msg: "Field is Required");
                        }
                      }
                    },
                    width: 110.0.w,
                    hight: 46.0.h,
                    txt: "Ok",
                    txtColor: AppColor.whiteClr)
              ]),
            ),
            RSizedBox(height: 20.w)
          ])
        ]);
  }
}
