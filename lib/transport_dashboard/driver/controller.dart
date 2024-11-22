import '../../export.dart';
import '../model/driver_list_model.dart';

bool data_fetch_provider = false;

final driver_list_Provider =
    FutureProvider.autoDispose.family((ref, page) async {
  return DriverController(ref).driver_list(page: page);
});

final driver_controller =
    Provider.autoDispose<DriverController>((ref) => DriverController(ref));

class DriverController {
  Ref ref;
  DriverController(this.ref);

  Future driver_list({page}) async {
    final response = await ApiMethod(ref: ref)
        .postDioRequest("${Url.transport_driver_list}?page=$page");
    if (response.success == true) {
      if (response.data.isEmpty) {
        data_fetch_provider = true;
      } else {
        print("res :::::::: ${response.data}");
        ref
            .read(driver_list_fetch_provider.notifier)
            .driver_list(response.data);
        return response.data;
      }
    } else {
      errorSnacMsg(response);
    }
  }

  Future driver_add({data}) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_driver_add, data: data);
    if (response.success == true) {
      final mydata = DriverListModel.fromJson(response.data);
      ref.read(driver_list_fetch_provider.notifier).driver_add(mydata);
      successMsg(response);
      navigationPop();
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future transport_driver_update({data}) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_driver_update, data: data);
    if (response.success == true) {
      DriverListModel datas = DriverListModel.fromJson(response.data);
      ref.read(driver_list_fetch_provider.notifier).driver_update(datas);
      successMsg(response);

      navigationPop();
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future transport_driver_status_update(id) async {
    Map data = {"driver_id": id};
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_driver_status_update, data: data);
    if (response.success == true) {
      ref
          .read(driver_list_fetch_provider.notifier)
          .transport_driver_status_update(id);
      navigationPop();
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}

final driver_list_fetch_provider = StateNotifierProvider.autoDispose<
    DriverListNotifier, List<DriverListModel>>((ref) {
  return DriverListNotifier(ref);
});

class DriverListNotifier extends StateNotifier<List<DriverListModel>> {
  Ref ref;
  DriverListNotifier(this.ref) : super([]);
  driver_list(List data) {
    for (int i = 0; i < data.length; i++) {
      state.add(DriverListModel.fromJson(data[i]));
    }
  }

  driver_add(DriverListModel data) {
    state = [data, ...state];
  }

  driver_update(DriverListModel data) {
    state = state.map((e) => e.id == data.id ? data : e).toList();
  }

  transport_driver_status_update(id) {
    //  state = state.map((e) => e.driverId == id ? e..isBlocked = e.isBlocked == 1 ? 0 : 1 : e).toList();
    state = state.map((e) {
      if (e.driverId == id) {
        e.isBlocked = e.isBlocked == 1 ? 0 : 1;
      }
      return e;
    }).toList();
  }

  @override
  void dispose() {
    state = [];
    // TODO: implement dispose
    super.dispose();
  }
}
