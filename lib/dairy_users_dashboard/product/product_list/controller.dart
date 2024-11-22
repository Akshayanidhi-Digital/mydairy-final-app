import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';

final addcheckBoxProvider = StateProvider.autoDispose<bool>((ref) => false);
final addcheckBox2Provider = StateProvider.autoDispose<bool>((ref) => false);

final addProductTxtfieldListProvider =
    FutureProvider.autoDispose<List>((ref) => addProductTxtfield);
final productListApiProvider =
    FutureProvider.autoDispose((ref) => AddProductApi(ref).productList());

final addProductProvider =
    Provider.autoDispose<AddProductApi>((ref) => AddProductApi(ref));

class AddProductApi {
  final Ref ref;
  const AddProductApi(this.ref);

  Future productList() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.productList);
    if (response.success == true) {
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future addProduct(
      {name,
      groupValue,
      brandValue,
      unitType,
      price,
      istex,
      tax,
      isweight,
      weight,
      image,
      stock,
      description}) async {
    FormData data = FormData.fromMap({
      'image': image,
      'name': name,
      'group': groupValue,
      'brand': brandValue,
      'unit_type': unitType,
      'price': price,
      'is_tax': istex,
      'tax': tax,
      'is_weight': isweight,
      'weight': weight,
      'stock': stock,
      'desciption': description
    });
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.productAdd, data: data);

    if (response.success == true) {
      navigationPop();
      successMsg(response);
      return response;
    } else {
      return errorSnacMsg(response);
    }
  }
}

List addProductTxtfield = [
  {
    "labelText": "Price",
    "hintText": "Price",
    "minLines": 1,
    "validator": validateAddProductFields,
    'keyboard': TextInputType.number
  },
  {
    "labelText": "Stoke Quality",
    "hintText": "Stoke Quality",
    "minLines": 1,
    "validator": validateAddProductFields,
    'keyboard': TextInputType.number
  },
  {
    "labelText": "Description",
    "hintText": "Description",
    "minLines": 2,
    "validator": validateAddProductFields,
    'keyboard': TextInputType.text
  },
];

validateAddProductFields({String? value, index}) {
  if (value == null || value.isEmpty) {
    return 'Please enter a ${addProductTxtfield[index]['labelText']}';
  } else if (addProductTxtfield[index]['labelText'] == 'Description'
      ? value.length < 100
      : value.length < 1) {
    // return 'Please enter a ${addProductTxtfield[index]['labelText']}';
    return 'Please enter 100 text';
  }
  print("______$value");
  return null;
}

Widget addProductContainer(
    {required Widget txt1,
    required String txt2,
    required bool value,
    required void Function(bool? value)? onChanged}) {
  return Container(
    height: 45.h,
    decoration: BoxDecoration(border: Border.all()),
    child: Row(
      children: [
        Expanded(
          child: txt1,
        ),
        Expanded(
          child: Row(
            children: [
              Checkbox(
                  activeColor: AppColor.appColor,
                  value: value,
                  onChanged: onChanged),
              Text(txt2),
            ],
          ),
        )
      ],
    ),
  );
}
