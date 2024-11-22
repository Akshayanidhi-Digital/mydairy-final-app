// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../export.dart';
import '../model/vehicle_list_model.dart';
import 'api_controller.dart';
import 'controller.dart';

class VehicleAddEditScreen extends ConsumerStatefulWidget {
  bool is_edit;
  final VehicleListModel? data;
  VehicleAddEditScreen({super.key, this.is_edit = false, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VehicleAddEditScreenState();
}

class _VehicleAddEditScreenState extends ConsumerState<VehicleAddEditScreen> {
  final vehical_no_ctr = TextEditingController();
  final quantity_ctr = TextEditingController();
  @override
  void initState() {
    if (widget.is_edit == true) {
      Future.delayed(
        const Duration(seconds: 0),
        () {
          vehical_no_ctr.text = widget.data!.vehicleNumber!;
          quantity_ctr.text = widget.data!.capacity.toString();
          ref.read(driver_list_values_Provider.notifier).state =
              widget.data!.driverId!;
          ref.read(unit_type_value_Provider.notifier).state =
              widget.data!.unit!;
        },
      );
    }
    ref.read(vehical_api_provider).vehical_driver_list();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final driver_list = ref.watch(driver_list_value_Provider);
    final driver_value = ref.watch(driver_list_values_Provider);
    final unit_type = ref.watch(unit_type_lst_Provider);
    final unit_type_value = ref.watch(unit_type_value_Provider);
    print("driver list $driver_list");
    return Scaffold(
      appBar: BaseAppBar(
        title: widget.is_edit ? 'Edit Vehicle' : 'Add Vehicle',
        actionList: [
          CustomAppBarBtn(
              name: true,
              txt2: "    Edit    ",
              onTap: () {
                widget.is_edit = !widget.is_edit;
                setState(() {});
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RSizedBox(height: 10.h),
              Text(
                "Vehicle",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
              ),
              CtmDropDown(
                  borderRadius: BorderRadius.circular(8),
                  lst: driver_list.isEmpty
                      ? []
                      : driver_list
                          .map((e) => DropdownMenuItem<String>(
                                value: e['driver_id'],
                                child: Text(
                                  "${e['name']} - ${e['father_name']}",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ))
                          .toList(),
                  onChanged: (value) {
                    ref.read(driver_list_values_Provider.notifier).state =
                        value!;
                  },
                  hintTxt: "Vehicle",
                  inisialvalue: driver_value.isEmpty ? null : driver_value),
              RSizedBox(height: 10.h),
              Text("Vehicle Number",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp)),
              TxtField(
                  controller: vehical_no_ctr,
                  borderRadius: BorderRadius.circular(8),
                  hintText: "Vehicle Number"),
              RSizedBox(height: 10.h),
              Text("Quantity",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp)),
              TxtField(
                  controller: quantity_ctr,
                  borderRadius: BorderRadius.circular(8),
                  hintText: "Quantity"),
              RSizedBox(height: 10.h),
              Text("Unit Type",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp)),
              CtmDropDown(
                  borderRadius: BorderRadius.circular(8),
                  lst: unit_type
                      .map((e) => DropdownMenuItem<String>(
                            value: e['value'],
                            child: Text(
                              "${e['name']}",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    ref.read(unit_type_value_Provider.notifier).state = value!;
                  },
                  hintTxt: "Unit Type",
                  inisialvalue: unit_type_value),
              RSizedBox(height: 40.h),
              buttonContainer(
                  width: double.infinity,
                  txt: widget.is_edit ? 'Update' : 'Add')
            ],
          ),
        ),
      ),
    );
  }
}
