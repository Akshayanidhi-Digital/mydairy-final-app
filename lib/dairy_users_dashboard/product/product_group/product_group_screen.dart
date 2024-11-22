import 'package:flutter/material.dart';
import '../controller.dart';
import 'add_product_group.dart';
import 'package:mydairy/export.dart';

import 'controller.dart';

class ProductGroupScreen extends ConsumerWidget {
  const ProductGroupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListBuild = ref.watch(productGroupApiProvider);
    final data = ref.watch(product_group_state_Provider);
    print(" data ::: $data");
    return Scaffold(
        appBar: BaseAppBar(
          title: "Product Group",
          actionList: [
            GestureDetector(
                onTap: () => navigationTo(AddProductGroupScreen()),
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
                                      headingRowColor:
                                          const WidgetStatePropertyAll(
                                              AppColor.appColor),
                                      // border: TableBorder.all(),
                                      columns: List.generate(
                                          productgroputxt.length,
                                          (index) => DataColumn(
                                                  label: Expanded(
                                                child: Text(
                                                    productgroputxt[index].txt,
                                                    style: TextStyle(
                                                        color:
                                                            AppColor.whiteClr,
                                                        fontSize: 16.w)),
                                              ))),
                                      rows: List.generate(
                                          data.length,
                                          (r) => DataRow(cells: [
                                                DataCell(
                                                  Center(
                                                      child: Text("${r + 1}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  16.0.w))),
                                                ),
                                                DataCell(
                                                  RSizedBox(
                                                    width: 129.w,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Text(
                                                          data[r]['group']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  16.0.w)),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(Center(
                                                    child: PopupMenuButton(
                                                        itemBuilder:
                                                            (context) => [
                                                                  PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        navigationTo(AddProductGroupScreen(
                                                                            data:
                                                                                data[r],
                                                                            edit: true));
                                                                      },
                                                                      child: const Text(
                                                                          "Edit")),
                                                                  PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        ref
                                                                            .read(
                                                                                productApiProvider)
                                                                            .product_group_update({
                                                                          "id": data[r]
                                                                              [
                                                                              'id']
                                                                        });
                                                                      },
                                                                      child:
                                                                          Text(
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
                )));
  }
}
