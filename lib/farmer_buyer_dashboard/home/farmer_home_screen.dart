// ignore_for_file: file_names, avoid_print, prefer_final_fields, unused_field, depend_on_referenced_packages, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:mydairy/export.dart';
import 'package:mydairy/farmer_buyer_dashboard/componant/MilkSellRecordsTable.dart';
import 'package:mydairy/farmer_buyer_dashboard/home/controller.dart';

import '../../common/widgets/decor.dart';
import '../../authentication/check_user.dart';
import '../../common/widgets/function.dart';
import '../../dairy_users_dashboard/model/farmer_buyer_profile_model.dart';

final List<String> imgList = [
  'assets/images/slider1.png',
  'assets/images/slider2.png',
  'assets/images/slider3.png',
];
List<FarmerBuyerData> farmer = [];

class FarmerHome extends ConsumerStatefulWidget {
  final bool buyer;
  const FarmerHome({super.key, required this.buyer});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FarmerHomeState();
}

class _FarmerHomeState extends ConsumerState<FarmerHome> {
  DateTimeFieldPickerPlatform platform = DateTimeFieldPickerPlatform.material;

  @override
  void didChangeDependencies() {
    Future(() => ref.read(buyerloginProvider.notifier).state = widget.buyer);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    ref.read(farmerDataApiProvider).checkLoginStatus(buyer: widget.buyer);
    super.initState();
  }

  _logout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialogBox(
        title: "  Log Out ?\n",
        content: 'Are you sure you want to logout ?\n',
        titleTextStyle: TextStyle(
            color: AppColor.appColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700),
        onPressed1: () => navigationPop(),
        onPressed2: () async {
          await ref.read(storageProvider).deleteAll();
          navigationRemoveUntil(const UserCheckLoginScreen());
          snackBarMessage(msg: "Logout Successfully", color: AppColor.greenClr);
        },
      ),
    );
  }

  void _changeLanguage(String language) {
    print("Change Language to $language pressed");
  }

  @override
  Widget build(BuildContext context) {
    final selectedDairy = ref.watch(selectedDairyProvider);
    final startDate = ref.watch(startDateProvider);
    final endDate = ref.watch(endDateProvider);
    final milkData = ref.watch(milkDataListProvider);

    var mwidth = (MediaQuery.of(context).size.width * .8);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image(
                image: const AssetImage('assets/logo.png'),
                width: 30.w,
                height: 30.h,
              ),
              SizedBox(width: 10.h),
              const Text(
                "MYDAIRY",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    color: AppColor.whiteClr),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.translate, color: AppColor.whiteClr),
              onSelected: _changeLanguage,
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem<String>(
                    value: 'English',
                    child: Text('English'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Hindi',
                    child: Text('Hindi'),
                  ),
                ];
              },
            ),
            const IconButton(
                icon: Icon(Icons.person),
                color: AppColor.whiteClr,
                onPressed: FunctionClass.navigateToProfile),
            IconButton(
                icon: const Icon(Icons.logout),
                color: AppColor.whiteClr,
                onPressed: _logout),
          ],
        ),
        body: Column(children: [
          ImageSlider(imgList: imgList),
          SizedBox(height: 20.h),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                4,
                (index) => FarmerHMbtn(
                  onPressed: () {
                    homeImage[index].ontap.call();
                  },
                  image: AssetImage(homeImage[index].image),
                  labeltext: homeImage[index].name,
                ),
              )),
          SizedBox(height: 20.sp),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            style: const TextStyle(color: AppColor.appColor),
                            iconEnabledColor: AppColor.appColor,
                            hint: const Text("Select Dairy"),
                            value: selectedDairy,
                            items: [
                              const DropdownMenuItem(
                                value: "",
                                child: Text(
                                  "Select Dairy",
                                  style: TextStyle(
                                      color: AppColor.blackClr,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              ...dairy_list
                                  .map<DropdownMenuItem<String>>((datas) {
                                return DropdownMenuItem(
                                    value: datas.userId,
                                    child: Text(datas.dairyName!,
                                        style: const TextStyle(
                                            color: AppColor.blackClr)));
                              }),
                            ],
                            onChanged: (newValue) {
                              ref.read(selectedDairyProvider.notifier).state =
                                  newValue!;
                            })),
                    SizedBox(
                      width: mwidth / 4,
                      child: DateTimeField(
                        hideDefaultSuffixIcon: true,
                        decoration: InputDecoration(
                            labelText: (startDate == null) ? 'YYYY/MM/DD' : '',
                            labelStyle: const TextStyle(
                                fontSize: 10.0, color: AppColor.appColor),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.appColor, width: 0.5)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.appColor, width: 0.5)),
                            border: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColor.appColor,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            suffix: Icon(
                              Icons.calendar_month,
                              size: 14.sp,
                              color: AppColor.appColor,
                            )),
                        style:
                            TextStyle(fontSize: 14.0, color: AppColor.appColor),
                        value: startDate,
                        dateFormat: DateFormat.yMd(),
                        mode: DateTimeFieldPickerMode.date,
                        pickerPlatform: platform,
                        onChanged: (DateTime? value) {
                          ref.read(startDateProvider.notifier).state = value;
                        },
                      ),
                    ),
                    SizedBox(
                        width: mwidth / 4,
                        child: DateTimeField(
                            hideDefaultSuffixIcon: true,
                            decoration: InputDecoration(
                                labelText:
                                    (endDate == null) ? 'YYYY/MM/DD' : '',
                                labelStyle: TextStyle(
                                    fontSize: 10.0, color: AppColor.appColor),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.appColor, width: 0.5)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.appColor, width: 0.5)),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.appColor,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                suffix: const Icon(
                                  Icons.calendar_month,
                                  size: 14,
                                  color: AppColor.appColor,
                                )),
                            style: const TextStyle(
                                fontSize: 14.0, color: AppColor.appColor),
                            value: endDate,
                            dateFormat: DateFormat.yMd(),
                            mode: DateTimeFieldPickerMode.date,
                            pickerPlatform: platform,
                            onChanged: (DateTime? value) {
                              if (startDate != null && value != null) {
                                var diff =
                                    DateTime(value.year, value.month, value.day)
                                        .difference(DateTime(startDate.year,
                                            startDate.month, startDate.day))
                                        .inDays;
                                if (diff > 10) {
                                  print('more tha 10 days diff.');

                                  snackBarMessage(
                                      msg:
                                          "Please select 10 days range from start date.");
                                } else {
                                  ref.read(endDateProvider.notifier).state =
                                      value;
                                }
                              } else {
                                snackBarMessage(
                                    msg: "Please select start date first.");
                              }
                            })),
                    buttonContainer(
                        loder: ref.watch(loadingProvider),
                        txt: "Submit",
                        hight: 40.h,
                        width: mwidth / 4,
                        fontSize: 14.sp,
                        onTap: () async {
                          if (startDate == null) {
                            snackBarMessage(msg: "Please select start date.");
                          } else if (endDate == null) {
                            snackBarMessage(msg: "Please select end date.");
                          } else {
                            await ref.read(getRecordProvider);
                          }
                        })
                  ])),
          SizedBox(height: 20.h),
          Expanded(
              child: MilkSellRecordsTable(
                  milkData: milkData.cast<Map<String, dynamic>>()))
        ]));
  }
}
