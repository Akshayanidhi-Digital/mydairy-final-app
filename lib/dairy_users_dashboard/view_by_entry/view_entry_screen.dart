import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';
import '../milk_buy_sell/milk_buy_controller.dart';
import '../milk_buy_sell/sift_time_m_e/controller.dart';
import '../model/view_by_entry_model.dart';
import 'controller.dart';
import 'package:mydairy/export.dart';

final trueAndFalse = StateProvider.autoDispose<int>((ref) => 0);
final recordsTypeProvider = StateProvider.autoDispose<String>((ref) => "buy");

class ViewByEntryScreen extends ConsumerWidget {
  const ViewByEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datePic = ref.watch(selectDateProvider);
    final value = ref.watch(trueAndFalse);
    return Scaffold(
      appBar: BaseAppBar(
        title: "View Entry By Date",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                height: 40,
                width: double.infinity,
                color: AppColor.appColor,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            ref.read(recordsTypeProvider.notifier).state =
                                "buy";
                            ref.read(trueAndFalse.notifier).state = 0;
                            ref.read(dataProvider.notifier).state = {
                              "record_type": "buy",
                              "record_date": datePic.toString().isEmpty
                                  ? DateTime.now()
                                      .toString()
                                      .split(" ")
                                      .first
                                      .toString()
                                  : datePic
                                      .toString()
                                      .split("-")
                                      .reversed
                                      .join("-")
                            };
                            ref.read(viewByEntryApiProvider);
                            ref.refresh(viewByEntryApiProvider);
                          },
                          child: Column(children: [
                            Text("FARMER",
                                style: TextStyle(color: AppColor.whiteClr)),
                            Container(
                                height: 3,
                                color: value == 0
                                    ? AppColor.whiteClr
                                    : AppColor.appColor,
                                width: 100)
                          ])),
                      GestureDetector(
                          onTap: () {
                            ref.read(recordsTypeProvider.notifier).state =
                                "sell";
                            ref.read(trueAndFalse.notifier).state = 1;
                            ref.read(dataProvider.notifier).state = {
                              "record_type": "sell",
                              "record_date": datePic.toString().isEmpty
                                  ? DateTime.now()
                                      .toString()
                                      .split(" ")
                                      .first
                                      .toString()
                                  : datePic
                                      .toString()
                                      .split("-")
                                      .reversed
                                      .join("-")
                            };
                            ref.read(viewByEntryApiProvider);
                            ref.refresh(viewByEntryApiProvider);
                          },
                          child: Column(children: [
                            Text("BUYER",
                                style: TextStyle(color: AppColor.whiteClr)),
                            Container(
                                height: 3,
                                color: value == 1
                                    ? AppColor.whiteClr
                                    : AppColor.appColor,
                                width: 100)
                          ]))
                    ])),
            const FarmerViewByEnterySrc()
          ],
        ),
      ),
    );
  }
}

class FarmerViewByEnterySrc extends ConsumerStatefulWidget {
  const FarmerViewByEnterySrc({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerViewByEnterySrcState();
}

class _FarmerViewByEnterySrcState extends ConsumerState<FarmerViewByEnterySrc> {
  @override
  void initState() {
    Future(() {
      ref.read(dataProvider.notifier).state = {
        "record_type": "buy",
        "record_date": "${DateTime.now().toString().split(" ").first}"
      };
      // ref.read(viewByEntryApiProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recordType = ref.watch(recordsTypeProvider);
    final datePic = ref.watch(selectDateProvider);
    final now = ref.watch(currentDateProvider);
    final morningItemListBuild = ref.watch(mornigTimeListprovider);
    final typevalue = ref.watch(recordsTypeProvider);
    final shiftValue = ref.watch(morningValueProvider);
    final milktype = ref.watch(milkTypeValueprovider);

    return Container(
        margin: const EdgeInsets.all(15),
        child: Column(children: [
          RSizedBox(
              // width: 100.sp,
              child: TxtField(
                  readOnly: true,
                  onTap: () {
                    ref.read(selectDateProvider.notifier).selectDate(context);
                  },
                  hintText:
                      "${datePic == "" ? " ${now.day}-${now.month}-${now.year}" : datePic}",
                  suffixIcon:
                      const Image(image: AssetImage(Img.calenderImage)))),
          Row(children: [
            Flexible(
                flex: 2,
                child: CtmDropDown(
                    onChanged: (value) {
                      ref.read(morningValueProvider.notifier).state = value!;
                    },
                    hintTxt: "Both",
                    inisialvalue: shiftValue.isEmpty ? null : shiftValue,
                    lst: morningItemListBuild == null
                        ? []
                        : morningItemListBuild
                            .map((item) => DropdownMenuItem<String>(
                                value: item.value.toString(),
                                child: Text(item.title,
                                    style: TextStyle(fontSize: 14.sp))))
                            .toList())),
            RSizedBox(width: 10.w),
            const Flexible(flex: 2, child: MilkTyPeSrc())
          ]),
          RSizedBox(height: 10.h),
          Row(children: [
            buttonContainer(
                loder: ref.watch(loadingProvider),
                onTap: () {
                  if (shiftValue.isNotEmpty && milktype.isNotEmpty) {
                    ref.read(dataProvider.notifier).state = {
                      "record_type": recordType,
                      "record_date": datePic.toString().isEmpty
                          ? DateTime.now()
                              .toString()
                              .split(" ")
                              .first
                              .toString()
                          : datePic.toString().split("-").reversed.join("-"),
                      "milk_type": milktype
                    };
                    ref.read(viewByEntryApiProvider);
                  } else if (shiftValue.isNotEmpty) {
                    ref.read(dataProvider.notifier).state = {
                      "record_type": recordType,
                      "record_shift": shiftValue,
                      "record_date": datePic.toString().isEmpty
                          ? DateTime.now()
                              .toString()
                              .split(" ")
                              .first
                              .toString()
                          : datePic.toString().split("-").reversed.join("-")
                    };
                    ref.read(viewByEntryApiProvider);
                  } else {
                    ref.read(dataProvider.notifier).state = {
                      "record_type": recordType,
                      "record_date": datePic.toString().isEmpty
                          ? DateTime.now()
                              .toString()
                              .split(" ")
                              .first
                              .toString()
                          : datePic.toString().split("-").reversed.join("-")
                    };
                    ref.read(viewByEntryApiProvider).whenData((value) {
                      ref.read(loadingProvider.notifier).state = false;
                    });
                  }
                },
                hight: 46.0.w,
                width: 221.0.w,
                txt: "Submit"),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: InkWell(
                    onTap: () {
                      ref.read(viewByDateProvider).pdfDownload({
                        "record_type": recordType,
                        "record_date": datePic.toString().isEmpty
                            ? DateTime.now()
                                .toString()
                                .split(" ")
                                .first
                                .toString()
                            : datePic.toString().split("-").reversed.join("-"),
                        "milk_type": milktype
                      });
                    },
                    child: const Image(
                        image: AssetImage(Img.printerImage),
                        color: AppColor.blackClr)))
          ]),
          RSizedBox(height: 10.h),
          ViewByListSrc(typevalue: typevalue)
        ]));
  }
}

class ViewByListSrc extends ConsumerWidget {
  final dynamic typevalue;
  const ViewByListSrc({super.key, this.typevalue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewRecords = ref.watch(viewByEntryApiProvider);
    return LoadingdataScreen(
        varBuild: viewRecords,
        data: (mydata) {
          List<RecordsModel> records = [];
          for (var i = 0; i < mydata.length; i++) {
            records.add(RecordsModel.fromJson(mydata[i]));
          }

          return records.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                          border: TableBorder.all(color: AppColor.grey),
                          columnSpacing: 10.0.w,
                          headingRowColor:
                              const WidgetStatePropertyAll(AppColor.appColor),
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
                          rows: List.generate(records.length, (outerindex) {
                            RecordsModel sellerData = records[outerindex];
                            return DataRow(cells: [
                              DataCell(
                                Center(
                                    child: Text("${outerindex + 1}",
                                        style: TextStyle(fontSize: 16.0.sp))),
                              ),
                              DataCell(Text(
                                  sellerData.customer == null
                                      ? ''
                                      : sellerData.customer!.name!.toString(),
                                  style: TextStyle(fontSize: 16.0.sp))),
                              DataCell(Center(
                                  child: Text(sellerData.quantity.toString(),
                                      style: TextStyle(fontSize: 16.0.sp)))),
                              DataCell(Center(
                                  child: Text(
                                      "${sellerData.fat}/${sellerData.snf}",
                                      style: TextStyle(fontSize: 16.0.sp)))),
                              DataCell(Center(
                                  child: Text(df(sellerData.price.toString()),
                                      style: TextStyle(fontSize: 16.0.sp)))),
                              DataCell(Center(
                                  child: Text(
                                      double.parse(
                                              sellerData.totalPrice.toString())
                                          .toStringAsFixed(2),
                                      style: TextStyle(fontSize: 16.0.sp)))),
                              DataCell(PopupMenuButton(
                                  padding: EdgeInsets.zero,
                                  elevation: 7,
                                  color: AppColor.bluelightClr,
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                            height: 30.h,
                                            onTap: () async {
                                              bool valuetype =
                                                  typevalue == "sell"
                                                      ? true
                                                      : false;

                                              ref
                                                  .read(siftControllerProvider
                                                      .notifier)
                                                  .pdfDownload(
                                                      valueType: valuetype,
                                                      id: sellerData.id);
                                            },
                                            child: RSizedBox(
                                              width: 100.w,
                                              child: Row(
                                                children: [
                                                  Image(
                                                      image: const AssetImage(
                                                          Img.printerImage),
                                                      width: 20.sp,
                                                      color: AppColor.blackClr),
                                                  RSizedBox(width: 10.w),
                                                  const Text("Print")
                                                ],
                                              ),
                                            )),
                                        PopupMenuItem(
                                            height: 30.h,
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialogBox(
                                                          onPressed1: () =>
                                                              navigationPop(),
                                                          onPressed2: () {
                                                            ref
                                                                .read(siftControllerProvider
                                                                    .notifier)
                                                                .milkEntryDelete(
                                                                    id: sellerData
                                                                        .id
                                                                        .toString(),
                                                                    value:
                                                                        typevalue);
                                                          },
                                                          title:
                                                              "Are You Sure Want To Delete ?"));
                                            },
                                            child: RSizedBox(
                                              width: 100.w,
                                              child: Row(
                                                children: [
                                                  Icon(MdiIcons.deleteForever),
                                                  RSizedBox(width: 10.w),
                                                  Text("Delete".tr())
                                                ],
                                              ),
                                            ))
                                      ],
                                  child: const Center(
                                      child: Icon(Icons.more_vert))))
                            ]);
                          }))))
              : noDataFound();
        });
  }
}

bool listTypes = false;

class MilkTyPeSrc extends ConsumerStatefulWidget {
  final bool milktype;
  const MilkTyPeSrc({super.key, this.milktype = false});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MilkTyPeSrcState();
}

class _MilkTyPeSrcState extends ConsumerState<MilkTyPeSrc> {
  @override
  void initState() {
    setState(() {
      widget.milktype == true ? listTypes = true : listTypes = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(milkTypeListDataprovider);
    final title = ref.watch(milkTypeValueprovider);

    return CtmDropDown(
      inisialvalue: title.isEmpty ? null : title,
      hintTxt: list[0]['title'],
      lst: list.isEmpty
          ? []
          : list.map((item) {
              return DropdownMenuItem<String>(
                value: item['value'],
                child: Text(
                  item['title']!,
                  style: TextStyle(fontSize: 14.sp),
                ),
              );
            }).toList(),
      onChanged: (value) {
        ref.read(milkTypeValueprovider.notifier).state = value!;
      },
    );
  }
}
