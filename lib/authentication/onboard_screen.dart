import 'package:flutter/material.dart';
import 'package:mydairy/authentication/auth_controller.dart';
import 'package:mydairy/authentication/auth_model.dart';
import 'package:mydairy/common/services/splash_screen.dart';
import 'package:mydairy/common/widgets/function.dart';

import '../export.dart';
import 'sign_up.dart';

class OnboardScreen extends ConsumerStatefulWidget {
  const OnboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends ConsumerState<OnboardScreen> {
  List<TextEditingController>? controller;
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    ref.read(locationProvider.notifier).getCurrentLocation();
    controller = List.generate(
        onBoardTxtField.length, (index) => TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    controller!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationlsProvider);

    return Scaffold(
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
                    label: onBoardTxtField[0].labelText,
                    controller: controller![0],
                    hint: onBoardTxtField[0].hintText,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter ${onBoardTxtField[0].labelText}";
                      }
                    }),
                signUpTxtFieldFn(
                    label: onBoardTxtField[1].labelText,
                    controller: controller![1],
                    hint: onBoardTxtField[1].hintText,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter ${onBoardTxtField[1].labelText}";
                      }
                    }),
                signUpTxtFieldFn(
                    maxLines: 4,
                    label: onBoardTxtField[2].labelText,
                    controller: controller![2],
                    hint: onBoardTxtField[2].hintText,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter ${onBoardTxtField[2].hintText}";
                      }
                    }),
                RSizedBox(height: 40.0.sp),
                buttonContainer(
                    loaderColor: AppColor.appColor,
                    loder: ref.watch(loadingProvider),
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        ref.read(authProvider).on_board(OnBoardModel(
                            fcm_token: fcm_token,
                            fatherName: tt(controller![0]),
                            dairyName: tt(controller![1]),
                            address: tt(controller![2]),
                            latitude:
                                location == [] ? '' : location[0].toString(),
                            longitude:
                                location == [] ? '' : location[1].toString()));
                      }
                    },
                    width: double.infinity,
                    txt: "Submit",
                    txtColor: AppColor.blackClr,
                    color: AppColor.whiteClr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<TxtFormModel> onBoardTxtField = [
  TxtFormModel(hintText: "Father Name", labelText: "Father Name"),
  TxtFormModel(hintText: "Dairy Name", labelText: "Dairy Name"),
  TxtFormModel(hintText: "Dairy Address", labelText: "Dairy Address")
];
