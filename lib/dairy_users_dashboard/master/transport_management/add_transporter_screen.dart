import 'package:flutter/material.dart';
import 'package:mydairy/common/widgets/function.dart';

import '../../../export.dart';
import '../apis.dart';

class AddTransporterScreen extends ConsumerStatefulWidget {
  const AddTransporterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddTransporterScreenState();
}

class _AddTransporterScreenState extends ConsumerState<AddTransporterScreen> {
  TextEditingController transporter_name = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController father_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: "Add Transporter"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                RSizedBox(height: 15.h),
                TxtField(
                  controller: transporter_name,
                  hintText: "Transport Name",
                  fillColor: Colors.transparent,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter Transport Name";
                    }
                  },
                ),
                RSizedBox(height: 10.h),
                TxtField(
                  controller: name,
                  hintText: "Name",
                  fillColor: Colors.transparent,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter Name";
                    }
                  },
                ),
                RSizedBox(height: 10.h),
                TxtField(
                  controller: father_name,
                  hintText: "Father Name",
                  fillColor: Colors.transparent,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter Father Name";
                    }
                  },
                ),
                RSizedBox(height: 10.h),
                TxtField(
                  controller: email,
                  hintText: "Email-ID",
                  fillColor: Colors.transparent,
                ),
                RSizedBox(height: 10.h),
                TxtField(
                    controller: mobile,
                    hintText: "Mobile No.",
                    fillColor: Colors.transparent,
                    validator: validateMobile),
                RSizedBox(height: 30.h),
                buttonContainer(
                  loder: ref.watch(loadingProvider),
                  width: double.infinity,
                  txt: "Add Transporter",
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      ref.read(masterApiProvider).add_transporter({
                        "transporter_name": tt(transporter_name),
                        "name": tt(name),
                        "father_name": tt(father_name),
                        "mobile": tt(mobile),
                        "email": tt(email),
                        "country_code": "+91"
                      });
                    }

                    // controller.add_transporter();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
