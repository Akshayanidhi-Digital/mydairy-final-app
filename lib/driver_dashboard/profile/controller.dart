import '../../export.dart';
import '../../transport_dashboard/profile/controller.dart';
import '../model/profile_model.dart';

final dr_profile_Provider =
    StateProvider.autoDispose<DriverProfileModel>((ref) {
  return DriverProfileModel.fromJson({});
});

final dr_api_Provider = FutureProvider.autoDispose((ref) async {
  return DriverProfileApi(ref).dr_profile();
});
final dr_profile_api_Provider = Provider.autoDispose<DriverProfileApi>((ref) {
  return DriverProfileApi(ref);
});

class DriverProfileApi {
  Ref ref;
  DriverProfileApi(this.ref);

  Future dr_profile() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.dr_profile);
    if (response.success == true) {
      ref.read(dr_profile_Provider.notifier).state =
          DriverProfileModel.fromJson(response.data);
      return response.data;
    }
  }

  Future dr_profile_update(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.dr_profile_update, data: data);
    if (response.success == true) {
      successMsg(response);
      ref.read(read_only_provider.notifier).state = true;
      successMsg(response);
      return response.data;
    }
  }

  Future dr_password_update(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.dr_password_update, data: data);
    if (response.success == true) {
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}
