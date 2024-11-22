import 'dart:developer';
import 'package:flutter/material.dart';
import 'add_customerAnd_Profile_screen.dart';
import 'package:mydairy/export.dart';

// import 'controller.dart';

final dairyRateProvider = StateProvider<int>((ref) => 0);

class AdvanceOptionScr extends ConsumerStatefulWidget {
  final TextEditingController fatRate;
  final TextEditingController fixPrice;
  const AdvanceOptionScr(
      {super.key, required this.fatRate, required this.fixPrice});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdvanceOptionScrState();
}

class _AdvanceOptionScrState extends ConsumerState<AdvanceOptionScr> {
  @override
  Widget build(BuildContext context) {
    final dairyRateBuild = ref.watch(dairyRateProvider);
    return Padding(
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
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dairyRateTxt.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => RadioListTile(
                        activeColor: AppColor.appColor,
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(dairyRateTxt[index].txt.tr()),
                        value: index,
                        groupValue: dairyRateBuild,
                        onChanged: (value) {
                          ref.read(dairyRateProvider.notifier).state = value!;
                          log(value.toString());
                        },
                      )),
            ),
            // RSizedBox(height: 10.h),
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
                          controller: widget.fatRate,
                          keyboardType: TextInputType.number,
                          hintText: "0.00",
                          labelText: "Rate",
                        ),
                      ),
                    ),
                    RSizedBox(
                      height: 10.h,
                    )
                  ]),
            if (dairyRateBuild == 2)
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TxtField(
                              controller: widget.fixPrice,
                              keyboardType: TextInputType.number,
                              hintText: "0.00",
                              labelText: "Price",
                            ),
                          ),
                        ],
                      ),
                    ),
                    RSizedBox(height: 10.h)
                  ]),
            Center(
                child: buttonContainer(
                    hight: 35.0.h,
                    width: 82.0.w,
                    onTap: () {
                      ref.read(advanceValueProvider.notifier).state = false;
                    },
                    txt: "Hide")),
            RSizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
