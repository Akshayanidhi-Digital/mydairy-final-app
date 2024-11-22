// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mydairy/authentication/auth_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mydairy/export.dart';

import '../common/services/splash_screen.dart';
import '../common/widgets/decor.dart';
import 'auth_model.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String? type;
  final String? mobile;
  final String? account_type;

  const OtpScreen({super.key, this.type, this.mobile, this.account_type});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  TextEditingController otpcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    Future(() => ref.read<Authentication>(authProvider).startTimer());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = ref.watch(minuteProvider);
    final seconds = ref.watch(secondProvider);
    final _buttonEnabled = ref.watch(buttonEnabledProvider);
    // final boolTime = ref.watch(boolTimerProver);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: AppColor.appColor,
        body: Container(
            decoration: boxDecoration(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RSizedBox(height: 250.h, width: double.infinity),
                      const Text(
                        "OTP Verification",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColor.appColor,
                        ),
                      ),
                      const Text(
                        "We have sent a OTP on your mobile number",
                        style:
                            TextStyle(fontSize: 16, color: AppColor.appColor),
                      ),
                      RSizedBox(height: 50.h, width: double.infinity),
                      RSizedBox(
                        height: 55.h,
                        child: Form(
                          key: formkey,
                          child: PinCodeTextField(
                            autoDisposeControllers: true,
                            enablePinAutofill: true,
                            keyboardType: TextInputType.phone,
                            length: 4,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
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
                            onCompleted: (v) {
                              // ref.read(otpProvider.notifier).otpSendprovider(
                              //     value: widget.value,
                              //     context: context,
                              //     number: widget.number,
                              //     otpCode: otpcontroller.text.trim());
                            },
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                      ),
                      RSizedBox(height: 25.h, width: double.infinity),
                      buttonContainer(
                        loder: ref.watch(loadingProvider),
                        width: double.infinity,
                        onTap: () {
                          print("otp ctr ::${otpcontroller.text}");
                          if (formkey.currentState!.validate()) {
                            ref.read(authProvider).otp(LoginModel(
                                fcm_token: fcm_token,
                                countryCode: "+91",
                                mobile: widget.mobile,
                                type: widget.type,
                                accountType: widget.account_type,
                                otp: otpcontroller.text.trim()));
                          } else {
                            snackBarMessage(msg: "Please enter valid OTP");
                          }
                        },
                        txt: "Verify",
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      RSizedBox(height: 20.h, width: double.infinity),
                      Align(
                          alignment: Alignment.centerRight,
                          child: _buttonEnabled
                              ? TextButton(
                                  onPressed: () {
                                    ref
                                        .read(authProvider)
                                        .resendOtp(
                                            mobile: widget.mobile,
                                            account_type: widget.account_type!)
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
                                  },
                                  child: Text("Resend OTP",
                                      style: TextStyle(
                                          color: AppColor.appColor,
                                          fontSize: 14.sp)))
                              : Text(
                                  "Please Wait ${(minutes == 0) ? "" : "$minutes minute"} $seconds second",
                                  style: TextStyle(
                                      fontSize: 16.sp, color: AppColor.redClr)))
                    ]))));
  }
}
