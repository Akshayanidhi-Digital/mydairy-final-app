// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mydairy/dairy_users_dashboard/setting/controller.dart';
import 'erase_history_src.dart';
import 'package:mydairy/export.dart';

import 'setting_controller.dart';
import 'setting_src.dart';

class SettingScreen extends ConsumerStatefulWidget {
  final List<Widget>? widgetname;
  final String? txt1, txt2, title;
  const SettingScreen(
      {super.key, this.widgetname, this.txt1, this.txt2, this.title});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.whiteClr,
        backgroundColor: AppColor.appColor,
        automaticallyImplyLeading: true,
        title: Text(
          widget.title ?? 'Setting'.tr(),
          style: const TextStyle(
            color: AppColor.whiteClr,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: TabBar(
          // unselectedLabelStyle: TextField.materialMisspelledTextStyle,
          indicatorPadding: EdgeInsets.only(bottom: 10.h),
          dividerColor: AppColor.whiteClr,
          unselectedLabelColor: AppColor.whiteClr,
          indicatorColor: AppColor.whiteClr,
          labelStyle: const TextStyle(color: AppColor.whiteClr),
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: widget.txt1 ?? "PRINT AND SENT MESSAGE"),
            Tab(text: widget.txt2 ?? "ERASE MILK HISTORY"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.widgetname ??
            <Widget>[
              const PrintSendMessagePage(),
              const EraseMilkHistory(),
            ],
      ),
    );
  }
}

class PrintSendMessagePage extends ConsumerStatefulWidget {
  const PrintSendMessagePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrintSendMessagePageState();
}

class _PrintSendMessagePageState extends ConsumerState<PrintSendMessagePage> {
  TextEditingController txtController = TextEditingController();
  List<bool> switchValue = List.generate(settingField.length, (index) => false);
  // List<bool> switchValue2 =
  //     List.generate(settingField2.length, (index) => false);
  @override
  void initState() {
    // TODO: implement initState
    ref.read(settingsdataProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingBuild = ref.watch(settingGetApiProvider);
    final data = ref.watch(settingsdataProvider);
    // final user = ref.watch(dairyListProvider);
    return LoadingdataScreen(
      varBuild: settingBuild,
      data: (snap) {
        print(" setting data ${data[0].printFontSize}");
        // SettingModel data = SettingModel.fromJson(snap);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: RSizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RSizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Text("Bluetooth Printer",
                        style: TextStyle(fontSize: 18.sp)),
                  ),
                  const Divider(),
                  SettingSrcPage(data: data[0]),
                  SwitchScrStting(
                    positive: data[0].printRecipt == 0 ? false : true,
                    icon: false,
                    text: "Print Reciept",
                    onTap: (_) {
                      ref
                          .read(settingsdataProvider.notifier)
                          .printRecieptUpdate();
                    },
                  ),
                  SwitchScrStting(
                      positive: data[0].printReciptAll == 0 ? false : true,
                      icon: false,
                      text: "Print in all Language",
                      onTap: (_) {
                        ref
                            .read(settingsdataProvider.notifier)
                            .printAllLanguage();
                      }),
                  SwitchScrStting(
                      positive: data[0].whatsappMessage == 0 ? false : true,
                      icon: false,
                      text: "WhatsApp Message",
                      onTap: (_) {
                        ref
                            .read(settingsdataProvider.notifier)
                            .whatsappMessageUpdate();
                      }),
                  SwitchScrStting(
                      positive: data[0].autoFats == 0 ? false : true,
                      icon: false,
                      text: "Automatic Fat",
                      onTap: (_) {
                        ref
                            .read(settingsdataProvider.notifier)
                            .automaticFatUpdate();
                      }),
                  RSizedBox(height: 30.h),
                  buttonContainer(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      width: double.infinity,
                      loder: ref.watch(loadingProvider),
                      onTap: () {
                        ref.read(settingApiProvider).settingUpdate(SettingModel(
                                printFontSize: data[0].printFontSize,
                                printSize: data[0].printSize,
                                wight: data[0].wight,
                                printRecipt: data[0].printRecipt,
                                printReciptAll: data[0].printReciptAll,
                                whatsappMessage: data[0].whatsappMessage,
                                autoFats: data[0].autoFats)
                            .toJson());
                      },
                      txt: "Update Setting"),
                  RSizedBox(height: 60.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
