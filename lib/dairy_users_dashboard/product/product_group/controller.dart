import '../../../export.dart';

final product_group_state_Provider =
    StateNotifierProvider.autoDispose<ProductGroupNotifier, List>((ref) {
  return ProductGroupNotifier(ref);
});

class ProductGroupNotifier extends StateNotifier<List> {
  final Ref ref;
  ProductGroupNotifier(this.ref) : super([]);
  product_group_add(data) {
    for (int i = 0; i < data.length; i++) {
      state.add(data[i]);
    }
  }

  product_group_status_update(id) {
    state = state.map((e) {
      if (e['id'] == id) {
        e['trash'] = e['trash'] == 0 ? 1 : 0;
      }
      return e;
    }).toList();
  }

  produt_group_add_data(data) {
    state = [state, ...data];
  }

  produt_group_edit(data) {
    state = state.map((e) => e['id'] == data['id'] ? data : e).toList();
  }
}
