import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';
import 'package:mydairy/driver_dashboard/auth/auth_controller.dart';

import '../../authentication/auth_model.dart';
import '../../authentication/check_user.dart';
import '../../common/services/splash_screen.dart';
import '../../export.dart';
import 'auth_controller.dart';
import 'forget_screen.dart';

class TransportLoginScreen extends ConsumerStatefulWidget {
  const TransportLoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransportLoginScreenState();
}

class _TransportLoginScreenState extends ConsumerState<TransportLoginScreen> {
  TextEditingController mobile_ctr = TextEditingController();
  TextEditingController password_ctr = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _isdriver = ref.watch(driver_login_provider);
    return Scaffold(
      backgroundColor: AppColor.appColor,
      body: Container(
        height: double.infinity,
        // padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              RSizedBox(height: 50.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\nSign In",
                        style: TextStyle(
                            fontSize: 34.sp,
                            color: AppColor.whiteClr,
                            fontWeight: FontWeight.w500)),
                    Image(
                      image: const AssetImage(Img.transport_logo),
                      width: 174.w,
                      height: 84.h,
                    )
                  ],
                ),
              ),
              RSizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "Sign in to continue as ${_isdriver ? "driver" : "transport"}.",
                    style: TextStyle(color: AppColor.whiteClr, fontSize: 15.sp),
                  ),
                ),
              ),
              RSizedBox(height: 50.h),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.sp),
                  decoration: const BoxDecoration(
                      color: AppColor.whiteClr,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RSizedBox(height: 50.h),
                        TxtField(
                            keyboardType: TextInputType.number,
                            controller: mobile_ctr,
                            borderRadius: BorderRadius.circular(20),
                            hintText: "Mobile Number",
                            fillColor: const Color(0xffF5F5F5),
                            enableBorderColor: AppColor.transparent,
                            onChanged: (value) {
                              mobile_ctr.text = valueMobile(value!);
                            },
                            validator: validateMobile),
                        RSizedBox(height: 20.h),
                        TxtField(
                            controller: password_ctr,
                            borderRadius: BorderRadius.circular(20),
                            hintText: "Password",
                            fillColor: const Color(0xffF5F5F5),
                            enableBorderColor: AppColor.transparent,
                            validator: validatePassword),
                        // RSizedBox(height: 20.h),
                        Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                navigationTo(TransportForgetScreen());
                              },
                              child: const Text("Forgot Password?",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            )),
                        RSizedBox(height: 20.h),
                        buttonContainer(
                            loder: ref.watch(loadingProvider),
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                LoginModel loginModel = LoginModel(
                                    fcm_token: fcm_token,
                                    countryCode: "+91",
                                    mobile: tt(mobile_ctr),
                                    password: tt(password_ctr));
                                print("driver :: $_isdriver");
                                if (_isdriver) {
                                  ref
                                      .read(driver_auth_Provider)
                                      .login(loginModel);
                                } else {
                                  ref
                                      .read(transport_auth_Provider)
                                      .login(loginModel);
                                }
                              }
                            },
                            width: double.infinity,
                            txt: "Sign In",
                            borderRadius: BorderRadius.circular(50))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    mobile_ctr.clear();
    password_ctr.clear();
    super.dispose();
  }
}
