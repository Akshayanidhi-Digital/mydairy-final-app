import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/authentication/auth_model.dart';
import 'package:mydairy/common/widgets/function.dart';
import 'package:mydairy/export.dart';

import 'auth_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  int checkValue = 0;
  String countryPic = "";
  List<TextEditingController>? controller;
  @override
  void initState() {
    controller = List.generate(
        signUpTxtField.length, (index) => TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    controller!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigationPop();
        return navigationPop();
      },
      child: Scaffold(
        backgroundColor: AppColor.appColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: BackButton(
                        color: AppColor.whiteClr,
                        onPressed: () {
                          navigationPop();
                          navigationPop();
                        },
                      )),
                  RSizedBox(height: 10.0.sp),
                  Text("Create Account",
                      style:
                          TextStyle(color: AppColor.whiteClr, fontSize: 22.sp)),
                  Text("to get Started now!",
                      style:
                          TextStyle(color: AppColor.whiteClr, fontSize: 22.sp)),
                  RSizedBox(height: 50.sp),
                  signUpTxtFieldFn(
                      label: signUpTxtField[0].labelText,
                      controller: controller![0],
                      hint: signUpTxtField[0].hintText,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter ${signUpTxtField[0].labelText}";
                        }
                      }),
                  signUpTxtFieldFn(
                      suffixIcon: Icon(Icons.arrow_drop_down, size: 30.sp),
                      prefixIcon: countryPic.isEmpty
                          ? null
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                countryPic,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                      onTap: () {
                        showCountryPicker(
                            countryFilter: <String>['IN'],
                            context: context,
                            onSelect: (Country country) {
                              setState(() {
                                countryPic = "+${country.phoneCode}";
                                controller![1].text = "India";

                                log('Select country: ${country.countryCode}');
                              });
                            });
                      },
                      readOnly: true,
                      label: signUpTxtField[1].labelText,
                      controller: controller![1],
                      hint: signUpTxtField[1].hintText,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter ${signUpTxtField[1].labelText}";
                        }
                      }),
                  signUpTxtFieldFn(
                      keyboardType: TextInputType.number,
                      label: signUpTxtField[2].labelText,
                      controller: controller![2],
                      hint: signUpTxtField[2].hintText,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter ${signUpTxtField[2].labelText}";
                        } else if (value.length < 10) {
                          return "Phone Number required at least 10 Digit";
                        }
                      }),
                  signUpTxtFieldFn(
                      label: signUpTxtField[3].labelText,
                      controller: controller![3],
                      hint: signUpTxtField[3].hintText,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter ${signUpTxtField[3].hintText}";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                      }),
                  signUpTxtFieldFn(
                      label: signUpTxtField[4].labelText,
                      controller: controller![4],
                      hint: signUpTxtField[4].hintText,
                      validator: (String value) {
                        if (value != controller![3].text) {
                          return "Password doesn't match";
                        }
                      }),
                  Row(
                    children: [
                      RPadding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              checkValue == 0 ? checkValue = 1 : checkValue = 0;
                              print("check $checkValue");
                            });
                          },
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.whiteClr),
                                color: AppColor.appColor,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Center(
                                child: Icon(
                              checkValue == 0 ? null : Icons.check,
                              color: AppColor.whiteClr,
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                            "By Signing Up you Agree To The Privacy Policy",
                            style: TextStyle(
                                color: AppColor.whiteClr, fontSize: 13.sp)),
                      ),
                    ],
                  ),
                  RSizedBox(height: 40.0.sp),
                  buttonContainer(
                      loaderColor: AppColor.appColor,
                      loder: ref.watch(loadingProvider),
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          if (checkValue == 0) {
                            snackBarMessage(
                                msg: "Please accept terms and conditions",
                                color: AppColor.redClr);
                          } else {
                            ref.read(authProvider).signUp(SignUpModel(
                                name: tt(controller![0]),
                                countryCode: "+91",
                                mobile: tt(controller![2]),
                                password: tt(controller![3]),
                                confirmPassword: tt(controller![4]),
                                acceptTerms: checkValue));
                            print("valid");
                          }
                        }
                      },
                      width: double.infinity,
                      txt: "Sign Up",
                      txtColor: AppColor.blackClr,
                      color: AppColor.whiteClr),
                  RSizedBox(height: 100.sp)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

signUpTxtFieldFn(
    {Function? validator,
    String? hint,
    String? label,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    Widget? prefixIcon,
    int? maxLines,
    bool? readOnly,
    void Function()? onTap,
    TextEditingController? controller}) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.sp, bottom: 3.sp),
          child: Text(label!, style: TextStyle(color: AppColor.whiteClr)),
        ),
        TxtField(
            maxLines: maxLines,
            readOnly: readOnly,
            onTap: onTap,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorColor: AppColor.yellowClr,
            keyboardType: keyboardType,
            lableStyle: TextStyle(color: AppColor.redClr),
            htstyle: TextStyle(color: AppColor.blackClr),
            bordertype: false,
            fillColor: AppColor.bluelightClr,
            borderRadius: BorderRadius.circular(8.r),
            hintText: hint,
            controller: controller,
            validator: validator),
      ],
    ),
  );
}

List<TxtFormModel> signUpTxtField = [
  TxtFormModel(hintText: "Enter Name", labelText: "Name"),
  TxtFormModel(hintText: "Select Country", labelText: "Country"),
  TxtFormModel(hintText: "Enter Number", labelText: "Number"),
  TxtFormModel(hintText: "Password", labelText: "Password"),
  TxtFormModel(hintText: "Confierm Password", labelText: "Confierm Password"),
];

class TxtFormModel {
  String? labelText;
  String? hintText;
  int? minLines;

  String? controller;

  TxtFormModel({this.labelText, this.hintText, this.minLines, this.controller});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelText'] = this.labelText;
    data['hintText'] = this.hintText;
    data['minLines'] = this.minLines;
    data['controller'] = this.controller;
    return data;
  }
}
