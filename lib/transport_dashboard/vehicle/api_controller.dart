import 'package:mydairy/transport_dashboard/vehicle/controller.dart';

import '../../export.dart';

final driver_list_value_Provider = StateProvider.autoDispose<List>((ref) {
  return [];
});
final driver_list_values_Provider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final page_no_Provider = StateProvider.autoDispose<int>((ref) {
  return 1;
});
final vahicle_api_list_Provider = FutureProvider.autoDispose((ref) async {
  final page = ref.watch(page_no_Provider);
  return VehicleController(ref).vehical_list(page);
});

final vehical_api_provider = Provider.autoDispose<VehicleController>((ref) {
  return VehicleController(ref);
});

class VehicleController {
  Ref ref;
  VehicleController(this.ref);

  Future vehical_list(int page) async {
    final response = await ApiMethod(ref: ref)
        .postDioRequest("${Url.transport_vehicle_list}?page=$page");
    if (response.success == true) {
      if (response.data.isEmpty) {
        // data_fetch_provider = true;
      } else {
        print("res :::::::: ${response.data}");
        ref.read(vehicle_list_provider.notifier).vehicle_list(response.data);
        return response.data;
      }
    } else {
      errorSnacMsg(response);
    }
  }

  Future vehical_driver_list() async {
    final response = await ApiMethod(ref: ref)
        .postDioRequest(Url.transport_vehical_driver_list);
    if (response.success == true) {
      ref.read(driver_list_value_Provider.notifier).state = response.data;
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future vehical_add(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_vehicle_add, data: data);
    if (response.success == true) {
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future vehical_status_update(int id) async {
    Map data = {"vehicle": id};
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_vehicle_status_update, data: data);
    if (response.success == true) {
      ref.read(vehicle_list_provider.notifier).vehical_status_update(id);
      navigationPop();
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}
