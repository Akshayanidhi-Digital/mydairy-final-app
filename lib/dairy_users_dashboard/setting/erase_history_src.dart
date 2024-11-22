import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import '../milk_buy_sell/milk_buy_controller.dart';

class EraseMilkHistory extends ConsumerWidget {
  const EraseMilkHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datePic = ref.watch(selectDateProvider);
    final datePic2 = ref.watch(selectDateProvider);
    final now = ref.watch(currentDateProvider);
    return Column(
      children: [
        RSizedBox(height: 15.h),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RSizedBox(width: 5.0.w),
            Expanded(
              child: TxtField(
                  readOnly: true,
                  onTap: () =>
                      ref.read(selectDateProvider.notifier).selectDate(context),
                  hintText:
                      "${datePic == "" ? " ${now.day}-${now.month}-${now.year}" : datePic}",
                  suffixIcon:
                      const Image(image: AssetImage(Img.calenderImage))),
            ),
            RSizedBox(width: 5.0.w),
            Expanded(
              child: TxtField(
                  readOnly: true,
                  onTap: () =>
                      ref.read(selectDateProvider.notifier).selectDate(context),
                  hintText:
                      "${datePic2 == "" ? " ${now.day}-${now.month}-${now.year}" : datePic2}",
                  suffixIcon:
                      const Image(image: AssetImage(Img.calenderImage))),
            ),
            buttonContainer(
                margin: EdgeInsets.only(bottom: 8.0.w, right: 5.w, left: 3),
                txt: "Submit",
                width: 90.0,
                borderRadius: BorderRadius.circular(0))
          ],
        ),
        RSizedBox(height: 10.h),
        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    columnSpacing: 5.w,
                    headingRowColor: WidgetStatePropertyAll(AppColor.appColor),
                    horizontalMargin: 00,
                    // border: TableBorder.all(),
                    columns: List.generate(
                        eraseDatalist.length,
                        (index) => DataColumn(
                                label: Expanded(
                              child: Text(eraseDatalist[index].txt,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColor.whiteClr,
                                      fontSize: 16.sp)),
                            ))),
                    rows: List.generate(
                        5,
                        (outerindex) => DataRow(cells: [
                              DataCell(
                                Center(
                                    child: Text("20-Apr-24",
                                        style: TextStyle(fontSize: 16.0.w))),
                              ),
                              DataCell(
                                Center(
                                  child: Text("data",
                                      style: TextStyle(fontSize: 16.0.sp)),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text("data",
                                      style: TextStyle(fontSize: 16.0.sp)),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text("data",
                                      style: TextStyle(fontSize: 16.0.sp)),
                                ),
                              ),
                              DataCell(Center(
                                  child: Text("data",
                                      style: TextStyle(fontSize: 16.0.sp))))
                            ]))))),
        RSizedBox(height: 20.h),
        buttonContainer(
            onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialogBox(
                      onPressed1: () => navigationPop(),
                      onPressed2: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialogBox(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.task_alt,
                                size: 30.w,
                                color: AppColor.appColor,
                              ),
                            ),
                            actions: const [Text("")],
                            content: "Entry Deleted Successfully",
                          ),
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          navigationPop();
                          navigationPop();
                        });
                      },
                      title: "Are You Sure Want To Delete ?",
                    )),
            txt: "Erase Milk History",
            width: 350.0.w)
      ],
    );
  }
}
// txtRowSetting(txt: "Date"),
//       txtRowSetting(txt: "Session"),
//       txtRowSetting(txt: "Total Weight"),
//       txtRowSetting(txt: "Avg.Fat"),
//       txtRowSetting(txt: "Total Amount"),

txtRowSetting({required String txt, Color? color}) {
  return Text(
    txt,
    style: TextStyle(color: color ?? AppColor.whiteClr, fontSize: 16.w),
  );
}
