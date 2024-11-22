import '../../../export.dart';

final product_brand_state_Provider =
    StateNotifierProvider.autoDispose<ProductbrandNotifier, List>((ref) {
  return ProductbrandNotifier(ref);
});

class ProductbrandNotifier extends StateNotifier<List> {
  final Ref ref;
  ProductbrandNotifier(this.ref) : super([]);
  product_brand_add(data) {
    for (int i = 0; i < data.length; i++) {
      state.add(data[i]);
    }
  }

  product_brand_status_update(id) {
    state = state.map((e) {
      if (e['id'] == id) {
        e['trash'] = e['trash'] == 0 ? 1 : 0;
      }
      return e;
    }).toList();
  }

  produt_brand_add_data(data) {
    state = [state, ...data];
  }

  produt_brand_edit(data) {
    state = state.map((e) {
      if (e['id'] == data['id']) {
        e = data;
      }
    }).toList();
  }
}
