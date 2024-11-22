import '../../../export.dart';
import '../../model/help_model.dart';
import 'role_apis.dart';

final helpdataProvider =
    StateProvider.autoDispose<List<HelpModel>>((ref) => []);

final rulesGetProvider = FutureProvider.autoDispose((ref) async {
  final response = await ref.watch(rulesApiProvider).rulesGetApi();
  return response;
});
final rulesViewGetProvider = FutureProvider.autoDispose.family((ref, id) async {
  final response = await ref.watch(rulesApiProvider).roleViewGetApi(id);
  return response;
});
final helpApiGetProvider = FutureProvider.autoDispose((ref) async {
  final response = await ref.watch(rulesApiProvider).helpApi();
  return response;
});

