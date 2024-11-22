import 'package:flutter/material.dart';

import '../../export.dart';
import 'auth_controller.dart';

class TransportCreateNewPasswordScreen extends ConsumerStatefulWidget {
  const TransportCreateNewPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransportCreateNewPasswordScreenState();
}

class _TransportCreateNewPasswordScreenState
    extends ConsumerState<TransportCreateNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final eye = ref.watch(eyeProvider);
    final eye2 = ref.watch(eye2Provider);
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
              child: Text("Create new password",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColor.whiteClr,
                      fontWeight: FontWeight.w500)),
            ),
            RSizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Your new password must be unique form those previously used.",
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
                      RSizedBox(height: 70.h),
                      Text("New Password", style: TextStyle(fontSize: 14.sp)),
                      RSizedBox(height: 5.h),
                      TxtField(
                        borderRadius: BorderRadius.circular(10),
                        hintText: "New Password",
                        fillColor: AppColor.bluelightClr,
                        enableBorderColor: AppColor.transparent,
                        obscureText: eye ? false : true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              ref.read(eyeProvider.notifier).state =
                                  !ref.read(eyeProvider.notifier).state;
                            },
                            icon: Icon(
                                eye ? Icons.visibility_off : Icons.visibility)),
                      ),
                      RSizedBox(height: 10.h),
                      Text("Confirm Password",
                          style: TextStyle(fontSize: 14.sp)),
                      RSizedBox(height: 5.h),
                      TxtField(
                        borderRadius: BorderRadius.circular(10),
                        hintText: "Confirm Password",
                        fillColor: AppColor.bluelightClr,
                        enableBorderColor: AppColor.transparent,
                        obscureText: eye2 ? false : true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              ref.read(eye2Provider.notifier).state =
                                  !ref.read(eye2Provider.notifier).state;
                            },
                            icon: Icon(eye2
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      ),
                      RSizedBox(height: 20.h),
                      buttonContainer(
                          width: double.infinity,
                          txt: "Reset Password",
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
}
