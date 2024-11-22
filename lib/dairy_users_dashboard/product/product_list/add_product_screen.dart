import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import '../controller.dart';
import 'controller.dart';

List addProducttextFieldsList = [];

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<TextEditingController> controllers = [];
  TextEditingController nameContoller = TextEditingController();
  TextEditingController weightContoller = TextEditingController();
  TextEditingController taxContoller = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(productGroupApiProvider);

    ref.read(unitTyeApiProvider);

    textFieldUpdate();
  }

  textFieldUpdate() {
    ref.read(addProductTxtfieldListProvider).whenData((value) {
      addProducttextFieldsList = value;
    });
    // Initialize controllers
    for (int i = 0; i < addProducttextFieldsList.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    nameContoller.clear();
    weightContoller.clear();
    taxContoller.clear();

    controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uploadFile = ref.watch(imageNameProvider);
    final images = ref.watch(imageProvider);
    final addValue = ref.watch(addcheckBoxProvider);
    final taxValue = ref.watch(addcheckBox2Provider);
    final valueList = ref.watch(defalutProductGroupValueProvider);
    final productListDropdown = ref.watch(productListProvider);
    final valueBrand = ref.watch(defalutProductBrandValueProvider);
    final productBrandDropdown = ref.watch(productBrandListProvider);
    final unitTypeValue = ref.watch(selectUnitValueProvider);
    final unitTypeList = ref.watch(unitTypeListProvider);

    return Scaffold(
        appBar: BaseAppBar(
          title: "Add Product",
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                    key: formKey,
                    child: Column(children: [
                      CtmDropDown(
                        onChanged: (value) {
                          ref
                              .read(defalutProductBrandValueProvider.notifier)
                              .state = '';
                          ref.read(productBrandListProvider.notifier).state =
                              [];
                          // ref.read(productApiProvider).productBrandList(group: value);

                          ref
                              .read(defalutProductGroupValueProvider.notifier)
                              .state = value!;
                          Future(() =>
                              ref.read(productBrandApiProvider.call(value)));
                        },
                        hintTxt: "Select Group",
                        inisialvalue: valueList == '' ? null : valueList,
                        lst: productListDropdown == null
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
                      CtmDropDown(
                        onChanged: (value) => ref
                            .read(defalutProductBrandValueProvider.notifier)
                            .state = value!,
                        hintTxt: "Select Brand",
                        inisialvalue: valueBrand == '' ? null : valueBrand,
                        lst: productBrandDropdown == null
                            ? []
                            : productBrandDropdown
                                .map((item) => DropdownMenuItem<String>(
                                      value: item['id'].toString(),
                                      child: Text(
                                        item['brand'],
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ))
                                .toList(),
                      ),
                      RSizedBox(height: 10.0.w),
                      CtmDropDown(
                        onChanged: (value) => ref
                            .read(selectUnitValueProvider.notifier)
                            .state = value!,
                        hintTxt: "Select Unit",
                        inisialvalue:
                            unitTypeValue == '' ? null : unitTypeValue,
                        lst: unitTypeList == null
                            ? []
                            : unitTypeList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item['id'].toString(),
                                      child: Text(
                                        item['name'],
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ))
                                .toList(),
                      ),
                      RSizedBox(height: 10.0.w),
                      TxtField(
                          controller: nameContoller,
                          hintText: "Name",
                          labelText: "Name"),
                      addProductContainer(
                          txt1: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: weightContoller,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: AppColor.blackClr,
                                          fontWeight: FontWeight.normal),
                                      hintText: "Weight",
                                      border: InputBorder.none))),
                          txt2: "Add",
                          value: addValue,
                          onChanged: (value) => ref
                              .read(addcheckBoxProvider.notifier)
                              .state = value!),
                      RSizedBox(height: 10.0.w),
                      addProductContainer(
                        txt1: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                                controller: taxContoller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 16.0,
                                        color: AppColor.blackClr,
                                        fontWeight: FontWeight.normal),
                                    hintText: "Tax(%)",
                                    border: InputBorder.none))),
                        txt2: "Including Tax",
                        value: taxValue,
                        onChanged: (value) => ref
                            .read(addcheckBox2Provider.notifier)
                            .state = value!,
                      ),
                      RSizedBox(height: 10.0.w),
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: addProducttextFieldsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TxtField(
                                controller: controllers[index],
                                labelText: addProducttextFieldsList[index]
                                    ['labelText'],
                                hintText: addProducttextFieldsList[index]
                                    ['hintText'],
                                keyboardType: addProducttextFieldsList[index]
                                    ['keyboard'],
                                maxLines: addProducttextFieldsList[index]
                                    ['minLines'],
                                // border: true,

                                validator: (String? value) =>
                                    validateAddProductFields(
                                        value: value, index: index));
                          }),
                      TxtField(
                        readOnly: true,
                        onTap: () {
                          ref.read(imageUploaderProvider);
                        },
                        hintText: uploadFile == ""
                            ? "Please Upload Image File"
                            : uploadFile.toString().split('/').last,
                        borderRadius: BorderRadius.circular(5),
                        suffixIcon: Image(
                            image: const AssetImage(Img.file_upload),
                            color: AppColor.blackClr,
                            width: 20.w),
                      ),
                      RSizedBox(height: 30.h),
                      buttonContainer(
                          loder: ref.watch(loadingProvider),
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              if (uploadFile == '') {
                                return snackBarMessage(
                                    msg: "Please Upload image");
                              } else {
                                return ref.read(addProductProvider).addProduct(
                                      groupValue: valueList,
                                      brandValue: valueBrand,
                                      unitType: unitTypeValue,
                                      name: nameContoller.text.trim(),
                                      weight: weightContoller.text.trim(),
                                      tax: taxContoller.text.trim(),
                                      price: controllers[0].text.trim(),
                                      stock: controllers[1].text.trim(),
                                      description: controllers[2].text.trim(),
                                      isweight: addValue == true ? "1" : 0,
                                      istex: taxValue == true ? "1" : 0,
                                      image: ref
                                                  .read(imageProvider.notifier)
                                                  .state ==
                                              null
                                          ? ""
                                          : await MultipartFile.fromFile(
                                              images!.path,
                                              filename: ref
                                                  .read(imageNameProvider
                                                      .notifier)
                                                  .state),
                                    );
                              }
                            }
                          },
                          txt: "Submit",
                          width: double.infinity),
                      RSizedBox(height: 30.h)
                    ])))));
  }
}
