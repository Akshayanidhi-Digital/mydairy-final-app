import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';

import '../../authentication/sign_up.dart';
import '../../export.dart';
import '../model/driver_list_model.dart';
import 'controller.dart';

class AddEditDriverScreen extends ConsumerStatefulWidget {
  final bool edit_driver;
  final DriverListModel? data;
  const AddEditDriverScreen({super.key, this.edit_driver = false, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddEditDriverScreenState();
}

class _AddEditDriverScreenState extends ConsumerState<AddEditDriverScreen> {
  String? countryPic = "";
  Country? countrys;
  final _formkey = GlobalKey<FormState>();
  final name_controller = TextEditingController();
  final father_name_controller = TextEditingController();
  final email_controller = TextEditingController();
  final mobile_controller = TextEditingController();
  final country_controller = TextEditingController();
  @override
  void initState() {
    if (widget.edit_driver == true) {
      name_controller.text = widget.data!.name!;
      father_name_controller.text = widget.data!.fatherName!;
      email_controller.text =
          widget.data!.email == "NA" ? '' : widget.data!.email!;
      mobile_controller.text = widget.data!.mobile!;
      country_controller.text = 'India';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
            title: widget.edit_driver ? 'Edit Driver' : 'Add Driver'),
        body: Form(
          key: _formkey,
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(add_edit_TxtField[0].labelText!,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14.sp)),
                        RSizedBox(height: 5.h),
                        TxtField(
                          borderRadius: BorderRadius.circular(10),
                          controller: name_controller,
                          hintText: add_edit_TxtField[0].hintText,
                          validator: (value) => validateNameField(value,
                              "driver ${add_edit_TxtField[0].labelText!}"),
                        ),
                        Text(add_edit_TxtField[1].labelText!,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14.sp)),
                        RSizedBox(height: 5.h),
                        TxtField(
                          borderRadius: BorderRadius.circular(10),
                          controller: father_name_controller,
                          hintText: add_edit_TxtField[1].hintText,
                          validator: (value) => validateNameField(
                              value, add_edit_TxtField[1].labelText!),
                        ),
                        Text(add_edit_TxtField[2].labelText!,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14.sp)),
                        RSizedBox(height: 5.h),
                        TxtField(
                          borderRadius: BorderRadius.circular(10),
                          controller: email_controller,
                          hintText: add_edit_TxtField[2].hintText,
                        ),
                        Text('Country',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14.sp)),
                        RSizedBox(height: 5.h),
                        TxtField(
                          readOnly: true,
                          onTap: () {
                            showCountryPicker(
                                countryFilter: <String>['IN'],
                                context: context,
                                onSelect: (Country country) => setState(() {
                                      countryPic = "+${country.phoneCode}";
                                      country_controller.text = country.name;
                                      countrys = country;
                                    }));
                          },
                          borderRadius: BorderRadius.circular(10),
                          controller: country_controller,
                          hintText: country_controller.text.isEmpty
                              ? 'Select Contry'
                              : country_controller.text,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter country";
                            }
                          },
                        ),
                        Text(add_edit_TxtField[3].labelText!,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14.sp)),
                        RSizedBox(height: 5.h),
                        TxtField(
                            keyboardType: TextInputType.number,
                            borderRadius: BorderRadius.circular(10),
                            controller: mobile_controller,
                            hintText: add_edit_TxtField[3].hintText,
                            validator: validateMobile,
                            onChanged: (value) {
                              mobile_controller.text = valueMobile(value!);
                            }),
                        RSizedBox(height: 40.h),
                        buttonContainer(
                            loder: ref.watch(loadingProvider),
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                if (widget.edit_driver == true) {
                                  ref
                                      .read(driver_controller)
                                      .transport_driver_update(
                                          data: DriverListModel(
                                                  driverId: widget
                                                      .data!.driverId!
                                                      .toString(),
                                                  name: tt(name_controller),
                                                  fatherName: tt(
                                                      father_name_controller),
                                                  email: tt(email_controller),
                                                  mobile: tt(mobile_controller),
                                                  countryCode:
                                                      countryPic!.isNotEmpty
                                                          ? countryPic
                                                          : "+91")
                                              .toJson());
                                  // _updateDriver();
                                } else {
                                  ref.read(driver_controller).driver_add(
                                      data: DriverListModel(
                                              name: tt(name_controller),
                                              fatherName:
                                                  tt(father_name_controller),
                                              email: tt(email_controller),
                                              mobile: tt(mobile_controller),
                                              countryCode:
                                                  countryPic!.isNotEmpty
                                                      ? countryPic
                                                      : "+91")
                                          .toJson());
                                }
                              }
                            },
                            borderRadius: BorderRadius.circular(20),
                            width: double.infinity,
                            txt: widget.edit_driver
                                ? 'Driver Update'
                                : 'Add Driver')
                      ]))),
        ));
  }

  List<TxtFormModel> add_edit_TxtField = [
    TxtFormModel(hintText: "Enter Name", labelText: "Name"),
    TxtFormModel(hintText: "Enter Father Name", labelText: "Father Name"),
    TxtFormModel(hintText: "Enter Email-ID", labelText: "Email-ID"),
    TxtFormModel(hintText: "Enter Mobile No", labelText: "Mobile NO."),
  ];
}
