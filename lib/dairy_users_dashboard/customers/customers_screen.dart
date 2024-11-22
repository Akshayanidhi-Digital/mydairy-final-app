import 'package:flutter/material.dart';
import 'package:mydairy/dairy_users_dashboard/model/Costumer_list_model.dart';
// import 'package:mydairy/customers/test.dart';
import '../profile/controller.dart';
import 'add_customer/add_customerAnd_Profile_screen.dart';
import 'add_customer/controller.dart';
import 'add_customer/edit_rate_screen.dart';
import 'package:mydairy/export.dart';

final searchProvider = StateProvider.autoDispose<String>((ref) => '');
// final listProvider = StateProvider.autoDispose<bool>((ref) => false);
final searchListProvider =
    StateProvider.autoDispose<List<CostumerModel>>((ref) => []);
final selectedItemProvider = StateProvider.autoDispose<String>((ref) => 'FAR');

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    Future(() => ref.read(typelstProvider.notifier).state = "FAR");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchList = ref.watch(searchListProvider);
    final user = ref.watch(dairyListProvider);
    final type = ref.watch(typelstProvider);
    final customerListBuild = ref.watch(customerListProvider);
    return Scaffold(
        appBar: BaseAppBar(
          title: Txt.userManagment,
          actionList: [
            // GestureDetector(
            //     onTap: () {
            //       showDialog(
            //           context: context,
            //           builder: (context) => diologBoxAlert(context));
            //     },
            //     child: const Image(image: AssetImage(Img.printerImage))),
            // RSizedBox(width: 20.w),
            CustomAppBarBtn(
                onTap: () => navigationTo(AddCustomerScreen(
                      customerValue: "FAR",
                      profileEdit: false,
                    )))
          ],
        ),
        body: LoadingdataScreen(
            varBuild: customerListBuild,
            data: (data) {
              if (data == null) {
                return errorMsg();
              } else {
                List<CostumerModel> customer = [];
                for (var i = 0; i < data.length; i++) {
                  customer.add(CostumerModel.fromJson(data[i]));
                }

                return SingleChildScrollView(
                  child: Column(children: [
                    RSizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: CtmDropDown(
                        inisialvalue: type == '' ? null : type,
                        onChanged: (value) {
                          // ref.read(selectedItemProvider.notifier).state =
                          //     value!;
                          ref.read(typelstProvider.notifier).state = value!;
                          // ref.read(customerListProvider);
                        },
                        hintTxt: "Select type",
                        lst: user.costumers == null
                            ? []
                            : user.costumers!
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.userType,
                                      child: Text(
                                        item.name!,
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ))
                                .toList(),
                      ),
                    ),
                    RSizedBox(height: 10.h),
                    RSizedBox(
                        height: 60,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: TxtField(
                                borderRadius: BorderRadius.circular(2),
                                controller: searchController,
                                onChanged: (query) {
                                  setState(() {
                                    if (query!.isNotEmpty) {
                                      ref
                                          .read(searchListProvider.notifier)
                                          .state = customer.where((item) {
                                        return (item.name!
                                                .toLowerCase()
                                                .contains(
                                                    query.toLowerCase())) ||
                                            (item.mobile!
                                                .toLowerCase()
                                                .contains(query.toLowerCase()));
                                      }).toList();
                                      // }
                                    } else {
                                      ref.refresh(customerListProvider);
                                      ref.refresh(searchListProvider);
                                    }
                                    // filterItems(value!);
                                    ref.read(searchProvider.notifier).state =
                                        query;
                                  });
                                },
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 25.0.sp,
                                ),
                                border: true,
                                hintText: "Search_Here".tr()))),
                    customer.isEmpty
                        ? Column(
                            children: [RSizedBox(height: 100.h), emptyList()],
                          )
                        : RefreshIndicator.adaptive(
                            color: AppColor.appColor,
                            onRefresh: () async =>
                                await ref.refresh(customerListProvider),
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                DataTable(
                                    border: searchList.isEmpty
                                        ? null
                                        : const TableBorder(
                                            bottom: BorderSide(
                                                width: 1, color: AppColor.grey),
                                            verticalInside: BorderSide(
                                                width: 1,
                                                color: AppColor.grey)),
                                    columnSpacing: 27.0.w,
                                    headingRowColor:
                                        const WidgetStatePropertyAll(
                                            AppColor.appColor),
                                    // border: TableBorder.all(),
                                    columns: List.generate(
                                        customerListTitle.length,
                                        (index) => DataColumn(
                                                label: Expanded(
                                              child: Text(
                                                  customerListTitle[index]
                                                      .txt
                                                      .tr(),
                                                  style: TextStyle(
                                                      color: AppColor.whiteClr,
                                                      fontSize: 16.w)),
                                            ))),
                                    rows: searchController.text.isNotEmpty &&
                                            searchList.isEmpty
                                        ? const [
                                            DataRow(cells: [
                                              DataCell(Text("")),
                                              DataCell(Text("")),
                                              DataCell(Text("data not found")),
                                              DataCell(Text("")),
                                            ])
                                          ]
                                        : List.generate(
                                            searchList.isNotEmpty
                                                ? searchList.length
                                                : customer.length,
                                            (outerindex) {
                                            CostumerModel ctrData =
                                                customer[outerindex];
                                            CostumerModel srData =
                                                searchList.isEmpty
                                                    ? ctrData
                                                    : searchList[outerindex];

                                            return DataRow(cells: [
                                              DataCell(
                                                Center(
                                                    child: Text(
                                                        searchList.isNotEmpty
                                                            ? "${outerindex + 1}"
                                                            : "${outerindex + 1}",
                                                        style: TextStyle(
                                                            fontSize: 16.0.w))),
                                              ),
                                              DataCell(
                                                Text(
                                                    searchList.isNotEmpty
                                                        ? srData.name!
                                                        : ctrData.name

                                                            // data[outerindex]
                                                            //         ['name']
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16.0.w)),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: Text(
                                                      searchList.isNotEmpty
                                                          ? srData.mobile!
                                                          : ctrData.mobile
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16.0.w)),
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
                                                              navigationTo(AddCustomerScreen(
                                                                  customerValue:
                                                                      type,
                                                                  profileEdit:
                                                                      true,
                                                                  profileData: searchList
                                                                          .isNotEmpty
                                                                      ? srData
                                                                      : ctrData));
                                                            },
                                                            child: Text(
                                                                "Edit_Profile"
                                                                    .tr())),
                                                        PopupMenuItem(
                                                            height: 30.h,
                                                            onTap: () {
                                                              var selectOption =
                                                                  0;

                                                              if (ctrData
                                                                      .isFixedRate ==
                                                                  1) {
                                                                selectOption = (searchList
                                                                            .isNotEmpty
                                                                        ? srData.fixedRateType ==
                                                                            1
                                                                        : ctrData.fixedRateType ==
                                                                            1)
                                                                    ? 2
                                                                    : 1;
                                                              } else {
                                                                selectOption =
                                                                    0;
                                                              }
                                                              navigationTo(
                                                                  EditRateScreen(
                                                                      // buyer:
                                                                      //     listType,
                                                                      data: searchList
                                                                              .isNotEmpty
                                                                          ? srData
                                                                          : ctrData,
                                                                      farmerid:
                                                                          // listType ==
                                                                          //         false
                                                                          //     ?
                                                                          //  searchList.isNotEmpty
                                                                          //     ? srData.costumer_id. toString()
                                                                          //     :
                                                                          ctrData
                                                                              .costumer_id
                                                                              .toString())
                                                                  // : ctrData.buyerId.toString())
                                                                  );
                                                              ref
                                                                  .read(dairyRateProvider
                                                                      .notifier)
                                                                  .update((state) =>
                                                                      selectOption);
                                                            },
                                                            child: Text(
                                                                "Edit_Rate"
                                                                    .tr())),
                                                        PopupMenuItem(
                                                            height: 30.h,
                                                            onTap: () =>
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialogBox(
                                                                              onPressed1: () => navigationPop(),
                                                                              onPressed2: () {
                                                                                ref.read(farmerApiProvider).deleteCustomer(data: {
                                                                                  "costumer_type": type,
                                                                                  "costumer_id": searchList.isNotEmpty ? srData.costumer_id.toString() : ctrData.costumer_id.toString()
                                                                                });
                                                                                ref.refresh(searchListProvider);
                                                                                ref.refresh(customerListProvider);

                                                                                searchController.text = '';

                                                                                // listType == false ? ref.refresh(farmerListProvider) : ref.refresh(buyerListProvider);
                                                                              },
                                                                              title: "Are You Sure Want To Delete ?",
                                                                            )),
                                                            child: Text(
                                                                "Delete".tr()))
                                                      ],
                                                  child: const Center(
                                                      child: Icon(
                                                          Icons.more_vert))))
                                            ]);
                                          })),
                              ],
                            ),
                          ),
                    RSizedBox(height: 50.h)
                  ]),
                );
              }
            }));
  }
}
