import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mydairy/common/widgets/button.dart';

import '../../../authentication/log_in_screen.dart';
import '../../../common/widgets/appbar.dart';
import '../../../common/widgets/form_field.dart';
import '../controller.dart';

class AddProductGroupScreen extends ConsumerStatefulWidget {
  final bool edit;
  final dynamic data;
  const AddProductGroupScreen({super.key, this.edit = false, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddProductGroupScreenState();
}

class _AddProductGroupScreenState extends ConsumerState<AddProductGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    groupNameController.clear();
    super.dispose();
  }

  @override
  void initState() {
    print("data :::  ${widget.data}");
    if (widget.edit == true) {
      groupNameController.text = widget.data['group'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Add Product Group",
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              RSizedBox(height: 10.0.w),
              TxtField(
                  controller: groupNameController,
                  hintText: "Name",
                  validator: (value) {
                    if (value == '') {
                      return "Name field is required";
                    }
                  }),
              RSizedBox(height: 20.0.w),
              buttonContainer(
                  loder: ref.watch(loadingProvider),
                  onTap: () {
                    if (formkey.currentState!.validate() == true) {
                      if (widget.edit == true) {
                        ref.read(productApiProvider).productgroup_edit({
                          "id": widget.data['id'],
                          "group_name": widget.data['group']
                        });
                      } else {
                        ref.read(productApiProvider).productAdd(
                            groupName: groupNameController.text.trim());
                      }
                    }
                  },
                  width: double.infinity,
                  txt: "Submit")
            ],
          ),
        ),
      ),
    );
  }
}
