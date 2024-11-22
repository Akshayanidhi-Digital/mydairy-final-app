// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import 'package:mydairy/export.dart';

import '../../common/widgets/switch_button.dart';
import 'controller.dart';
import 'setting_controller.dart';

class SwitchScrStting extends StatefulWidget {
  final String text;
  bool positive = false;
  bool? icon = false;

  FutureOr<void> Function(TapProperties<bool>)? onTap;
  SwitchScrStting(
      {super.key,
      this.text = '',
      this.icon,
      this.onTap,
      this.positive = false});

  @override
  State<SwitchScrStting> createState() => _SwitchScrSttingState();
}

class _SwitchScrSttingState extends State<SwitchScrStting> {
  // bool switchValue = false;
  // bool positive = false;
  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      child: Column(
        children: [
          ListTile(
            dense: true,
            trailing: widget.icon!
                ? const Image(image: AssetImage(Img.setting1))
                : switchButton(
                    positive: widget.positive,

                    // (b) => setState(() => switchValue = b),
                    onTap: widget.onTap,
                    //  (_) => setState(() => switchValue = !switchValue)
                  ),
            title: Text(
              widget.text,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}

radioBtn(
    {int? length,
    required groupValue,
    int? txt2,
    required Function(dynamic value)? onChanged}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RSizedBox(
        child: Row(
            children: List.generate(
                length!,
                (index) => Expanded(
                      child: Row(
                        children: [
                          RSizedBox(
                            height: 20,
                            width: 30,
                            child: Radio(
                              activeColor: AppColor.appColor,
                              value: index,
                              groupValue: groupValue,
                              onChanged: onChanged,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              txt2 == 5
                                  ? addCategaryTxt[index].txt.tr()
                                  : txt2 == 3
                                      ? milkentry[index].txt
                                      : milkBuyTxt[index].txt.tr(),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          // txt2 == 5 ? const RSizedBox() : const RSizedBox()
                        ],
                      ),
                    ))),
      ),
      // txt2 == 5 ? const RSizedBox() : const Divider(),
    ],
  );
}

class SettingRadioSrc extends ConsumerWidget {
  final List<Widget> length;
  final String txt;
  const SettingRadioSrc({super.key, required this.length, required this.txt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Text(txt, style: TextStyle(fontSize: 18.w))),
        Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: length),
        const Divider(),
      ],
    );
  }
}

class SettingSrcPage extends ConsumerStatefulWidget {
  final SettingModel? data;
  const SettingSrcPage({super.key, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingSrcPageState();
}

class _SettingSrcPageState extends ConsumerState<SettingSrcPage> {
  @override
  Widget build(BuildContext context) {
    // final fontSizedBuild = ref.watch(fontSizeProvider);
    // final selectPrinterBuild = ref.watch(selectPrinterProvider);
    // final weightBuild = ref.watch(weightProvider);

    return Column(
      children: [
        SettingRadioSrc(
            txt: "Print receipt message font size",
            length: List.generate(
                fontSizeText.length,
                (index) => Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: AppColor.appColor,
                            value: fontSizeText[index].txt[0],
                            // value: widget.data!.printFontSize,
                            // groupValue: fontSizedBuild,
                            groupValue: widget.data!.printFontSize,
                            onChanged: (value) {
                              print('....$value..fontsize chnage kiya');

                              ref
                                  .read(settingsdataProvider.notifier)
                                  .fontSizeUpdate(value);
                            },
                          ),
                          Text(fontSizeText[index].txt),
                        ],
                      ),
                    ))),
        SettingRadioSrc(
            txt: "Select Printer",
            length: List.generate(
                selectPrintText.length,
                (index) => Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: AppColor.appColor,
                            value: selectPrintText[index].txt[0],
                            // groupValue: selectPrinterBuild,
                            groupValue: widget.data!.printSize,
                            onChanged: (value) {
                              ref
                                  .read(settingsdataProvider.notifier)
                                  .printerSelectUpdate(value);
                              // ref.read(selectPrinterProvider.notifier).state =
                              //     value!;
                            },
                          ),
                          Text(selectPrintText[index].txt),
                        ],
                      ),
                    ))),
        SettingRadioSrc(
            txt: "Weight",
            length: List.generate(
                weightTxt.length,
                (index) => Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: AppColor.appColor,
                            value: weightTxt[index].txt[0],
                            // groupValue: weightBuild,
                            groupValue: widget.data!.wight,
                            onChanged: (value) {
                              ref
                                  .read(settingsdataProvider.notifier)
                                  .weightUpdate(value);
                            },
                          ),
                          Text(weightTxt[index].txt),
                        ],
                      ),
                    ))),
      ],
    );
  }
}
