import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../milk_buy_sell/sift_time_m_e/controller.dart';
import '../../view_by_entry/view_entry_screen.dart';
import 'controller.dart';
import 'package:mydairy/export.dart';

import 'snf_chart_controller.dart';

final chartListDropprovider = StateProvider.autoDispose<List>((ref) => [
      {"title": "Sell", "value": "Sell"},
      {"title": "Purchase", "value": "Purchase"},
    ]);
final chartvalueProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

class UploadChartScreen extends ConsumerWidget {
  const UploadChartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listofchartBuild = ref.watch(chartListDropprovider);
    final chartValueBuild = ref.watch(chartvalueProvider);
    final exelfilepicBuild = ref.watch(exelfilePicProvider);
    final uploadChart = ref.watch(chartFileProvider);
    final milkType = ref.watch(milkTypeValueprovider);

    return Scaffold(
      appBar: BaseAppBar(title: "Upload Chart"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        child: Column(
          children: [
            RSizedBox(height: 20.0.h),
            Align(
                alignment: Alignment.bottomRight,
                child: buttonContainer(
                    onTap: () {
                      ref.read(chartApiProvider).sample_chart();
                    },
                    width: 250.0,
                    txt: "Download Sample Excel",
                    fontSize: 16.sp)),
            RSizedBox(height: 20.h),
            Container(
                decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: dropdownBtn(
                  bydefalutselect: "Select Chart Category",
                  value: chartValueBuild,
                  listitem: listofchartBuild,
                  onChanged: (value) {
                    ref.read(chartvalueProvider.notifier).state = value!;
                  },
                )),
            RSizedBox(height: 20.h),
            const MilkTyPeSrc(milktype: true),
            RSizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                ref.read(exelfilePicProvider.notifier).getPdfAndUpload();
              },
              child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Text(
                          exelfilepicBuild.toString(),
                          style: TextStyle(fontSize: 18.w),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: Image(
                              image: const AssetImage(Img.file_upload),
                              color: AppColor.blackClr,
                              width: 20.w))
                    ],
                  )),
            ),
            RSizedBox(height: 30.h),
            buttonContainer(
                loder: ref.watch(loadingProvider),
                onTap: () async {
                  if (chartValueBuild.isEmpty) {
                    snackBarMessage(
                        msg: "Please select chart category",
                        color: AppColor.redClr);
                  }

                  ref.read(chartApiProvider).uploadChart(UploadChartModel(
                      milkType: milkType,
                      rateType: chartValueBuild,
                      rateChartFile: uploadChart != null
                          ? await MultipartFile.fromFile(
                              uploadChart.path.toString(),
                              filename: uploadChart.path.split('/').last)
                          : null));
                },
                width: double.infinity,
                txt: "Submit")
          ],
        ),
      ),
    );
  }
}

class UploadChartModel {
  String? rateType;
  String? milkType;
  MultipartFile? rateChartFile;

  UploadChartModel({this.rateType, this.milkType, this.rateChartFile});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate_type'] = this.rateType;
    data['milk_type'] = this.milkType;
    data['rate_chart_file'] = this.rateChartFile;
    return data;
  }
}
