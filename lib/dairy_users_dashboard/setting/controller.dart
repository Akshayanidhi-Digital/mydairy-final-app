import 'package:mydairy/export.dart';
import '../../common/widgets/function.dart';
import 'setting_controller.dart';

final settingsdataProvider =
    StateNotifierProvider<SettingNotifier, List<SettingModel>>((ref) {
  return SettingNotifier(ref);
});

class SettingNotifier extends StateNotifier<List<SettingModel>> {
  Ref ref;
  SettingNotifier(this.ref) : super([]);

  clearState() => state = [];

  addSetting(value) => state.add(SettingModel.fromJson(value));

  fontSizeUpdate(String? value) {
    state = state.map((e) => e..printFontSize = value).toList();
  }

  printerSelectUpdate(String? value) {
    state = state.map((e) => e..printSize = value).toList();
  }

  weightUpdate(String? value) {
    state = state.map((e) => e..wight = value).toList();
  }

  List<SettingModel> printRecieptUpdate() {
    state =
        state.map((e) => e..printRecipt = e.printRecipt == 0 ? 1 : 0).toList();
    return state;
  }

  printAllLanguage() {
    state = state
        .map((e) => e..printReciptAll = e.printReciptAll == 0 ? 1 : 0)
        .toList();
  }

  whatsappMessageUpdate() {
    state = state
        .map((e) => e..whatsappMessage = e.whatsappMessage == 0 ? 1 : 0)
        .toList();
  }

  automaticFatUpdate() =>
      state = state.map((e) => e..autoFats = e.autoFats == 0 ? 1 : 0).toList();
}

final settingGetApiProvider = FutureProvider.autoDispose((ref) async {
  ref.keepAlive();
  return SettingController(ref).settingApi();
});
final settingApiProvider = Provider.autoDispose((ref) {
  return SettingController(ref);
});

class SettingController {
  Ref ref;
  SettingController(this.ref);
  settingApi() async {
    final response = await ApiMethod(ref: ref).postDioRequest(Url.settingGet);
    print("profileData..${response.data}");
    if (response.success == true) {
      ref.read(settingsdataProvider.notifier).clearState();
      ref.read(settingsdataProvider.notifier).addSetting(response.data);
      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  settingUpdate(Map data, {bool lang = false, bhasa}) async {
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.settingUpdate, data: data);

    if (response.success == true) {
      bhasa == null ? '' : language = bhasa;
      lang == false
          ? successMsg(response)
          : snackBarMessage(
              msg: "Language Update Successfully", color: AppColor.greenClr);
      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }
}
