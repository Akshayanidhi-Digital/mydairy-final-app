// ignore_for_file: unused_result

import 'package:mydairy/export.dart';

import 'product_brand/controller.dart';
import 'product_group/controller.dart';

final defalutProductGroupValueProvider =
    StateProvider.autoDispose<String>((ref) => '');
final productListProvider = StateProvider.autoDispose<List?>((ref) => null);
final defalutProductBrandValueProvider =
    StateProvider.autoDispose<String>((ref) => '');
final productBrandListProvider = StateProvider.autoDispose<List>((ref) => []);
final selectUnitValueProvider = StateProvider.autoDispose<String>((ref) => '');
final unitTypeListProvider = StateProvider.autoDispose<List>((ref) => []);

final productGroupApiProvider = FutureProvider.autoDispose(
    (ref) async => ProductApi(ref: ref).productGroupList());
final productBrandApiProvider = FutureProvider.autoDispose
    .family((ref, group) async => ProductApi(ref: ref).productBrandList());
final productBrandListApiProvider = FutureProvider.autoDispose(
    (ref) async => ProductApi(ref: ref).productBrandList());
final productItemApiProvider = FutureProvider.autoDispose(
    (ref) async => ProductApi(ref: ref).productItem());
final unitTyeApiProvider = FutureProvider.autoDispose(
    (ref) async => ProductApi(ref: ref).unitTypeList());

final productApiProvider =
    Provider.autoDispose<ProductApi>((ref) => ProductApi(ref: ref));

class ProductApi {
  Ref ref;
  ProductApi({required this.ref});

  productAdd({required String groupName}) async {
    Map data = {"group_name": groupName};
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.productGroupAdd, data: data);
    if (response.success == true) {
      ref
          .read(product_group_state_Provider.notifier)
          .produt_group_add_data(response.data);
      navigationPop();
      successMsg(response);

      return response;
    } else if (response.success == false) {
      return errorSnacMsg(response);
    }
  }

  productBrandAdd({required String brandName, required String id}) async {
    Map data = {"brand_name": brandName, "group": id};
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.productBrandAdd, data: data);

    if (response.success == true) {
      ref
          .read(product_brand_state_Provider.notifier)
          .produt_brand_add_data(response.data);
      navigationPop();
      successMsg(response);
      return response;
    } else {
      return errorSnacMsg(response);
    }
  }

  productGroupList() async {
    final response =
        await ApiMethod(ref: ref).postDioRequest(Url.productGroupList);
    if (response.success == true) {
      ref
          .read(product_group_state_Provider.notifier)
          .product_group_add(response.data);
      ref.read(productListProvider.notifier).state = response.data;

      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  productItem() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.productItem);
    if (response.success == true) {
      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  productBrandList({group}) async {
    Map data = {"group": group};
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.productBrandList, data: data);
    if (response.success == true) {
      ref.read(productBrandListProvider.notifier).state = response.data;
      ref
          .read(product_brand_state_Provider.notifier)
          .product_brand_add(response.data);

      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  productBrand_edit(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.productBrand_edit, data: data);
    if (response.success == true) {
      ref
          .read(product_brand_state_Provider.notifier)
          .produt_brand_edit(response.data);
      // ref.refresh(productBrandListApiProvider);
      navigationPop();
      successMsg(response);
      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  productgroup_edit(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.productgroup_edit, data: data);
    if (response.success == true) {
      ref
          .read(product_group_state_Provider.notifier)
          .produt_group_edit(response.data);
      navigationPop();
      successMsg(response);

      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  productBrand_update(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.product_brand_update, data: data);
    if (response.success == true) {
      ref
          .read(product_brand_state_Provider.notifier)
          .product_brand_status_update(data['id']);
      successMsg(response);
      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  product_group_update(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.product_group_update, data: data);
    if (response.success == true) {
      ref
          .read(product_group_state_Provider.notifier)
          .product_group_status_update(data['id']);
      // ref.refresh(productGroupApiProvider);
      successMsg(response);
      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  Future unitTypeList() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.unitTypeList);

    if (response.success == true) {
      ref.read(unitTypeListProvider.notifier).state = response.data;
      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }
}
