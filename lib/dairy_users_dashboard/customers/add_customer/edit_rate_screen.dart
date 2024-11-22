import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import '../../model/Costumer_list_model.dart';
import 'controller.dart';
import 'model.dart';

final dairyRateProvider = StateProvider.autoDispose<int>((ref) => 0);

class EditRateScreen extends ConsumerStatefulWidget {
  final CostumerModel data;
  final bool buyer;
  final String farmerid;
  const EditRateScreen(
      {super.key,
      required this.farmerid,
      required this.data,
      this.buyer = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditRateScreenState();
}

class _EditRateScreenState extends ConsumerState<EditRateScreen> {
  TextEditingController fixRateController = TextEditingController();
  TextEditingController fixPriceController = TextEditingController();

  @override
  void dispose() {
    fixRateController.clear();
    fixPriceController.clear();
    super.dispose();
  }

  @override
  void initState() {
    fixRateController.text = widget.data.fatRate.toString();
    fixPriceController.text = widget.data.rate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemValue = ref.watch(selectedItemProvider);
    final dairyRateBuild = ref.watch(dairyRateProvider);
    return Scaffold(
      appBar: BaseAppBar(
        title: "Edit Rate",
      ),
      body: Column(
        children: [
          RSizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dairyRateTxt.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => RadioListTile(
                              activeColor: AppColor.appColor,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(dairyRateTxt[index].txt.tr()),
                              value: index,
                              groupValue: dairyRateBuild,
                              onChanged: (value) {
                                ref.read(dairyRateProvider.notifier).state =
                                    value!;
                                log(value.toString());
                              },
                            )),
                  ),
                  RSizedBox(height: 20.h),
                  if (dairyRateBuild == 1)
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 35.w),
                              child: RSizedBox(
                                  width: 132.w,
                                  child: TxtField(
                                      controller: fixRateController,
                                      keyboardType: TextInputType.number,
                                      hintText: "0.00",
                                      labelText: "Rate"))),
                          RSizedBox(height: 10.h)
                        ]),
                  if (dairyRateBuild == 2)
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: TxtField(
                                            controller: fixPriceController,
                                            keyboardType: TextInputType.number,
                                            hintText: "0.00",
                                            labelText: "Rate"))
                                  ]))
                        ]),
                  RSizedBox(height: 20.h),
                  Center(
                      child: buttonContainer(
                          onTap: () {
                            if (dairyRateBuild == 1) {
                              if (fixRateController.text.isEmpty) {
                                snackBarMessage(
                                    msg: "Please enter Rate"
                                    );
                              } else {
                                ref.read(farmerApiProvider).customerUpdate(
                                    data: CustomerAddModel(
                                            costumer_id: widget.data.costumer_id
                                                .toString(),
                                            costumertype: itemValue,
                                            countryCode: "+91",
                                            name: widget.data.name,
                                            fatherName: widget.data.fatherName,
                                            mobile: widget.data.mobile,
                                            isFixedRate: 1,
                                            fixedRateType: 1,
                                            fat_rate:
                                                fixRateController.text.trim())
                                        .toJson());
                              }
                            } else if (dairyRateBuild == 2) {
                              if (fixPriceController.text.isEmpty) {
                                snackBarMessage(
                                    msg: "Please enter Price",
                                    color: AppColor.redClr);
                              } else {
                                ref.read(farmerApiProvider).customerUpdate(
                                    data: CustomerAddModel(
                                            costumer_id: widget.data.costumer_id
                                                .toString(),
                                            costumertype: itemValue,
                                            countryCode: "+91",
                                            name: widget.data.name,
                                            fatherName: widget.data.fatherName,
                                            mobile: widget.data.mobile,
                                            isFixedRate: 1,
                                            fixedRateType: 0,
                                            fat_rate:
                                                fixPriceController.text.trim())
                                        .toJson());
                              }
                            } else {
                              ref.read(farmerApiProvider).customerUpdate(
                                  data: CustomerAddModel(
                                          costumer_id: widget.data.costumer_id
                                              .toString(),
                                          costumertype: itemValue,
                                          name: widget.data.name,
                                          fatherName: widget.data.fatherName,
                                          mobile: widget.data.mobile,
                                          countryCode: "+91",
                                          isFixedRate: 0)
                                      .toJson());
                            }
                          },
                          txt: "Save Rate")),
                  RSizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
