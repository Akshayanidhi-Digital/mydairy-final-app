import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

import '../controller.dart';

class AddProductBrandScreen extends ConsumerStatefulWidget {
  final bool edit;
  final dynamic data;
  const AddProductBrandScreen({super.key, this.edit = false, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddProductBrandScreenState();
}

class _AddProductBrandScreenState extends ConsumerState<AddProductBrandScreen> {
  TextEditingController nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    ref.read(productGroupApiProvider);
    if (widget.edit == true) {
      Future.delayed(
        Duration.zero,
        () {
          nameController.text = widget.data['brand'];
          ref.read(defalutProductGroupValueProvider.notifier).state =
              widget.data['group'];
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final valueList = ref.watch(defalutProductGroupValueProvider);
    final productListDropdown = ref.watch(productListProvider);
    return Scaffold(
      appBar: BaseAppBar(title: "Add Product Brand"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              CtmDropDown(
                onChanged: (value) => ref
                    .read(defalutProductGroupValueProvider.notifier)
                    .state = value!,
                hintTxt: "Name",
                inisialvalue: valueList == '' ? null : valueList,
                lst: productListDropdown == null || productListDropdown.isEmpty
                    ? []
                    : productListDropdown
                        .map((item) => DropdownMenuItem<String>(
                              value: item['id'].toString(),
                              child: Text(
                                item['group'],
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ))
                        .toList(),
              ),
              RSizedBox(height: 10.0.w),
              TxtField(
                controller: nameController,
                hintText: "Name",
                validator: (value) {
                  if (value == '') {
                    return "Name field is required";
                  }
                },
              ),
              RSizedBox(height: 20.0.w),
              buttonContainer(
                  loder: ref.watch(loadingProvider),
                  onTap: () {
                    if (formkey.currentState!.validate() == true) {
                      if (widget.edit == true) {
                        ref.read(productApiProvider).productBrand_edit({
                          'id': widget.data['id'],
                          "group": valueList.toString(),
                          'brand_name': nameController.text.trim(),
                        });
                      } else {
                        ref.read(productApiProvider).productBrandAdd(
                            brandName: nameController.text.trim(),
                            id: valueList);
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
