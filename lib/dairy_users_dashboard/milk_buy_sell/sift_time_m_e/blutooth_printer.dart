import 'package:flutter/material.dart';
import '../../../export.dart';
import '../../model/view_by_entry_model.dart';
import 'controller.dart';

class CustomerDataList extends ConsumerWidget {
  final type;
  final List<RecordsModel> data;
  const CustomerDataList({super.key, required this.data, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        // height: 315.sp,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            // physics: const NeverScrollableScrollPhysics(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                      child: data.isNotEmpty
                          ? DataTable(
                              border: TableBorder.all(color: AppColor.grey),
                              columnSpacing: 10.0.w,
                              headingRowColor:
                                  WidgetStatePropertyAll(AppColor.appColor),
                              columns: List.generate(
                                  milkEntrytxt.length,
                                  (index) => DataColumn(
                                          label: Expanded(
                                        child: Center(
                                          child: Text(milkEntrytxt[index].txt,
                                              style: TextStyle(
                                                  color: AppColor.whiteClr,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16.sp)),
                                        ),
                                      ))),
                              rows: List.generate(data.length, (outerindex) {
                                RecordsModel snap = data[outerindex];
                                return DataRow(cells: [
                                  DataCell(
                                    Center(
                                        child: Text("${outerindex + 1}",
                                            style:
                                                TextStyle(fontSize: 16.0.sp))),
                                  ),
                                  DataCell(Text(
                                      "${snap.customer == null ? "name" : snap.customer!.name}",
                                      style: TextStyle(fontSize: 16.0.sp))),
                                  DataCell(
                                    Center(
                                      child: Text(snap.quantity.toString(),
                                          style: TextStyle(fontSize: 16.0.sp)),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text("${snap.fat}/${snap.snf}",
                                          style: TextStyle(fontSize: 16.0.sp)),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(snap.price.toString(),
                                          style: TextStyle(fontSize: 16.0.sp)),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(snap.totalPrice.toString(),
                                          style: TextStyle(fontSize: 16.0.sp)),
                                    ),
                                  ),
                                  DataCell(PopupMenuButton(
                                      padding: EdgeInsets.zero,
                                      elevation: 7,
                                      color: AppColor.bluelightClr,
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                                height: 30.h,
                                                onTap: () {
                                                  ref
                                                      .read(
                                                          siftControllerProvider
                                                              .notifier)
                                                      .pdfDownload(
                                                          valueType: type,
                                                          id: snap.id
                                                              .toString());
                                                },
                                                child: RSizedBox(
                                                  width: 100.w,
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                          image: const AssetImage(
                                                              Img.printerImage),
                                                          width: 20.sp,
                                                          color: AppColor
                                                              .blackClr),
                                                      RSizedBox(width: 10.w),
                                                      Text("Print")
                                                    ],
                                                  ),
                                                )),
                                            // PopupMenuItem(
                                            //     height: 30.h,
                                            //     onTap: () {},
                                            //     child: RSizedBox(
                                            //       width: 100.w,
                                            //       child: Row(
                                            //         children: [
                                            //           const Icon(
                                            //               Icons.edit_outlined),
                                            //           RSizedBox(width: 10.w),
                                            //           const Text("Edit")
                                            //         ],
                                            //       ),
                                            //     )),
                                            PopupMenuItem(
                                                height: 30.h,
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialogBox(
                                                                onPressed1: () =>
                                                                    navigationPop(),
                                                                onPressed2: () {
                                                                  ref.read(siftControllerProvider.notifier).milkEntryDelete(
                                                                      id: snap
                                                                          .id
                                                                          .toString(),
                                                                      value: type ==
                                                                              true
                                                                          ? "sell"
                                                                          : "buy");
                                                                  ref.refresh(
                                                                      milkentryApiProvider);
                                                                },
                                                                title:
                                                                    "Are You Sure Want To Delete ?",
                                                              ));
                                                },
                                                child: RSizedBox(
                                                  width: 100.w,
                                                  child: Row(
                                                    children: [
                                                      Icon(MdiIcons
                                                          .deleteForever),
                                                      RSizedBox(width: 10.w),
                                                      Text("Delete".tr())
                                                    ],
                                                  ),
                                                ))
                                          ],
                                      child: const Center(
                                          child: Icon(Icons.more_vert))))
                                ]);
                              }))
                          : emptyList()),
                  RSizedBox(height: 50.sp)
                ],
              ),
            )),
      ),
    );
  }
}
