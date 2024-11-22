import 'package:flutter/material.dart';
import '../controller.dart';
import 'add_product_brand.dart';
import 'package:mydairy/export.dart';

import 'controller.dart';

class ProductBrandScreen extends ConsumerWidget {
  const ProductBrandScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListBuild = ref.watch(productBrandListApiProvider);
    final data = ref.watch(product_brand_state_Provider);
    return Scaffold(
      appBar: BaseAppBar(
        title: "Product Item",
        actionList: [
          GestureDetector(
              onTap: () => navigationTo(AddProductBrandScreen()),
              child: const CustomAppBarBtn(title: "Add"))
        ],
      ),
      body: LoadingdataScreen(
          varBuild: productListBuild,
          data: (mydata) => Container(
                child: data.isEmpty
                    ? emptyList()
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                                padding: EdgeInsets.only(top: 20.0.h),
                                child: DataTable(
                                    // dataRowMaxHeight: 70,
                                    // dataRowHeight: 100,
                                    // columnSpacing: 100.0,
                                    // columnSpacing: 27.0.w,
                                    headingRowColor: WidgetStatePropertyAll(
                                        AppColor.appColor),
                                    // border: TableBorder.all(),
                                    columns: List.generate(
                                        productBrandtxt.length,
                                        (index) => DataColumn(
                                                label: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  productBrandtxt[index].txt,
                                                  style: TextStyle(
                                                      color: AppColor.whiteClr,
                                                      fontSize: 16.w)),
                                            ))),
                                    rows: List.generate(
                                        data.length,
                                        (r) => DataRow(cells: [
                                              DataCell(
                                                Center(
                                                    child: Text("${r + 1}",
                                                        style: TextStyle(
                                                            fontSize: 16.0.w))),
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      data[r]['brand']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16.0.w)),
                                                ),
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      data[r]['group_name']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16.0.w)),
                                                ),
                                              ),
                                              DataCell(Center(
                                                  child: PopupMenuButton(
                                                      itemBuilder:
                                                          (context) => [
                                                                PopupMenuItem(
                                                                    onTap: () {
                                                                      print(
                                                                          " :::::::::::::: ${data[r]}");
                                                                      navigationTo(AddProductBrandScreen(
                                                                          data: data[
                                                                              r],
                                                                          edit:
                                                                              true));
                                                                    },
                                                                    child: Text(
                                                                        "Edit")),
                                                                PopupMenuItem(
                                                                    onTap: () {
                                                                      ref
                                                                          .read(
                                                                              productApiProvider)
                                                                          .productBrand_update({
                                                                        "id": data[r]
                                                                            [
                                                                            'id']
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      "${data[r]['trash'] == 0 ? "Disable" : "Enable"}",
                                                                      style: TextStyle(
                                                                          color: data[r]['trash'] == 0
                                                                              ? AppColor.redClr
                                                                              : AppColor.greenClr),
                                                                    )),
                                                              ],
                                                      child: Icon(
                                                          Icons.more_vert))))
                                            ])))))),
              )),
    );
  }
}
