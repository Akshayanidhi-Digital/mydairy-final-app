import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/authentication/auth_controller.dart';
import 'package:mydairy/common/services/splash_screen.dart';
import '../common/widgets/decor.dart';
import 'auth_model.dart';
import 'forget_screen.dart';
import 'package:mydairy/export.dart';

final loadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class Loadingbtn {
  final Ref ref;
  const Loadingbtn(this.ref);
  enable() => ref.read(loadingProvider.notifier).state = true;

  disable() => ref.read(loadingProvider.notifier).state = false;
}

final visibleProvider = StateProvider.autoDispose<bool>((ref) => true);

class LogInScreen extends ConsumerStatefulWidget {
  final String accounttype;
  final String name;
  final String mobile;

  const LogInScreen(
      {super.key,
      required this.accounttype,
      required this.mobile,
      this.name = ''});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final formkey = GlobalKey<FormState>();
  final numberkey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? countryPic = "+91";
  @override
  void dispose() {
    mobileController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  void initState() {
    mobileController.text = widget.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final visible = ref.watch(visibleProvider);
    final loader = ref.watch(loadingProvider);
    var appheight = MediaQuery.of(context).size.height;
    var appwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.appColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: appheight,
          width: appwidth,
          padding: EdgeInsets.symmetric(horizontal: 22.0.w),
          decoration: boxDecoration(),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                RSizedBox(height: 270.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.name} Login",
                        style: TextStyle(
                            fontSize: 30.sp,
                            color: AppColor.appColor,
                            fontWeight: FontWeight.bold)),
                    RSizedBox(height: 20.h),
                    Text("Phone Number",
                        style: TextStyle(
                            color: AppColor.appColor, fontSize: 16.sp)),
                    Form(
                      key: numberkey,
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
                                  log('Select country: ${country.countryCode}');
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
                        keyboardType: TextInputType.phone,
                        controller: mobileController,
                        borderRadius: BorderRadius.circular(8.r),
                        enableBorderColor: AppColor.appColor,
                        validator: validateMobile,
                        onChanged: (value) {
                          mobileController.text = valueMobile(value!);
                        },
                        border: true,
                        hintText: "Phone Number",
                        hintStyle: true,
                      ),
                    ),
                    RSizedBox(height: 10.h),
                    Text("Password",
                        style: TextStyle(
                            color: AppColor.appColor, fontSize: 16.sp)),
                    TxtField(
                      controller: passwordController,
                      enableBorderColor: AppColor.appColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: true,
                      hintText: "Password",
                      obscureText: visible ? true : false,
                      hintStyle: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(visibleProvider.notifier).state =
                              !ref.read(visibleProvider.notifier).state;
                        },
                        icon: Icon(
                          visible ? Icons.visibility : Icons.visibility_off,
                          color: AppColor.appColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          navigationTo(ForgetPasswordScreen(
                              mobile: widget.mobile,
                              accounttype: widget.accounttype));
                        },
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                              color: AppColor.appColor, fontSize: 16.sp),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          if (numberkey.currentState!.validate()) {
                            await ref.read(authProvider).login(LoginModel(
                                fcm_token: fcm_token,
                                countryCode: "+91",
                                mobile: mobileController.text.trim(),
                                type: "2",
                                accountType: widget.accounttype));
                          }
                        },
                        child: Text("Login with OTP",
                            style: TextStyle(
                                color: AppColor.appColor, fontSize: 16.sp))),
                    RSizedBox(height: appheight * .05),
                    Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: buttonContainer(
                            loder: loader,
                            hight: appheight * .05,
                            width: 150.0.w,
                            onTap: () async {
                              if (numberkey.currentState!.validate()) {
                                if (passwordController.text.isEmpty) {
                                  snackBarMessage(msg: "Please enter password");
                                } else if (passwordController.text.length < 6) {
                                  snackBarMessage(
                                      msg: "Password must be 6 characters");
                                } else {
                                  ref.read(loadingProvider.notifier).state =
                                      true;
                                  await ref.read(authProvider).login(LoginModel(
                                      fcm_token: fcm_token,
                                      countryCode: "+91",
                                      mobile: mobileController.text.trim(),
                                      password: passwordController.text.trim(),
                                      type: "1",
                                      accountType: widget.accounttype));
                                  ref.read(loadingProvider.notifier).state =
                                      false;
                                  log(passwordController.text);
                                }
                              }
                            },
                            txt: "Login",
                            color: AppColor.appColor,
                            border: Border.all(color: AppColor.whiteClr),
                            txtColor: AppColor.whiteClr)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(bottom: 10.0.h),
      //   child: Container(
      //     child: buttonContainer(
      //         hight: appheight * .05,
      //         width: 150.0.w,
      //         onTap: () {
      //           if (numberkey.currentState!.validate() ||
      //               formkey.currentState!.validate()) {
      //             ref.read(authProvider).login(
      //                 type: "1",
      //                 password: passwordController.text.trim(),
      //                 mobile: mobileController.text.trim());
      //             log(passwordController.text);
      //           }
      //         },
      //         txt: "Login",
      //         color: AppColor.appColor,
      //         border: Border.all(color: AppColor.whiteClr),
      //         txtColor: AppColor.whiteClr),
      //   ),
      // ),
    );
  }
}
