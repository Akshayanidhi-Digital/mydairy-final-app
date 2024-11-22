import 'package:flutter/material.dart';
import 'package:mydairy/authentication/auth_controller.dart';
import 'package:mydairy/common/widgets/decor.dart';
import 'package:mydairy/common/widgets/function.dart';
import 'package:mydairy/export.dart';

class CreatePasswordScreen extends ConsumerStatefulWidget {
  final String accounttype;
  final String mobile;
  final String resetToken;
  const CreatePasswordScreen(
      {super.key,
      required this.accounttype,
      required this.mobile,
      required this.resetToken});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends ConsumerState<CreatePasswordScreen> {
  TextEditingController pwCtr = TextEditingController();
  TextEditingController confiermPwCtr = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    pwCtr.clear();
    confiermPwCtr.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appColor,
      appBar: BaseAppBar(title: ''),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sp),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RSizedBox(height: 30.h),
                Text(
                  "Create New Password",
                  style: style14(fontSize: 22.sp),
                ),
                Text(
                  "Your new password must be unique form those previously used",
                  style: style14(),
                ),
                RSizedBox(height: 20.sp),
                Text(
                  "New Password",
                  style: style14(),
                ),
                RSizedBox(height: 5.h),
                TxtField(
                  controller: pwCtr,
                  errorColor: AppColor.yellowClr,
                  bordertype: false,
                  borderRadius: BorderRadius.circular(9.r),
                  hintText: "New Password",
                  validator: validatePassword,
                ),
                RSizedBox(height: 20.sp),
                Text(
                  "Confirm Password",
                  style: style14(),
                ),
                RSizedBox(height: 5.h),
                TxtField(
                  controller: confiermPwCtr,
                  errorColor: AppColor.yellowClr,
                  bordertype: false,
                  borderRadius: BorderRadius.circular(9.r),
                  hintText: "Confirm Password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter confirm password";
                    } else if (value != pwCtr.text) {
                      return "Password doesn't match";
                    } else {
                      return null;
                    }
                  },
                ),
                RSizedBox(height: 50.sp),
                buttonContainer(
                    loaderColor: AppColor.blackClr,
                    loder: ref.watch(loadingProvider),
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        ref.read(authProvider).passwordUpdate(
                            mobile: widget.mobile,
                            accounttype: widget.accounttype,
                            data: CreatePasswordModel(
                                resetToken: widget.resetToken,
                                confirmNewPassword: tt(confiermPwCtr),
                                newPassword: tt(pwCtr)));
                      }
                    },
                    txt: "Reset Password",
                    width: double.infinity,
                    color: AppColor.whiteClr,
                    txtColor: AppColor.blackClr)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreatePasswordModel {
  String? newPassword;
  String? confirmNewPassword;
  String? resetToken;

  CreatePasswordModel(
      {this.newPassword, this.confirmNewPassword, this.resetToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_password'] = this.newPassword;
    data['confirm_new_password'] = this.confirmNewPassword;
    data['reset_token'] = this.resetToken;
    return data;
  }
}
