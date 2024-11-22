import '../../dairy_users_dashboard/model/farmer_buyer_profile_model.dart';
import '../../export.dart';
import 'farmer_home_screen.dart';

// ignore: non_constant_identifier_names
List<DairyList> dairy_list = [];
final buyerloginProvider = StateProvider.autoDispose((ref) => false);
final selectedDairyProvider = StateProvider.autoDispose((ref) => '');
final startDateProvider = StateProvider.autoDispose<DateTime?>((ref) => null);
final endDateProvider = StateProvider.autoDispose<DateTime?>((ref) => null);
final milkDataListProvider = StateProvider.autoDispose<List>((ref) => []);

final getRecordProvider = FutureProvider.autoDispose((ref) async {
  final selectedDairy = ref.watch(selectedDairyProvider);
  final startDate = ref.watch(startDateProvider);
  final endDate = ref.watch(endDateProvider);
  return FarmerApiData(ref: ref).getrecords(
      endDate: endDate, selectedDairy: selectedDairy, startDate: startDate);
});

final farmerDataApiProvider =
    Provider.autoDispose<FarmerApiData>((ref) => FarmerApiData(ref: ref));

class FarmerApiData {
  Ref ref;
  FarmerApiData({required this.ref});
  Future checkLoginStatus({required bool buyer}) async {
    final response = await ApiMethod(ref: ref)
        .postDioRequest(buyer == false ? Url.farmer_info : Url.buyer_info);
    print("..****buyer...$buyer");
    if (response.success == true) {
      FarmerBuyerData farmerList = FarmerBuyerData.fromJson(response.data);
      farmer.add(farmerList);
      Future(() {
        dairy_list = farmerList.dairyList!.cast();
      });

      return response.data;
    } else {
      errorSnacMsg(response);
      return null;
    }
  }

  Future getrecords({startDate, endDate, selectedDairy}) async {
    final buyer = ref.read(buyerloginProvider);
    Map<String, dynamic> data = GetRecord(
            dairyName: selectedDairy.toString(),
            startDate: startDate.toString(),
            endDate: endDate.toString())
        .toJson();

    final response = await ApiMethod(ref: ref).putDioRequest(
        buyer == false ? Url.farmer_record : Url.buyer_record,
        data: data);

    if (response.success == true) {
      ref.read(milkDataListProvider.notifier).state = response.data;
      if (response.data.isEmpty) snackBarMessage(msg: "Records is Empty");
      return response.data;
    } else {
      snackBarMessage(
          msg: response.message.toString(), color: AppColor.appColor);
    }
  }
}

class GetRecord {
  String? startDate;
  String? endDate;
  String? dairyName;

  GetRecord({this.startDate, this.endDate, this.dairyName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['dairy_name'] = this.dairyName;
    return data;
  }
}
