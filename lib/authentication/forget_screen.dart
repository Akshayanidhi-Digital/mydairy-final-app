import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../common/widgets/decor.dart';
import 'package:mydairy/export.dart';

import 'auth_controller.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  final String accounttype;
  final String mobile;
  const ForgetPasswordScreen(
      {super.key, required this.mobile, required this.accounttype});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  final _numberkey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  String? countryPic = "+91";
  @override
  void initState() {
    mobileController.text = widget.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appheight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.appColor,
      body: Container(
        width: double.infinity,
        decoration: boxDecoration(),
        child: Column(
          children: [
            RSizedBox(height: appheight / 3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RSizedBox(height: 70.h),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                        fontSize: 30.sp,
                        color: AppColor.appColor,
                        fontWeight: FontWeight.bold),
                  ),
                  RSizedBox(height: 30.h),
                  Text("Phone No.", style: TextStyle(color: AppColor.appColor)),
                  Form(
                    key: _numberkey,
                    child: TxtField(
                      prefixIcon: InkWell(
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
                            // showCountryPicker(
                            //   context: context,
                            //   countryListTheme: CountryListThemeData(
                            //     flagSize: 25,
                            //     backgroundColor: AppColor.appColor,
                            //     textStyle: TextStyle(
                            //         fontSize: 16.sp, color: AppColor.whiteClr),
                            //     bottomSheetHeight: 500,
                            //     borderRadius: const BorderRadius.only(
                            //       topLeft: Radius.circular(20.0),
                            //       topRight: Radius.circular(20.0),
                            //     ),
                            //     inputDecoration: InputDecoration(
                            //       fillColor: AppColor.whiteClr,
                            //       filled: true,
                            //       labelText: 'Search',
                            //       hintText: 'Start typing to search',
                            //       prefixIcon: const Icon(Icons.search),
                            //       border: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //           color: AppColor.whiteClr,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            //   onSelect: (Country country) {
                            //     if (kDebugMode) {
                            //       print('Select country: ${country.phoneCode}');
                            //     }
                            //     setState(() {
                            //       countryPic = country.phoneCode;
                            //     });
                            //   },
                            // );
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
                      controller: mobileController,
                      borderRadius: BorderRadius.circular(8.r),
                      enableBorderColor: AppColor.appColor,
                      validator: validateMobile,
                      onChanged: (value) {
                        mobileController.text = valueMobile(value!);
                      },
                      border: true,
                      hintText: "Phone No.",
                      hintStyle: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        navigationPop();
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(
                            color: AppColor.appColor, fontSize: 16.sp),
                      ),
                    ),
                  ),
                  Container(height: appheight * .1),

                  // RSizedBox(height: 50.h)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        child: buttonContainer(
            loder: ref.watch(loadingProvider),
            onTap: () {
              if (_numberkey.currentState!.validate()) {
                ref.read(authProvider).fotgetPassword(
                    mobile: mobileController.text.trim(),
                    accounttype: widget.accounttype);
              }
            },
            txt: "Get Otp",
            color: AppColor.appColor,
            border: Border.all(color: AppColor.whiteClr),
            txtColor: AppColor.whiteClr),
      ),
    );
  }
}
