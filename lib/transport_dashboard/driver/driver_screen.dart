import 'package:flutter/material.dart';
import '../../export.dart';
import '../model/driver_list_model.dart';
import '../model/vehicle_list_model.dart';
import '../vehicle/api_controller.dart';
import 'add_edit_driver_screen.dart';
import 'controller.dart';

class DriverScreen extends ConsumerStatefulWidget {
  const DriverScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DriverScreenState();
}

class _DriverScreenState extends ConsumerState<DriverScreen> {
  final ScrollController _scrollController = ScrollController();
  // final List<String> _items = [];
  bool _isLoading = false;
  int _page = 1;
  // final int _limit = 10;
  @override
  void initState() {
    super.initState();
    ref.read(driver_list_Provider.call('1'));
    // _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("max:::: max :::: ${_scrollController.position.maxScrollExtent}");
        _fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(driver_list_fetch_provider);
    final driver_build = ref.watch(driver_list_Provider.call('1'));

    return Scaffold(
      appBar: BaseAppBar(
        title: 'Driver',
        actionList: [
          CustomAppBarBtn(
              onTap: () => navigationTo(const AddEditDriverScreen()),
              title: 'Add Driver')
        ],
      ),
      body: LoadingdataScreen(
        varBuild: driver_build,
        data: (mydata) => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(top: 10.h, bottom: 20),
                shrinkWrap: true,
                itemCount: data.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == data.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  // return ListTile(title: Text(_items[index]));
                  return Padding(
                    padding: EdgeInsets.all(4.0.r),
                    child: DriverListSrc(data: data[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // ref.refresh(driver_list_Provider.call(1));
    data_fetch_provider = false;
    super.dispose();
  }

  Future<void> _fetchData() async {
    print(':::::::::data_fetch_provider ::  $data_fetch_provider');
    if (_isLoading) return;
    setState(() {});
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 3));
    if (data_fetch_provider == false) {
      print('data');
      _page++;
      _isLoading = false;
      ref.read(driver_list_Provider.call(_page));
    }
    _isLoading = false;
    setState(() {});
  }
}

class DriverListSrc extends ConsumerWidget {
  final DriverListModel data;
  const DriverListSrc({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: AppColor.ligthClr,
                borderRadius: BorderRadius.circular(20.sp)),
            height: 140.sp,
            width: double.infinity,
            child: Row(children: [
              RSizedBox(width: 15.sp),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  width: 300.sp,
                  child: ListView(
                      padding: EdgeInsets.zero,
                      // reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Text("Name : ${data.name}",
                            overflow: TextOverflow.ellipsis),
                        Text("Father Name : ${data.fatherName}",
                            overflow: TextOverflow.ellipsis),
                        Text("Email : ${data.email}",
                            overflow: TextOverflow.ellipsis),
                        Text("Mobile No : ${data.countryCode} ${data.mobile}",
                            overflow: TextOverflow.ellipsis),
                        RSizedBox(height: 8.sp),
                        Row(
                          children: [
                            buttonContainer(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => TransportAlertBoxTR(
                                          data: data, vehical: false));
                                  print("id:::  ${data.id}");
                                },
                                color: data.isBlocked == 0
                                    ? AppColor.appColor
                                    : AppColor.redClr,
                                borderRadius: BorderRadius.circular(30.r),
                                hight: 26.sp,
                                width: 100.w,
                                txt: "Status Update",
                                fontSize: 11.sp),
                            RSizedBox(width: 8.sp),
                            buttonContainer(
                                onTap: () {
                                  navigationTo(AddEditDriverScreen(
                                      data: data, edit_driver: true));
                                },
                                borderRadius: BorderRadius.circular(30.r),
                                hight: 26.sp,
                                width: 100.w,
                                txt: "Edit",
                                fontSize: 11.sp)
                          ],
                        )
                      ]))
            ])));
  }
}

class TransportAlertBoxTR extends ConsumerWidget {
  final VehicleListModel? datas;
  final DriverListModel? data;
  final bool vehical;
  const TransportAlertBoxTR(
      {super.key, this.data, this.vehical = false, this.datas});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: RSizedBox(
        height: 130.h,
        child: Column(
          children: [
            Icon(size: 25.sp, Icons.block_sharp, color: Colors.orange),
            Text(
              "Are you sure?",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.appColor),
            ),
            Text("You want to ${_is_block()} user",
                style: TextStyle(fontSize: 17.sp)),
            RSizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonContainer(
                    onTap: () => navigationPop(),
                    color: AppColor.redClr,
                    hight: 26.sp,
                    width: 50.sp,
                    fontSize: 14.sp,
                    txt: "No"),
                RSizedBox(width: 20.h),
                buttonContainer(
                    onTap: () {
                      if (vehical == true) {
                        ref
                            .read(vehical_api_provider)
                            .vehical_status_update(datas!.id!);
                      } else {
                        ref
                            .read(driver_controller)
                            .transport_driver_status_update(data!.driverId);

                        print("data.id : ${data!.isBlocked}");
                      }
                    },
                    color: AppColor.appColor,
                    hight: 26.sp,
                    width: 50.sp,
                    fontSize: 14.sp,
                    txt: "Yes"),
              ],
            )
          ],
        ),
      ),
    );
  }

  _is_block() {
    if (vehical == true) {
      return datas!.isActive == 1 ? "block" : "unblock";
    } else {
      return data!.isBlocked == 0 ? "block" : "unblock";
    }
  }
}
