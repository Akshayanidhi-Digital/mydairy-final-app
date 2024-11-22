// ignore_for_file: must_be_immutable, unused_field, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import '../../../dairy_users_dashboard/model/farmer_buyer_profile_model.dart';
import 'FarmerEntryDetails.dart';
import 'controller.dart';

class Farmerentryrecords extends ConsumerStatefulWidget {
  List<FarmerBuyerData>? farmer;
  String? title;
  String? dairy_id;
  Farmerentryrecords(
      {super.key, required this.farmer, this.title, this.dairy_id});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerentryrecordsState();
}

class _FarmerentryrecordsState extends ConsumerState<Farmerentryrecords> {
  @override
  void initState() {
    super.initState();
    ref
        .read(farmerRecordApiProvider)
        .getRcordsInfo(ref.read(selectedYearProvider.notifier).state);
  }

  @override
  Widget build(BuildContext context) {
    final selectedYear = ref.watch(selectedYearProvider);
    late List<dynamic> list_counts = ref.watch(listCountProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appColor,
          automaticallyImplyLeading: false,
          title: Row(children: [
            Image(image: AssetImage(Img.logo), width: 30.w, height: 30.h),
            RSizedBox(width: 10.w),
            Text('${widget.title}',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    color: AppColor.whiteClr))
          ]),
          actions: [
            IconButton(
                onPressed: () {
                  navigationPop();
                },
                icon: Icon(Icons.arrow_forward_ios, color: AppColor.whiteClr))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RSizedBox(height: 5.h),
              Center(
                  child: TextButton(
                      onPressed: () {
                        _showYearPicker();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColor.whiteClr),
                          fixedSize: WidgetStateProperty.all(
                              Size(MediaQuery.of(context).size.width / 2, 40)),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: AppColor.appColor),
                            ),
                          ),
                          foregroundColor:
                              WidgetStateProperty.all(AppColor.appColor)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('$selectedYear',
                                style: TextStyle(fontSize: 16.sp)),
                            Icon(Icons.calendar_today)
                          ]))),
              RSizedBox(height: 10.h),
              Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two cards per row
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1,
                        mainAxisExtent: 100,
                      ),
                      itemCount: 12, // 12 months
                      itemBuilder: (context, index) {
                        // Calculate the month name
                        final monthName = DateFormat('MMMM')
                            .format(DateTime(selectedYear, index + 1));
                        final count = list_counts.isNotEmpty
                            ? list_counts[index][monthName]
                            : '0.00';
                        return InkWell(
                            onTap: () {
                              print(
                                  'month ...........${monthName}............year...........${selectedYear}');
                              navigationTo(Farmerentrydetails(
                                  month: monthName, year: selectedYear));
                            },
                            child: Card(
                                color: Colors.blueAccent,
                                elevation: 2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(monthName,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.whiteClr)),
                                      RSizedBox(height: 10.h),
                                      Text('${count}',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColor.whiteClr))
                                    ])));
                      }))
            ])));
  }

  void _showYearPicker() async {
    var _selectedYear = ref.watch(selectedYearProvider);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(_selectedYear),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.year,
      onDatePickerModeChange: (value) {},
      selectableDayPredicate: (DateTime date) {
        return true; // Enable selecting all dates
      },
    );

    if (picked != null && picked.year != _selectedYear) {
      ref.read(selectedYearProvider.notifier).state = picked.year;
      ref.read(farmerRecordApiProvider).getRcordsInfo(picked.year);
    } else
      false;
  }
}
