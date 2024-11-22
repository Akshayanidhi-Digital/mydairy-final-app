import 'package:flutter/material.dart';
import '../customers/add_customer/add_customerAnd_Profile_screen.dart';
import 'sift_time_m_e/controller.dart';
import 'sift_time_m_e/sift_time_screen.dart';
import '../setting/controller.dart';
import '../setting/setting_src.dart';
import 'milk_buy_controller.dart';
// import 'milk_buy_scr.dart';
import 'package:mydairy/export.dart';

class MilkBuyScreen extends ConsumerWidget {
  final int buyerValue;
  const MilkBuyScreen({super.key, this.buyerValue = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingBuild = ref.watch(settingGetApiProvider);
    final data = ref.watch(settingsdataProvider);
    final datePic = ref.watch(selectDateProvider);
    final now = ref.watch(currentDateProvider);
    // final rateTypeBuild = ref.watch(rateTypeProvider);
    // final generalInfoBuild = ref.watch(generalInfoProvider);
    // final bonusDeductionBuild = ref.watch(bonusDeductionProvider);
    // final milkBuyAdvanceBuild = ref.watch(milkBuyAdvanceProvider);
    final siftBuild = ref.watch(siftProvider);

    return Scaffold(
        appBar: BaseAppBar(
          title: buyerValue == 0 ? Txt.milk_buy : Txt.milk_sell.tr(),
          actionList: [
            CustomAppBarBtn(
                onTap: () {
                  navigationTo(AddCustomerScreen(
                      customerValue: buyerValue == 0 ? "BYR" : "FAR"));
                },
                title: "Add")
          ],
        ),
        body: LoadingdataScreen(
          varBuild: settingBuild,
          data: (mydata) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: RSizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RSizedBox(height: 15.h),
                        SwitchScrStting(
                            positive: data[0].printRecipt == 0 ? false : true,
                            icon: false,
                            text: "Print_Receipt".tr(),
                            onTap: (_) {
                              ref
                                  .read(settingsdataProvider.notifier)
                                  .printRecieptUpdate();
                              ref.read(settingApiProvider).settingUpdate({
                                "print_recipt": data[0].printRecipt == 0 ? 1 : 0
                              });
                            }),
                        // SwitchScrStting(
                        //     positive: data[0].autoFats == 0 ? false : true,
                        //     icon: false,
                        //     text: "Automatic",
                        //     onTap: (_) {
                        //       ref
                        //           .read(settingsdataProvider.notifier)
                        //           .printAllLanguage();
                        //     }),
                        // ListView.builder(
                        //     padding: EdgeInsets.zero,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemCount: switchData.length,
                        //     itemBuilder: (context, index) {
                        //       return SwitchScr(
                        //           text: switchData[index].txt.tr());
                        //     }),
                        // Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 18.w),
                        //     child: RSizedBox(
                        //         height: 45.h,
                        //         child: Row(children: [
                        //           RSizedBox(width: 10.w),
                        //           Icon(MdiIcons.whatsapp,
                        //               color: const Color.fromARGB(255, 57, 174, 65),
                        //               size: 30),
                        //           RSizedBox(width: 10.w),
                        //           Text("SMS",
                        //               style: TextStyle(
                        //                   fontSize: 16.w,
                        //                   fontWeight: FontWeight.w500))
                        //         ]))),
                        // const Divider(),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: RSizedBox(
                                height: 45.h,
                                child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Select_Date".tr(),
                                          style: TextStyle(
                                              fontSize: 16.w,
                                              fontWeight: FontWeight.w500)),
                                      const Spacer(),
                                      Text(
                                          datePic == ""
                                              ? " ${now.day}-${now.month}-${now.year}"
                                              : "$datePic",
                                          style: TextStyle(
                                              fontSize: 16.w,
                                              fontWeight: FontWeight.w500)),
                                      RSizedBox(width: 10.w),
                                      InkWell(
                                          onTap: () {
                                            ref
                                                .read(
                                                    selectDateProvider.notifier)
                                                .selectDate(context);
                                          },
                                          child: const Image(
                                              image: AssetImage(
                                                  Img.calenderImage)))
                                    ]))),
                        const Divider(),
                        RSizedBox(height: 10.h),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buttonContainer(
                                  onTap: () {
                                    ref.read(siftProvider.notifier).state = 0;
                                    ref
                                        .read(valueChangeProvider.notifier)
                                        .state = buyerValue == 0 ? false : true;
                                    navigationTo(const SiftTiimeScreen());
                                    ref
                                        .read(timeProvider.notifier)
                                        .state = datePic ==
                                            ""
                                        ? "${now.year}-${now.month}-${now.day}"
                                        : datePic
                                            .toString()
                                            .split('-')
                                            .reversed
                                            .join('-');
                                    ref.read(shiftProvider.notifier).state =
                                        "M";

                                    // !ref.read(siftProvider.notifier).state;
                                  },
                                  txtColor: siftBuild == 0
                                      ? AppColor.whiteClr
                                      : AppColor.blackClr,
                                  txt: "Morning".tr(),
                                  color: siftBuild == 0
                                      ? AppColor.appColor
                                      : AppColor.bluelightClr),
                              buttonContainer(
                                  onTap: () {
                                    ref.read(siftProvider.notifier).state = 1;
                                    ref
                                        .read(valueChangeProvider.notifier)
                                        .state = buyerValue == 0 ? false : true;
                                    navigationTo(const SiftTiimeScreen());
                                    ref
                                        .read(timeProvider.notifier)
                                        .state = datePic ==
                                            ""
                                        ? "${now.year}-${now.month}-${now.day}"
                                        : datePic
                                            .toString()
                                            .split('-')
                                            .reversed
                                            .join('-');
                                    ref.read(shiftProvider.notifier).state =
                                        "E";
                                    // !ref.read(siftProvider.notifier).state;
                                  },
                                  txtColor: siftBuild == 1
                                      ? AppColor.whiteClr
                                      : AppColor.blackClr,
                                  txt: "Evening".tr(),
                                  color: siftBuild == 1
                                      ? AppColor.appColor
                                      : AppColor.bluelightClr)
                            ]),

                        buttonContainer(
                            margin: EdgeInsets.all(25),
                            width: double.infinity,
                            onTap: () {
                              ref.read(siftProvider.notifier).state = 2;
                              ref.read(valueChangeProvider.notifier).state =
                                  buyerValue == 0 ? false : true;
                              navigationTo(const SiftTiimeScreen());
                              ref.read(timeProvider.notifier).state =
                                  datePic == ""
                                      ? "${now.year}-${now.month}-${now.day}"
                                      : datePic
                                          .toString()
                                          .split('-')
                                          .reversed
                                          .join('-');
                              ref.read(shiftProvider.notifier).state = "D";
                              // !ref.read(siftProvider.notifier).state;
                            },
                            txtColor: siftBuild == 2
                                ? AppColor.whiteClr
                                : AppColor.blackClr,
                            txt: "Day".tr(),
                            color: siftBuild == 2
                                ? AppColor.appColor
                                : AppColor.bluelightClr),
                      ]),
                ));
          },
        ));
  }
}
