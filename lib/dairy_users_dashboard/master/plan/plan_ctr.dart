import '../../../export.dart';
import '../../model/plan_perchage_list.dart';

final plan_purchage_list_Provider =
    StateNotifierProvider<PlanCtr, List<PlanPurchageListModel>>((ref) {
  return PlanCtr(ref);
});

class PlanCtr extends StateNotifier<List<PlanPurchageListModel>> {
  Ref ref;
  PlanCtr(this.ref) : super([]);
  plan_purchage_add(List data) {
    for (int i = 0; i < data.length; i++) {
      state.add(PlanPurchageListModel.fromJson(data[i]));
    }
  }
}
