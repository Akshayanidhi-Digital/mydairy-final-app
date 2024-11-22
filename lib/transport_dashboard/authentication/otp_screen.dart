import 'package:flutter/material.dart';
import 'package:mydairy/common/services/splash_screen.dart';
import 'package:mydairy/common/widgets/function.dart';
import 'package:mydairy/driver_dashboard/auth/auth_controller.dart';
import 'package:mydairy/transport_dashboard/authentication/auth_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../authentication/auth_controller.dart';
import '../../authentication/auth_model.dart';
import '../../authentication/check_user.dart';
import '../../export.dart';

class TransportOtpScreen extends ConsumerStatefulWidget {
  final String? mobile;
  const TransportOtpScreen({super.key, this.mobile});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransportOtpScreenState();
}

class _TransportOtpScreenState extends ConsumerState<TransportOtpScreen> {
  final formkey = GlobalKey<FormState>();
  final otpcontroller = TextEditingController();
  @override
  void initState() {
    Future(() => ref.read<Authentication>(authProvider).startTimer());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _isdriver = ref.watch(driver_login_provider);
    final minutes = ref.watch(minuteProvider);
    final seconds = ref.watch(secondProvider);
    final _buttonEnabled = ref.watch(buttonEnabledProvider);
    return Scaffold(
      backgroundColor: AppColor.appColor,
      body: Container(
        height: double.infinity,
        // padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RSizedBox(height: 50.h),
            const BackButton(
              color: AppColor.whiteClr,
              style: ButtonStyle(iconSize: WidgetStatePropertyAll(30)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("OTP Verification",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColor.whiteClr,
                      fontWeight: FontWeight.w500)),
            ),
            RSizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Enter the verification code we just sent on your mobile",
                style: TextStyle(color: AppColor.whiteClr, fontSize: 15.sp),
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
                      RSizedBox(height: 100.h),
                      RSizedBox(
                        height: 55.h,
                        child: Form(
                          key: formkey,
                          child: PinCodeTextField(
                            mainAxisAlignment: MainAxisAlignment.center,
                            autoDisposeControllers: true,
                            enablePinAutofill: true,
                            keyboardType: TextInputType.phone,
                            length: 4,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                                fieldOuterPadding:
                                    EdgeInsets.symmetric(horizontal: 8.w),
                                activeColor: AppColor.appColor,
                                selectedColor: AppColor.appColor,
                                disabledColor: AppColor.appColor,
                                errorBorderColor: AppColor.appColor,
                                inactiveFillColor: AppColor.bluelightClr,
                                selectedFillColor: AppColor.bluelightClr,
                                inactiveColor: AppColor.whiteClr,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(10),
                                fieldHeight: 50.h,
                                fieldWidth: 50.w,
                                activeFillColor: AppColor.whiteClr),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            controller: otpcontroller,
                            errorTextMargin: EdgeInsets.only(top: 47.sp),
                            validator: (value) => validateOTP(value!),
                            onCompleted: (v) {},
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                      ),
                      RSizedBox(height: 30.h),
                      buttonContainer(
                          loder: ref.watch(loadingProvider),
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              LoginModel loginModel = LoginModel(
                                  fcm_token: fcm_token,
                                  countryCode: "+91",
                                  mobile: widget.mobile,
                                  otp: tt(otpcontroller));
                              if (_isdriver) {
                                ref
                                    .read(driver_auth_Provider)
                                    .verify(loginModel);
                              } else {
                                ref
                                    .read(transport_auth_Provider)
                                    .verify(loginModel);
                              }
                            }
                          },
                          width: double.infinity,
                          txt: "Verify",
                          borderRadius: BorderRadius.circular(50),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                      RSizedBox(height: 20.h),
                      Align(
                          alignment: Alignment.centerRight,
                          child: _buttonEnabled
                              ? TextButton(
                                  onPressed: () {
                                    if (_isdriver) {
                                      ref
                                          .read(driver_auth_Provider)
                                          .resend_otp(LoginModel(
                                              countryCode: "+91",
                                              mobile: widget.mobile))
                                          .then(
                                        (value) {
                                          if (ref.watch(boolTimerProver) ==
                                              true) {
                                            ref
                                                .read<Authentication>(
                                                    authProvider)
                                                .startTimer();
                                          }
                                        },
                                      );
                                    } else {
                                      ref
                                          .read(transport_auth_Provider)
                                          .resend_otp(LoginModel(
                                              countryCode: "+91",
                                              mobile: widget.mobile))
                                          .then(
                                        (value) {
                                          if (ref.watch(boolTimerProver) ==
                                              true) {
                                            ref
                                                .read<Authentication>(
                                                    authProvider)
                                                .startTimer();
                                          }
                                        },
                                      );
                                    }
                                  },
                                  child: Text("Resend OTP",
                                      style: TextStyle(
                                          color: AppColor.appColor,
                                          fontSize: 14.sp)))
                              : Text(
                                  "Please Wait ${(minutes == 0) ? "" : "$minutes minute"} $seconds second",
                                  style: TextStyle(
                                      fontSize: 16.sp, color: AppColor.redClr)))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
