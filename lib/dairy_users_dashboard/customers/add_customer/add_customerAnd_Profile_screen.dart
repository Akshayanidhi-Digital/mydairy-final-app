// ignore_for_file: must_be_immutable, file_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import '../../model/Costumer_list_model.dart';
import '../../profile/controller.dart';
import 'advance_option.dart';
import 'controller.dart';
import 'model.dart';

final pickNumberProvider = StateProvider.autoDispose<String>((ref) => '');
final milkValueProvider = StateProvider.autoDispose<bool>((ref) => false);
final advanceValueProvider = StateProvider.autoDispose<bool>((ref) => false);

final rateCustomerProvider = StateProvider.autoDispose<int>((ref) => 0);
// final addFarmer3Provider = StateProvider.autoDispose((ref) => 0);

class AddCustomerScreen extends ConsumerStatefulWidget {
  String? customerValue;
  bool profileEdit;
  // bool buyer;
  final CostumerModel? profileData;
  AddCustomerScreen(
      {super.key,
      this.profileEdit = false,
      // this.buyer = false,
      this.profileData,
      required this.customerValue});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddCustomerScreenState();
}

class _AddCustomerScreenState extends ConsumerState<AddCustomerScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController fixRateController = TextEditingController();
  TextEditingController fixPriceController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  profileUpdateFn() {
    numberController.text = widget.profileData!.mobile!;
    nameController.text = widget.profileData!.name!;
    emailController.text = widget.profileData!.email!;
    fatherNameController.text = widget.profileData!.fatherName!;
    fixRateController.text = widget.profileData!.fatRate.toString();
    fixPriceController.text = widget.profileData!.rate.toString();
  }

  @override
  void initState() {
    widget.profileEdit == true ? profileUpdateFn() : "";
    Future(() => ref.read(selectedItemProvider.notifier).state =
        widget.customerValue.toString());
    super.initState();
  }

  @override
  void dispose() {
    fixRateController.clear();
    fixPriceController.clear();
    emailController.clear();
    nameController.clear();
    fatherNameController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final picksNumber = ref.watch(pickNumberProvider);
    final user = ref.watch(dairyListProvider);
    final itemValue = ref.watch(selectedItemProvider);
    final advanceValue = ref.watch(advanceValueProvider);
    final dairyRateBuild = ref.watch(dairyRateProvider);
    numberController.text =
        picksNumber == "" ? numberController.text : picksNumber;
    log("item:::::  itemValue   $itemValue");

    return Scaffold(
      appBar: BaseAppBar(
          title: widget.profileEdit == true ? "Edit_Profile" : "Add_Customer"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RSizedBox(height: 20.h),
                CtmDropDown(
                  inisialvalue: itemValue == '' ? null : itemValue,
                  onChanged: (value) {
                    print("item:::::::::: $itemValue");
                    ref.read(selectedItemProvider.notifier).state = value!;
                  },
                  hintTxt: "Select type",
                  lst: user.costumers == null
                      ? []
                      : user.costumers!
                          .map((item) => DropdownMenuItem<String>(
                                value: item.userType,
                                child: Text(
                                  item.name!,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ))
                          .toList(),
                ),
                // const Align(
                //     alignment: Alignment.center,
                //     child: Image(image: AssetImage(Img.profilePic))),
                // RadioSettingValue2(txt2: 5),
                // RSizedBox(height: 20.0.h),
                // (widget.farmerValue == 0 || widget.farmerValue == 1)
                //     ? Text('')
                //     :

                RSizedBox(height: 20.h),
                TxtField(
                  controller: numberController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  labelText: "Phone_Number".tr(),
                  hintText: "Phone_Number".tr(),
                  validator: validateMobile,
                  onChanged: (value) {
                    numberController.text = valueMobile(value!);
                  },
                  suffixIcon: InkWell(
                      onTap: () {
                        ref.read(pickContectCustomerProvider).pickContactFn();
                      },
                      child: const Image(image: AssetImage(Img.contect))),
                ),
                RSizedBox(height: 10.h),
                TxtField(
                    controller: emailController,
                    hintText: "Email".tr(),
                    labelText: "Email".tr()),
                RSizedBox(height: 10.h),
                TxtField(
                  controller: nameController,
                  hintText: "Name".tr(),
                  labelText: "Name".tr(),
                  validator: (value) {
                    return validateNameField(value, "Name".tr());
                  },
                ),
                RSizedBox(height: 10.h),
                TxtField(
                  controller: fatherNameController,
                  hintText: "Father_Name".tr(),
                  labelText: "Father_Name".tr(),
                  validator: (value) {
                    return validateNameField(value, "Father_Name".tr());
                  },
                ),
                RSizedBox(height: 10.h),

                if (itemValue == "FAR" || itemValue == "BYR")
                  buttonContainer(
                      onTap: () {
                        ref.read(advanceValueProvider.notifier).state = true;
                      },
                      hight: 35.0.h,
                      width: 82.0.w,
                      txt: "Advance",
                      fontSize: 16.sp,
                      color: AppColor.whiteClr,
                      border: Border.all(),
                      txtColor: AppColor.blackClr),
                RSizedBox(height: 10.h),

                advanceValue
                    ? AdvanceOptionScr(
                        fatRate: fixRateController,
                        fixPrice: fixPriceController,
                      )
                    : const RSizedBox(),
                RSizedBox(height: 20.h),
                buttonContainer(
                    onTap: () {
                      if (advanceValue == true) {
                        if (dairyRateBuild == 1) {
                          if (fixRateController.text.isEmpty) {
                            snackBarMessage(msg: "Please Enter Fat");
                          } else {
                            widget.profileEdit == true
                                ? ref.read(farmerApiProvider).customerUpdate(
                                    data: CustomerAddModel(
                                            costumer_id: widget
                                                .profileData!.costumer_id
                                                .toString(),
                                            costumertype: itemValue,
                                            countryCode: "+91",
                                            // farmerId: widget.buyer == false
                                            //     ? widget.profileData!.farmerId!
                                            //     : widget.profileData!.buyerId!,
                                            name: nameController.text.trim(),
                                            fatherName: fatherNameController
                                                .text
                                                .trim(),
                                            mobile:
                                                numberController.text.trim(),
                                            email: emailController.text.trim(),
                                            isFixedRate: 1,
                                            fixedRateType: 1,
                                            fat_rate:
                                                fixRateController.text.trim())
                                        .toJson())
                                : ref.read(farmerApiProvider).addCustomers(
                                    context: context,
                                    data: CustomerAddModel(
                                            costumertype: itemValue,
                                            countryCode: "+91",
                                            name: nameController.text.trim(),
                                            fatherName: fatherNameController
                                                .text
                                                .trim(),
                                            mobile:
                                                numberController.text.trim(),
                                            email: emailController.text.trim(),
                                            isFixedRate: 1,
                                            fixedRateType: 1,
                                            fat_rate:
                                                fixRateController.text.trim())
                                        .toJson());
                          }
                        } else if (dairyRateBuild == 2) {
                          if (fixPriceController.text.isEmpty) {
                            snackBarMessage(msg: "Please Enter Price");
                          } else {
                            widget.profileEdit == true
                                ? ref.read(farmerApiProvider).customerUpdate(
                                    data: CustomerAddModel(
                                            costumer_id: widget
                                                .profileData!.costumer_id
                                                .toString(),
                                            costumertype: itemValue,
                                            countryCode: "+91",
                                            name: nameController.text.trim(),
                                            fatherName: fatherNameController
                                                .text
                                                .trim(),
                                            mobile:
                                                numberController.text.trim(),
                                            email: emailController.text.trim(),
                                            isFixedRate: 1,
                                            fixedRateType: 0,
                                            rate:
                                                fixPriceController.text.trim())
                                        .toJson())
                                : ref.read(farmerApiProvider).addCustomers(
                                    context: context,
                                    data: CustomerAddModel(
                                            costumertype: itemValue,
                                            countryCode: "+91",
                                            name: nameController.text.trim(),
                                            fatherName: fatherNameController
                                                .text
                                                .trim(),
                                            mobile:
                                                numberController.text.trim(),
                                            email: emailController.text.trim(),
                                            isFixedRate: 1,
                                            fixedRateType: 0,
                                            rate:
                                                fixPriceController.text.trim())
                                        .toJson());
                          }
                        } else {
                          ref.read(farmerApiProvider).addCustomers(
                              context: context,
                              data: CustomerAddModel(
                                      costumertype: itemValue,
                                      countryCode: "+91",
                                      name: nameController.text.trim(),
                                      fatherName:
                                          fatherNameController.text.trim(),
                                      mobile: numberController.text.trim(),
                                      email: emailController.text.trim(),
                                      isFixedRate: 0)
                                  .toJson());
                        }
                      } else {
                        if (formkey.currentState!.validate()) {
                          widget.profileEdit == true
                              ? ref.read(farmerApiProvider).customerUpdate(
                                      data: CustomerAddModel(
                                    costumertype: itemValue,
                                    costumer_id: widget.profileData!.costumer_id
                                        .toString(),
                                    countryCode: "+91",
                                    name: nameController.text.trim(),
                                    fatherName:
                                        fatherNameController.text.trim(),
                                    mobile: numberController.text.trim(),
                                    email: emailController.text.trim(),
                                  ).toJson())
                              : ref.read(farmerApiProvider).addCustomers(
                                  context: context,
                                  data: CustomerAddModel(
                                    costumertype: itemValue,
                                    countryCode: "+91",
                                    name: nameController.text.trim(),
                                    fatherName:
                                        fatherNameController.text.trim(),
                                    mobile: numberController.text.trim(),
                                    email: emailController.text.trim(),
                                  ).toJson());
                        }
                      }
                    },
                    width: double.infinity,
                    loder: ref.watch(loadingProvider),
                    txt: widget.profileEdit == true ? "Update" : "Save"),
                RSizedBox(height: 150.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
