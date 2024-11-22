import 'package:flutter/material.dart';

import '../../../export.dart';
import '../componant/MilkSellRecordsTable.dart';
import 'controller.dart';

class Farmerentrydetails extends ConsumerStatefulWidget {
  final int year;
  final String month;

  Farmerentrydetails({super.key, required this.month, required this.year});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FarmerentrydetailsState();
}

class _FarmerentrydetailsState extends ConsumerState<Farmerentrydetails> {
  // late Future<List<Map<String, dynamic>>> _listRecordsFuture;

  @override
  void initState() {
    super.initState();

    ref.read(getFarmerEntryProvider.call(widget.month));
  }

  @override
  Widget build(BuildContext context) {
    final listRecordData = ref.watch(getFarmerEntryProvider.call(widget.month));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Milk Records',
            style: TextStyle(
                fontSize: 20.0.sp,
                fontWeight: FontWeight.w900,
                color: AppColor.whiteClr),
          ),
          actions: [
            IconButton(
                onPressed: () => navigationPop(),
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.whiteClr,
                ))
          ],
        ),
        body: LoadingdataScreen(
          varBuild: listRecordData,
          data: (data) {
            return RSizedBox(
              height: double.infinity,
              child: data.isEmpty
                  ? Center(
                      child: Text(
                      'No records found',
                      style:
                          TextStyle(fontSize: 16.sp, color: AppColor.appColor),
                    ))
                  : MilkSellRecordsTable(milkData: data),
            );
          },
        ));
  }
}
