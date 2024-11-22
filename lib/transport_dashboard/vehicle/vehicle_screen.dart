import 'package:flutter/material.dart';
import 'package:mydairy/transport_dashboard/model/vehicle_list_model.dart';
import '../../export.dart';
import '../driver/driver_screen.dart';
import 'api_controller.dart';
import 'controller.dart';
import 'vehicle_add_edit_screen.dart';

bool data_vehicle_fetch_provider = false;

class VehicleScreen extends ConsumerStatefulWidget {
  const VehicleScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends ConsumerState<VehicleScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  @override
  void initState() {
    _scrollController.addListener(
      () {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          fetch_data();
        }
      },
    );
    super.initState();
  }

  fetch_data() async {
    if (_isLoading) return;
    setState(() {});
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 3));
    if (data_vehicle_fetch_provider == false) {
      ref.read(page_no_Provider.notifier).state++;
      _isLoading = false;
      // ref.read(vehicle_list_provider);
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final vehicle_data = ref.watch(vahicle_api_list_Provider);
    final data = ref.watch(vehicle_list_provider);
    return Scaffold(
        appBar: BaseAppBar(title: 'Vehicle', actionList: [
          CustomAppBarBtn(
              onTap: () => navigationTo(VehicleAddEditScreen()),
              title: 'Add Vehicle')
        ]),
        body: LoadingdataScreen(
          varBuild: vehicle_data,
          data: (mydata) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(top: 10.h, bottom: 20),
                  shrinkWrap: true,
                  itemCount: data.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == data.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // return ListTile(title: Text(_items[index]));
                    return Padding(
                      padding: EdgeInsets.all(4.0.r),
                      child: VehicalListScr(
                        data: data[index],
                        index: index,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

// List<TxtModel> vehicle_lst_txt = [
//   TxtModel(txt: "Driver Name"),
//   TxtModel(txt: "Number"),
//   TxtModel(txt: "Quantity"),
//   TxtModel(txt: "Unit type"),
//   TxtModel(txt: '')
// ];

class VehicalListScr extends ConsumerWidget {
  final int? index;
  final VehicleListModel data;
  const VehicalListScr({super.key, required this.data, this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: AppColor.ligthClr,
                borderRadius: BorderRadius.circular(20.sp)),
            height: 155.sp,
            width: double.infinity,
            child: Row(children: [
              RSizedBox(width: 15.sp),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  width: 300.sp,
                  child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Text("S.No.: ${index! + 1}",
                            overflow: TextOverflow.ellipsis),
                        Text("Name : ${data.driver!.name}",
                            overflow: TextOverflow.ellipsis),
                        Text("Vehicle No : ${data.vehicleNumber}",
                            overflow: TextOverflow.ellipsis),
                        // Text("Email : ${data.driver!.email}",
                        //     overflow: TextOverflow.ellipsis),
                        Text(
                            "Mobile No : ${data.driver!.countryCode} ${data.driver!.mobile}",
                            overflow: TextOverflow.ellipsis),
                        Text(
                            "Quantity : ${data.capacity.toString()} ${data.unit}",
                            overflow: TextOverflow.ellipsis),
                        RSizedBox(height: 8.sp),
                        Row(
                          children: [
                            buttonContainer(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => TransportAlertBoxTR(
                                          datas: data, vehical: true));
                                  print("id:::  ${data.id}");
                                },
                                borderRadius: BorderRadius.circular(30.r),
                                hight: 26.sp,
                                color: data.isActive == 1
                                    ? AppColor.appColor
                                    : AppColor.redClr,
                                width: 100.w,
                                txt: "Status Update",
                                fontSize: 11.sp),
                            RSizedBox(width: 8.sp),
                            buttonContainer(
                                onTap: () {
                                  navigationTo(VehicleAddEditScreen(
                                      is_edit: true, data: data));
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
