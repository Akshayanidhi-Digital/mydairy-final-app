import '../../export.dart';
import '../model/profile_model.dart';

final read_only_provider = StateProvider.autoDispose<bool>((ref) => true);

final transporter_profile_Provider =
    StateProvider.autoDispose<TransporterProfileModel>((ref) {
  return TransporterProfileModel.fromJson({});
});

final transport_api_Provider = FutureProvider.autoDispose((ref) async {
  return TransporterProfileApi(ref).transport_profile();
});
final tp_profile_api_Provider =
    Provider.autoDispose<TransporterProfileApi>((ref) {
  return TransporterProfileApi(ref);
});

class TransporterProfileApi {
  Ref ref;
  TransporterProfileApi(this.ref);

  Future transport_profile() async {
    final response =
        await ApiMethod(ref: ref).postDioRequest(Url.transport_profile);
    if (response.success == true) {
      ref.read(transporter_profile_Provider.notifier).state =
          TransporterProfileModel.fromJson(response.data);
      return response.data;
    }
  }

  Future transport_profile_update(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_profile_update, data: data);
    if (response.success == true) {
      ref.read(read_only_provider.notifier).state = true;
      successMsg(response);
      return response.data;
    }
  }

  Future tr_password_update(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.tr_password_update, data: data);
    if (response.success == true) {
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}
