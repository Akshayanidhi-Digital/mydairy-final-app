// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, use_build_context_synchronously

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydairy/export.dart';
import 'package:mydairy/transport_dashboard/authentication/login_screen.dart';

import 'auth_controller.dart';

final driver_login_provider = StateProvider<bool>((ref) {
  return false;
});

class UserCheckLoginScreen extends ConsumerStatefulWidget {
  const UserCheckLoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserCheckLoginScreenState();
}

class _UserCheckLoginScreenState extends ConsumerState<UserCheckLoginScreen> {
  final TextEditingController inputControllerMobile = TextEditingController();
  bool mobileInputError = false;
  final _formkey = GlobalKey<FormState>();
  String? countryPic = "+91";
  @override
  void dispose() {
    inputControllerMobile.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Img.background),
              fit: BoxFit.cover,
              alignment: Alignment.center),
        ),
        height: double.infinity,
        width: double.infinity,
        child: RSizedBox(
          width: (MediaQuery.of(context).size.width * .75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RSizedBox(height: 50.h),
              Text(
                'Login',
                style: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 30.0.sp,
                    fontWeight: FontWeight.w900),
              ),
              RSizedBox(height: 20.sp),
              Form(
                key: _formkey,
                child: SizedBox(
                  width: (MediaQuery.of(context).size.width * .75),
                  child: TxtField(
                    prefixIcon: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            countryFilter: <String>['IN'],
                            context: context,
                            onSelect: (Country country) {
                              setState(() {
                                countryPic = "+${country.phoneCode}";
                              });
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15.0.r),
                          child: Text(
                            textAlign: TextAlign.center,
                            "$countryPic",
                            style: const TextStyle(
                                color: AppColor.appColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    controller: inputControllerMobile,
                    borderRadius: BorderRadius.circular(8.r),
                    enableBorderColor: AppColor.appColor,
                    validator: validateMobile,
                    onChanged: (value) {
                      inputControllerMobile.text = valueMobile(value!);
                    },
                    border: true,
                    hintText: "Phone Number",
                    hintStyle: true,
                  ),
                  //  TxtField(
                  //   prefixIcon: Padding(
                  //     padding: EdgeInsets.all(15.0.r),
                  //     child: Text(
                  //       textAlign: TextAlign.center,
                  //       "+91",
                  //       style: TextStyle(
                  //           color: AppColor.appColor,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  //   borderRadius: BorderRadius.circular(8.r),
                  //   maxLength: 10,
                  //   keyboardType: TextInputType.phone,
                  //   controller: inputControllerMobile,
                  //   enableBorderColor: AppColor.appColor,
                  //   validator: validateMobile,
                  //   border: true,
                  //   hintText: "Phone Number",
                  //   hintStyle: true,
                  // ),
                ),
              ),
              RSizedBox(height: 10.h),
              buttonContainer(
                  loder: ref.watch(loadingProvider),
                  onTap: () async {
                    await SystemSound.play(SystemSoundType.click);
                    if (_formkey.currentState!.validate()) {}
                    if (inputControllerMobile.text.isEmpty) {
                      snackBarMessage(
                          msg: "Phone number is Required"
                          );
                    } else if (inputControllerMobile.text.length < 10) {
                      snackBarMessage(
                          msg: "Password must be 10 characters"
                          );
                    } else {
                
                      ref
                          .read(authProvider)
                          .checkUser(inputControllerMobile.text.toString());
                    }
                  },
                  width: (MediaQuery.of(context).size.width * .75),
                  hight: 40.0.h,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  txt: 'Login'),
              RSizedBox(height: 5.h),
              buttonContainer(
                  onTap: () async {
                    await SystemSound.play(SystemSoundType.click);
                    showRegisterPopup(context);
                  },
                  width: (MediaQuery.of(context).size.width * .75),
                  hight: 40.0.h,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  txt: 'Register'),
              RSizedBox(height: 10.h),
              const Text("OR"),
              RSizedBox(height: 10.h),
              buttonContainer(
                  onTap: () {
                    ref.read(driver_login_provider.notifier).state = false;
                    navigationTo(const TransportLoginScreen());
                  },
                  width: (MediaQuery.of(context).size.width * .75),
                  hight: 40.0.h,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  txt: 'Transport Login'),
              RSizedBox(height: 10.h),
              buttonContainer(
                  onTap: () {
                    ref.read(driver_login_provider.notifier).state = true;
                    navigationTo(const TransportLoginScreen());
                  },
                  width: (MediaQuery.of(context).size.width * .75),
                  hight: 40.0.h,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  txt: 'Driver Login'),
            ],
          ),
        ),
      ),
    );
  }
}
