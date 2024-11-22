// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';
import '../../../export.dart';
import '../../customers/add_customer/controller.dart';
import '../milk_buy_scr.dart';
import '../../model/profile_model.dart';
import '../../model/view_by_entry_model.dart';
import '../../profile/controller.dart';
import '../../view_by_entry/view_entry_screen.dart';
import 'blutooth_printer.dart';
import 'controller.dart';

// var totalAmount;

class SiftTiimeScreen extends ConsumerStatefulWidget {
  const SiftTiimeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SiftTiimeScreenState();
}

class _SiftTiimeScreenState extends ConsumerState<SiftTiimeScreen> {
  Costumers? customerlst;
  @override
  Widget build(BuildContext context) {
    final milkEntryBuild = ref.watch(milkentryApiProvider);
    // final milksellEntryBuild = ref.watch(milksellEntryApiProvider);
    final controller = ref.watch(siftControllerProvider.notifier);
    final times = ref.watch(timeProvider);
    final shifts = ref.watch(shiftProvider);
    final backData = ref.watch(backDataProvider);
    final milkTypeValue = ref.watch(milkTypeValueprovider);
    final getList = ref.watch(getListProvider);
    final type = ref.watch(valueChangeProvider);
    final amounts = ref.watch(amountlistProvider);
    final user = ref.watch(dairyListProvider);
    final typeValue = ref.watch(typelstProvider);
    final usersLst = ref.watch(userCustomerProvider);
    ref.read(siftControllerProvider.notifier).customerlist(type);

    return Scaffold(
      appBar: BaseAppBar(
        title: "Milk Entry",
        actionList: [
          Text(times.toString().split('-').reversed.join('-'),
              style: TextStyle(fontSize: 17.sp)),
          RSizedBox(width: 10.w),
          Icon(shifts == "M" ? Icons.sunny : Icons.dark_mode),
          RSizedBox(width: 10.w),
        ],
      ),
      body: LoadingdataScreen(
        varBuild: milkEntryBuild,
        data: (mydata) {
          List<RecordsModel> records = [];
          for (var i = 0; i < mydata.length; i++) {
            records.add(RecordsModel.fromJson(mydata[i]));
          }
          return SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(20.0.r),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: CtmDropDown(
                          // inisialvalue: null,
                          inisialvalue: typeValue == '' ? null : typeValue,
                          onChanged: (value) {
                            backData.clear();
                            var values = user.costumers!
                                .where((e) => e.userType == value!);
                            customerlst = values.first;

                            ref.read(typelstProvider.notifier).state = value!;

                            ref.read(customerListProvider);
                            controller.idController.clear();
                            controller.weightController.clear();
                            controller.fatController.clear();
                            controller.snfController.clear();
                            ref.refresh(getListProvider);
                          },
                          hintTxt: "Select type",
                          lst: usersLst == null || usersLst.isEmpty
                              ? []
                              : usersLst.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.userType,
                                    child: Text(
                                      item.name!,
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                      RSizedBox(width: 15.w),
                      Expanded(
                          child: TxtField(
                        onTap: () async {
                          typeValue.isEmpty
                              ? snackBarMessage(msg: "Please select type")
                              : await showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(),
                                  useRootNavigator: true,
                                  isScrollControlled: true,
                                  context: context,
                                  barrierColor: Colors.yellow.withAlpha(20),
                                  useSafeArea: true,
                                  builder: (_) => DragableListSrc(type: type));
                        },
                        readOnly: true,
                        hintText: (backData.isEmpty)
                            ? "${customerlst == null ? "Farmer" : customerlst!.name} List"
                            : "${backData[0].name}",
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: const CircleAvatar(
                              backgroundColor: AppColor.appColor,
                              radius: 5,
                              child: Icon(Icons.add, color: AppColor.whiteClr)),
                        ),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: MilkTyPeSrc(milktype: true)),
                      RSizedBox(width: 15.w),
                      Expanded(
                          child: TxtField(
                              onChanged: (value) {
                                controller.farmerMilkAddORRateCalculate(
                                    type,
                                    1,
                                    backData[0],
                                    shifts,
                                    times,
                                    milkTypeValue,
                                    value,
                                    controller.fatController.text,
                                    controller.snfController.text,
                                    typeValue);
                              },
                              readOnly: backData.isEmpty ? true : false,
                              fillColor: backData.isEmpty
                                  ? AppColor.grey
                                  : AppColor.txtwhite,

                              // labelText:
                              //     backData == "" ? "" : "Weight", // "Weight",
                              controller: controller.weightController,
                              keyboardType: TextInputType.number,
                              hintText: "Weight")),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TxtField(
                              fillColor: backData.isEmpty
                                  ? AppColor.grey
                                  : backData[0].isFixedRate == 1 &&
                                          backData[0].fixedRateType == 0
                                      ? AppColor.grey
                                      : AppColor.txtwhite,
                              readOnly: backData.isEmpty
                                  ? true
                                  : backData[0].isFixedRate == 1 &&
                                          backData[0].fixedRateType == 0
                                      ? true
                                      : false,
                              onChanged: (value) {
                                if (value!.isEmpty) {
                                  print(" iam value $value");
                                  ref
                                      .read(getListProvider.notifier)
                                      .state
                                      .clear();
                                } else {
                                  print("object iam else $value");
                                  controller.farmerMilkAddORRateCalculate(
                                      type,
                                      1,
                                      backData[0],
                                      shifts,
                                      times,
                                      milkTypeValue,
                                      controller.weightController.text,
                                      value,
                                      controller.snfController.text,
                                      typeValue);
                                }
                              },
                              controller: controller.fatController,
                              keyboardType: TextInputType.number,
                              // labelText: "Fat",
                              hintText: "Fat")),
                      RSizedBox(width: 15.w),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TxtField(
                            fillColor: backData.isEmpty
                                ? AppColor.grey
                                : backData[0].isFixedRate == 1
                                    ? AppColor.grey
                                    : AppColor.txtwhite,
                            readOnly: backData.isEmpty
                                ? true
                                : backData[0].isFixedRate == 1
                                    ? true
                                    : false,
                            onChanged: (value) {
                              controller.farmerMilkAddORRateCalculate(
                                  type,
                                  1,
                                  backData[0],
                                  shifts,
                                  times,
                                  milkTypeValue,
                                  controller.weightController.text,
                                  controller.fatController.text,
                                  value,
                                  typeValue);
                            },
                            controller: controller.snfController,
                            keyboardType: TextInputType.number,
                            // labelText: "SNF/CLR",
                            hintText: "SNF/CLR"),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TxtField(
                              fillColor: AppColor.bluelightClr,
                              hintText: getList.isEmpty
                                  ? "Rs./Ltr"
                                  : "${df(getList[0]['per_unit'].toString())} Rs./Ltr",
                              readOnly: true)),
                      RSizedBox(width: 15.w),
                      Expanded(
                          child: TxtField(
                        readOnly: true,
                        fillColor: AppColor.bluelightClr,
                        hintText: getList.isEmpty
                            ? "Total Rs."
                            : "Total Rs. ${getList[0]['total'].toString()}",
                      )),
                    ],
                  ),
                  RSizedBox(height: 25.h),
                  buttonContainer(
                      loder: ref.watch(loadingProvider),
                      width: double.infinity,
                      onTap: () {
                        if (backData.isNotEmpty) {
                          controller.farmerMilkAddORRateCalculate(
                              type,
                              0,
                              backData[0],
                              shifts,
                              times,
                              milkTypeValue,
                              controller.weightController.text,
                              controller.fatController.text,
                              controller.snfController.text,
                              typeValue);
                          Future.delayed(
                              const Duration(seconds: 1),
                              () => ref.read(loadingProvider.notifier).state =
                                  false);
                        } else {
                          snackBarMessage(
                              msg: "Id is Empty, Please select id. !");
                        }
                      },
                      txt: "Save"),
                  RSizedBox(height: 25.h)
                ]),
              ),
              CustomerDataList(data: records, type: type)
            ]),
          );
        },
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        height: 90.h,
        color: AppColor.appColor,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    "Avg.Fat \n ${amounts.isEmpty ? "0.00" : df(amounts['avgFat'].toString())} ",
                    style: TextStyle(color: AppColor.whiteClr)),
                Text(
                    "Weight \n  ${amounts.isEmpty ? "0.00" : df(amounts['totalWeight'].toString())}",
                    style: TextStyle(color: AppColor.whiteClr)),
                Text(
                    "Amount \n Rs. ${amounts.isEmpty ? "0.00" : df(amounts['totalAmount'].toString())}",
                    style: TextStyle(color: AppColor.whiteClr)),
              ],
            ),
            RSizedBox(height: 50.h)
          ],
        ),
      ),
    );
  }
}
