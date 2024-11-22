import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';
import 'package:mydairy/driver_dashboard/auth/auth_controller.dart';

import '../../authentication/auth_model.dart';
import '../../authentication/check_user.dart';
import '../../common/services/splash_screen.dart';
import '../../export.dart';
import 'auth_controller.dart';

class TransportForgetScreen extends ConsumerStatefulWidget {
  const TransportForgetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransportForgetScreenState();
}

class _TransportForgetScreenState extends ConsumerState<TransportForgetScreen> {
  TextEditingController mobile_ctr = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _isdriver = ref.watch(driver_login_provider);
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
              child: Text("Forgot Password?",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColor.whiteClr,
                      fontWeight: FontWeight.w500)),
            ),
            RSizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Don’t worry! It occurs. Please enter the number linked with your account.",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RSizedBox(height: 100.h),
                      Text("Number", style: TextStyle(fontSize: 14.sp)),
                      RSizedBox(height: 5.h),
                      Form(
                        key: _formkey,
                        child: TxtField(
                            keyboardType: TextInputType.number,
                            controller: mobile_ctr,
                            borderRadius: BorderRadius.circular(10),
                            hintText: "Number",
                            fillColor: AppColor.bluelightClr,
                            enableBorderColor: AppColor.transparent,
                            onChanged: (value) {
                              mobile_ctr.text = valueMobile(value!);
                            },
                            validator: validateMobile),
                      ),
                      RSizedBox(height: 20.h),
                      buttonContainer(
                          loder: ref.watch(loadingProvider),
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();

                              LoginModel loginModel = LoginModel(
                                  fcm_token: fcm_token,
                                  countryCode: "+91",
                                  mobile: tt(mobile_ctr));
                              if (_isdriver) {
                                ref
                                    .read(driver_auth_Provider)
                                    .forget(loginModel);
                              } else {
                                ref
                                    .read(transport_auth_Provider)
                                    .forget(loginModel);
                              }
                            }
                          },
                          width: double.infinity,
                          txt: "Send Code",
                          borderRadius: BorderRadius.circular(50))
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

  @override
  void dispose() {
    mobile_ctr.clear();
    super.dispose();
  }
}
