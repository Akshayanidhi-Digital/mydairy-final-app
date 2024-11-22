import 'package:mydairy/export.dart';

import '../../model/cart_item_model.dart';
import 'cart_controller.dart';

final shoping_apis_Provider =
    Provider.autoDispose<ShopingApi>((ref) => ShopingApi(ref));

class ShopingApi {
  Ref ref;
  ShopingApi(this.ref);

  Future shopingList() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.shopingList);
    if (response.success == true) {
      return response.data;
    }
  }

  Future cart_add(Map data) async {
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.cart_add, data: data);
    if (response.success == true) {
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future cart_list() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.cart_list);
    if (response.success == true) {
      ref.read(cart_item_Provider.notifier).cart_add(response.data);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future cart_item_delete(int id) async {
    Map data = {"cart": id};
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.cart_remove, data: data);
    if (response.success == true) {
      ref.read(cart_item_Provider.notifier).cart_remove(id);
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future cart_update(Map data, select) async {
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.cart_update, data: data);
    if (response.success == true) {
      CartItemModel item = CartItemModel.fromJson(response.data);
      ref.read(cart_item_Provider.notifier).cart_update(CartItemModel(
          id: item.id,
          image: item.image,
          price: item.price,
          quantity: item.quantity,
          discount: item.discount,
          name: item.name,
          select: select,
          total: item.total,
          tax: item.tax,
          userId: item.userId,
          weight: item.weight,
          createdAt: item.createdAt,
          productId: item.productId,
          sellerId: item.sellerId,
          unitType: item.unitType,
          updatedAt: item.updatedAt));
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}

final tabChangeProvider = StateNotifierProvider.autoDispose<TabNotifier, int>(
    (ref) => TabNotifier(ref));

class TabNotifier extends StateNotifier<int> {
  Ref ref;
  TabNotifier(this.ref) : super(0);
  onchange(value) {
    state = value;
  }
}
