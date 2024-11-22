import 'package:mydairy/transport_dashboard/model/vehicle_list_model.dart';

import '../../export.dart';

final unit_type_lst_Provider = StateProvider.autoDispose<List>((ref) {
  return [
    {"name": "Litres", "value": "Litres"},
    {"name": "Kilograms", "value": "Kilograms"},
    {"name": "Tons", "value": "Tons"},
  ];
});
final unit_type_value_Provider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final vehicle_list_provider =
    StateNotifierProvider.autoDispose<VehicleNotifier, List<VehicleListModel>>(
        (ref) {
  return VehicleNotifier(ref);
});

class VehicleNotifier extends StateNotifier<List<VehicleListModel>> {
  Ref ref;
  VehicleNotifier(this.ref) : super([]);

  vehicle_list(List data) {
    for (int i = 0; i < data.length; i++) {
      state.add(VehicleListModel.fromJson(data[i]));
    }
  }

  vehical_status_update(int id) {
    state = state.map((e) {
      if (e.id == id) {
        e.isActive = e.isActive == 0 ? 1 : 0;
      }
      return e;
    }).toList();
  }
}
