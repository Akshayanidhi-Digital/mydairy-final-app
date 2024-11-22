// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mydairy/dairy_users_dashboard/master/routes/route_ctr.dart';

import '../../common/widgets/function.dart';
import '../../export.dart';
import '../model/routes_list_model.dart';
import '../model/transportlist_model.dart';
import 'apis.dart';
import 'routes/add_routes_screen.dart';

final plansApiProvider = FutureProvider.autoDispose((ref) async {
  final response = await ref.watch(masterApiProvider).memberShipPlans();
  return response;
});

final transportListApiProvider = FutureProvider.autoDispose((ref) async {
  final response = await ref.watch(masterApiProvider).transportListApi();
  return response;
});
final routesListApiProvider = FutureProvider.autoDispose((ref) async {
  final response = await ref.watch(masterApiProvider).routesListApi();
  return response;
});
final planPurchageListApiProvider = FutureProvider.autoDispose((ref) async {
  final response = await ref.watch(masterApiProvider).plan_purchase_Api();
  return response;
});

final routesListProvider =
    StateProvider.autoDispose<List<RouteListModel>>((ref) {
  return [];
});

final transportListProvider = StateNotifierProvider.autoDispose<
    TransportListNotifier,
    List<TranportListModel>>((ref) => TransportListNotifier(ref));

class TransportListNotifier extends StateNotifier<List<TranportListModel>> {
  Ref ref;
  TransportListNotifier(this.ref) : super([]);
  updateTransportList(String id) {
    state = state.where((e) {
      if (e.transporterId == id) {
        e.isBlocked = e.isBlocked == 0 ? 1 : 0;
      }
      return true;
    }).toList();
  }
}

final subDairyProvider =
    StateNotifierProvider.autoDispose<SubDairyNotifier, List<RoutesAddModel>>(
        (ref) => SubDairyNotifier(ref));

class SubDairyNotifier extends StateNotifier<List<RoutesAddModel>> {
  final Ref ref;
  SubDairyNotifier(this.ref) : super([]);

  Future initData(RouteListModel data, {TextEditingController? name}) async {
    await Future.delayed(const Duration(seconds: 0), () async {
      if (data != null) {
        name!.text = data.routeName.toString();
        ref.read(trValueProvider.notifier).state =
            data.transporterId.toString();

        for (var i = 0; i < data.dairies!.length; i++) {
          print(
              "item ${data.dairies![i].id}     ${data.dairies![i].dairyId}    ${data.dairies![i].routeId} ");
          print("state length ${state.length}");
          state.where((e) {
            if (e.userId == data.dairies![i].dairyId) {
              e.select = true;
              print(" elsement user id  ${e.userId}");
              ref.read(routeValueProvider.notifier).route_value_add(
                  RoutesAddModel(
                      name: e.name,
                      roleName: e.roleName,
                      select: true,
                      userId: e.userId));
            }
            return true;
          }).toList();
        }
      }
    });
  }

  List<RoutesAddModel> addRoutes(List data) {
    List<RoutesAddModel> datas = [];
    for (int i = 0; i < data.length; i++) {
      datas.add(RoutesAddModel.fromJson(data[i]));
      datas[i].select = false;
      state.add(datas[i]);
    }

    return datas;
  }

  sub_dairy_length() => state.where((element) => element.select == true).length;

  List<RoutesAddModel> lstshow() {
    List<RoutesAddModel> list =
        state.where((element) => element.select == false).toList();
    return list;
  }

  List<RoutesAddModel> onchange_list(value) {
    final lst = state.where((e) {
      if (e.userId == value) {
        e.select = true;
        final route_data = RoutesAddModel(
            name: e.name, roleName: e.roleName, select: true, userId: e.userId);
        ref.read(routeValueProvider.notifier).route_value_add(route_data);
      }
      return true;
    }).toList();

    // routeValue!.insert(routeValue.length - 1, lst[0]);
    return lst;
  }

  List<RoutesAddModel> remove_route() {
    List<RoutesAddModel> list = state.where((e) => e.select == true).toList();
    print("length :::: ${list.length}");

    if (list.isNotEmpty) {
      list.last.select = false;
      ref.read(routeValueProvider.notifier).route_remove();
    }
    return list;
  }

  add_Route(bool edit,
      {required List<RoutesAddModel?> routeValue,
      required String typeValue,
      String? route_id,
      required TextEditingController ctr}) async {
    final list =
        routeValue.where((element) => element!.userId != null).toList();
    final dairyList = list.map((e) => e!.userId).toList();
    if (edit == true) {
      await ref.read(masterApiProvider).edit_routesApi({
        "route_id": route_id,
        "transporter_id": typeValue,
        "route_name": tt(ctr),
        "dairy_list": dairyList,
      });
    } else {
      await ref.read(masterApiProvider).add_routesApi({
        "transporter_id": typeValue,
        "route_name": tt(ctr),
        "dairy_list": dairyList
      });
    }
  }

  // update_Route_List(String id) {
  //   state = state.where((e) {
  //     // if (e.transporterId == id) {
  //     //   if (e.isBlocked == 0) {
  //     //     e.isBlocked = 1;
  //     //   } else {
  //     //     e.isBlocked = 0;
  //     //   }
  //     // }
  //     return true;
  //   }).toList();
  // }

  @override
  void dispose() {
    state = [];
    super.dispose();
  }
}

class RoutesAddModel {
  String? userId;
  String? name;
  String? roleName;
  bool? select;

  RoutesAddModel({this.userId, this.name, this.roleName, this.select});

  RoutesAddModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    roleName = json['role_name'];
    select = json['select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['role_name'] = this.roleName;
    data['select'] = this.select;
    return data;
  }
}
