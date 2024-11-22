import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';
import 'package:mydairy/driver_dashboard/model/profile_model.dart';
import '../../export.dart';
import '../../transport_dashboard/profile/controller.dart';
import 'controller.dart';

class DriverProfileScreen extends ConsumerStatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DriverProfileScreenState();
}

class _DriverProfileScreenState extends ConsumerState<DriverProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  String? country_name = "";
  final name = TextEditingController();
  final father_name = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final read_only = ref.watch(read_only_provider);
    final profile = ref.watch(dr_api_Provider);
    final users = ref.watch(dr_profile_Provider);
    profile_fn() {
      name.text = users.name.toString();
      father_name.text = users.fatherName.toString();
      mobile.text = users.mobile.toString();
      email.text = users.email == null ? '' : users.email.toString();
    }

    profile_fn();
    return Scaffold(
      appBar: BaseAppBar(
        title: read_only ? 'Profile' : 'Profile Update',
        actionList: [
          if (read_only == true)
            CustomAppBarBtn(
                name: true,
                txt2: "    Edit    ",
                onTap: () {
                  ref.read(read_only_provider.notifier).state = false;
                })
        ],
      ),
      body: LoadingdataScreen(
        varBuild: profile,
        data: (data) => Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RSizedBox(height: 10.h),
                  Text("Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.sp)),
                  TxtField(
                      controller: name,
                      readOnly: read_only,
                      borderRadius: BorderRadius.circular(8),
                      hintText: "Enter Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      }),
                  RSizedBox(height: 10.h),
                  Text("Father Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.sp)),
                  TxtField(
                      controller: father_name,
                      readOnly: read_only,
                      borderRadius: BorderRadius.circular(8),
                      hintText: "Enter Father Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Father Name';
                        }
                        return null;
                      }),
                  RSizedBox(height: 10.h),
                  Text("Mobile Number",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.sp)),
                  TxtField(
                      controller: mobile,
                      readOnly: read_only,
                      borderRadius: BorderRadius.circular(8),
                      hintText: "Mobile Number",
                      validator: validateMobile),
                  RSizedBox(height: 10.h),
                  Text("Email ID",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.sp)),
                  TxtField(
                      controller: email,
                      readOnly: read_only,
                      borderRadius: BorderRadius.circular(8),
                      hintText: "abc@gmail.com"),
                  RSizedBox(height: 10.h),
                  Text("Country",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.sp)),
                  TxtField(
                      suffixIcon:
                          read_only ? null : Icon(Icons.arrow_drop_down),
                      onTap: read_only
                          ? null
                          : () {
                              showCountryPicker(
                                  countryFilter: <String>['IN'],
                                  context: context,
                                  onSelect: (Country country) => setState(
                                      () => country_name = country.name));
                            },
                      readOnly: true,
                      borderRadius: BorderRadius.circular(8),
                      hintText: country_name!.isEmpty
                          ? 'Select Contry'
                          : country_name),
                  RSizedBox(height: 20.h),
                  if (read_only == false)
                    buttonContainer(
                        loder: ref.watch(loadingProvider),
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            ref.watch(loadingProvider.notifier).state = true;
                            ref
                                .read(dr_profile_api_Provider)
                                .dr_profile_update(DriverProfileModel(
                                  countryCode: "+91",
                                  email: tt(email),
                                  fatherName: tt(father_name),
                                  mobile: tt(mobile),
                                  name: tt(name),
                                ).toJson());
                          }
                        },
                        width: double.infinity,
                        txt: 'Update Profile')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
