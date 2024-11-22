import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';

import '../../authentication/check_user.dart';
import '../../driver_dashboard/profile/controller.dart';
import '../../export.dart';
import 'controller.dart';

class PasswordUpdateScreen extends ConsumerStatefulWidget {
  const PasswordUpdateScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PasswordUpdateScreenState();
}

class _PasswordUpdateScreenState extends ConsumerState<PasswordUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final old_pw_ctr = TextEditingController();
  final new_pw_ctr = TextEditingController();
  final confierm_pw_ctr = TextEditingController();
  @override
  void dispose() {
    old_pw_ctr.clear();
    new_pw_ctr.clear();
    confierm_pw_ctr.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: "Password Update"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RSizedBox(height: 20.h),
                Text("Old Password", style: TextStyle(fontSize: 16.sp)),
                TxtField(
                  borderRadius: BorderRadius.circular(50),
                  controller: old_pw_ctr,
                  hintText: "Old Password",
                  fillColor: Colors.transparent,
                ),
                RSizedBox(height: 10.h),
                Text("New Password", style: TextStyle(fontSize: 16.sp)),
                TxtField(
                  borderRadius: BorderRadius.circular(50),
                  controller: new_pw_ctr,
                  hintText: "New Password",
                  fillColor: Colors.transparent,
                ),
                RSizedBox(height: 10.h),
                Text("Confirm Password", style: TextStyle(fontSize: 16.sp)),
                TxtField(
                  borderRadius: BorderRadius.circular(50.r),
                  controller: confierm_pw_ctr,
                  hintText: "Confirm Password",
                  fillColor: Colors.transparent,
                ),
                RSizedBox(height: 30.h),
                buttonContainer(
                    loder: ref.watch(loadingProvider),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (new_pw_ctr.text == confierm_pw_ctr.text) {
                          final _isdriver = ref.watch(driver_login_provider);
                          Map profile = {
                            "password": tt(old_pw_ctr),
                            "new_password": tt(new_pw_ctr),
                            "confirm_new_password": tt(confierm_pw_ctr)
                          };
                          if (_isdriver) {
                            ref
                                .read(dr_profile_api_Provider)
                                .dr_password_update(profile);
                          } else {
                            ref
                                .read(tp_profile_api_Provider)
                                .tr_password_update(profile);
                          }
                        } else {
                          snackBarMessage(msg: "Password do not match");
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(50.r),
                    width: double.infinity,
                    txt: "Update")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
