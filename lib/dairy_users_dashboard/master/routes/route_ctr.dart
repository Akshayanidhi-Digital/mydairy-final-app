import '../../../export.dart';
import '../controller.dart';

final routeValueProvider =
    StateNotifierProvider.autoDispose<RouteLstNotifier, List<RoutesAddModel?>>(
        (ref) => RouteLstNotifier(ref));

class RouteLstNotifier extends StateNotifier<List<RoutesAddModel?>> {
  Ref ref;
  RouteLstNotifier(this.ref) : super([]);
  route_value_add(RoutesAddModel data) {
    state.insert(state.length - 1, data);
  }

  route_remove() {
    state.removeAt(state.length - 2);
  }
}
