import 'package:flutter/material.dart';
// import 'add_cow_chart_screen.dart';
import 'app_src.dart';
import 'snf_chart_controller.dart';
import 'package:mydairy/export.dart';

class SnfChart extends ConsumerWidget {
  final String? milkType;
  const SnfChart({super.key, required this.milkType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getbuyChartBuild = ref.watch(getBuyChartProvider.call(milkType));
    return Scaffold(
        appBar: BaseAppBar(
          title: "SNF FAT Chart of $milkType",
          actionList: [
            GestureDetector(
                // onTap: () => navigationTo(AddCowChartScreen()),
                child: const Image(image: AssetImage(Img.more_item))),
            RSizedBox(width: 10.w),
            ShowBoxSrc(milkType: milkType)
          ],
        ),
        body: LoadingdataScreen(
          varBuild: getbuyChartBuild,
          data: (data) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        RSizedBox(height: 20.h),
                        Row(children: [
                          DataTable(
                              showBottomBorder: true,
                              border: TableBorder.all(),
                              headingTextStyle: TextStyle(
                                  fontSize: 18.w, fontWeight: FontWeight.w500),
                              headingRowColor: const WidgetStatePropertyAll(
                                  AppColor.appColor),
                              dataRowColor: const WidgetStatePropertyAll(
                                  AppColor.greenClr),
                              showCheckboxColumn: false,
                              columns: const [
                                DataColumn(
                                    label: Text("FAT/SNF",
                                        style: TextStyle(
                                            // fontSize: 18.w,
                                            color: AppColor.whiteClr)),
                                    numeric: false)
                              ],
                              rows: List.generate(
                                  data['fat'].length,
                                  (index) => DataRow(cells: [
                                        DataCell(Text(
                                            data['fat'][index].toString(),
                                            style: TextStyle(
                                                color: AppColor.blackClr,
                                                fontSize: 16.w)))
                                      ]))),
                          DataTable(
                              headingRowColor: const WidgetStatePropertyAll(
                                  AppColor.appColor),
                              border: TableBorder.all(),
                              columns: List.generate(
                                  data['snf'].length,
                                  (index) => DataColumn(
                                      label: Text(data['snf'][index].toString(),
                                          style: TextStyle(
                                              color: AppColor.whiteClr,
                                              fontSize: 16.w)))),
                              rows: List.generate(
                                  data['fat'].length,
                                  (outerindex) => DataRow(
                                      cells: List.generate(
                                          data['snf'].length,
                                          (index) => DataCell(Text(
                                                data['rate'][outerindex][index]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: AppColor.blackClr,
                                                    fontSize: 16.w),
                                              )))))),
                        ]),
                      ],
                    )));
          },
        ));
  }
}
