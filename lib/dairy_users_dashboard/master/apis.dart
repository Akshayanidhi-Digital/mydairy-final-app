import '../../export.dart';
import '../model/plan_membership_model.dart';
import '../model/routes_list_model.dart';
import '../model/transportlist_model.dart';
import 'controller.dart';
import 'plan/plan_ctr.dart';

final plandataProvider =
    StateProvider.autoDispose<List<MemberShipModel>>((ref) => []);

final masterApiProvider = Provider.autoDispose<MasterApi>((ref) {
  return MasterApi(ref);
});

class MasterApi {
  Ref ref;
  MasterApi(this.ref);
  Future memberShipPlans() async {
    final response =
        await ApiMethod(ref: ref).postDioRequest(Url.memberShipPlans);
    if (response.success == true) {
      for (var i = 0; i < response.data.length; i++) {
        ref
            .read(plandataProvider.notifier)
            .state
            .add(MemberShipModel.fromJson(response.data[i]));
      }
      return response.data;
    } else if (response.success == false) {
      errorSnacMsg(response);
    }
  }

  Future plan_purchase_Api() async {
    final response =
        await ApiMethod(ref: ref).postDioRequest(Url.plan_puchess_list);
    if (response.success == true) {
      ref
          .read(plan_purchage_list_Provider.notifier)
          .plan_purchage_add(response.data);
      return response.data;
    } else if (response.success == false) {
      errorSnacMsg(response);
    }
  }

  Future transportListApi() async {
    final response =
        await ApiMethod(ref: ref).postDioRequest(Url.transportList);
    if (response.success == true) {
      for (int i = 0; i < response.data.length; i++) {
        ref
            .read(transportListProvider.notifier)
            .state
            .add(TranportListModel.fromJson(response.data[i]));
      }
      return ref.read(transportListProvider.notifier).state;
    } else if (response.success == false) {
      errorSnacMsg(response);
    }
  }

  Future routesListApi() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.routesList);
    if (response.success == true) {
      for (int i = 0; i < response.data.length; i++) {
        ref
            .read(routesListProvider.notifier)
            .state
            .add(RouteListModel.fromJson(response.data[i]));
      }
      return ref.read(routesListProvider.notifier).state;
    } else if (response.success == false) {
      errorSnacMsg(response);
    }
  }

  Future add_routesApi(Map data) async {
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.add_routes, data: data);
    if (response.success == true) {
      ref.refresh(routesListApiProvider);
      successMsg(response);
      navigationPop();
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future edit_routesApi(Map data) async {
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.edit_routes, data: data);
    if (response.success == true) {
      ref.refresh(routesListApiProvider);
      successMsg(response);
      navigationPop();
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future planPurchase(String id) async {
    Map data = {"plan_id": id};
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.planPurchase, data: data);
    if (response.success == true) {
      successMsg(response);
      navigationPop();
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future transportStatus(String id) async {
    Map data = {"transporter_id": id};
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_status, data: data);
    if (response.success == true) {
      ref.read(transportListProvider.notifier).updateTransportList(id);
      successMsg(response);
      // navigationPop();
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future add_transporter(Map data) async {
    // Map data = {"transporter_id": id};
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.add_transporter, data: data);
    if (response.success == true) {
      successMsg(response);
      return response.data;
    }
  }

  Future dairy_listApi() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.dairy_list);
    if (response.success == true) {
      ref.read(subDairyProvider.notifier).addRoutes(response.data);

      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}
