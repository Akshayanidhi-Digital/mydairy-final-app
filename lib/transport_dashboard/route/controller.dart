import '../../export.dart';
import '../model/route_list_model.dart';

final route_lst_provider = FutureProvider.autoDispose((ref) async {
  return Routelst(ref).route_lst();
});

class Routelst {
  Ref ref;
  Routelst(this.ref);
  Future route_lst() async {
    final response =
        await ApiMethod(ref: ref).postDioRequest(Url.transport_routes_list);
    if (response.success == true) {
      ref.read(tr_route_lst_Provider.notifier).route_list(response.data);
      return response.data;
    }
  }
}

final tr_route_lst_Provider =
    StateNotifierProvider.autoDispose<RoutelstNotifier, List<RouteLstModel>>(
        (ref) {
  return RoutelstNotifier(ref);
});

class RoutelstNotifier extends StateNotifier<List<RouteLstModel>> {
  Ref ref;
  RoutelstNotifier(this.ref) : super([]);

  route_list(List data) {
    for (int i = 0; i < data.length; i++) {
      state.add(RouteLstModel.fromJson(data[i]));
    }
  }
}
