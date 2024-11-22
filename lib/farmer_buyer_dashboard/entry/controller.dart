import '../../../export.dart';
import '../home/controller.dart';

final listCountProvider = StateProvider.autoDispose<List>((ref) {
  return [];
});
final getFarmerEntryProvider =
    FutureProvider.autoDispose.family((ref, month) async {
  final year = ref.watch(selectedYearProvider);
  return FarmerControllerRecord(ref: ref).getRecordsInfo(year, month);
});
final farmerRecordApiProvider = Provider.autoDispose((ref) {
  return FarmerControllerRecord(ref: ref);
});

class FarmerControllerRecord {
  Ref ref;
  FarmerControllerRecord({required this.ref});

  Future<void> getRcordsInfo(year) async {
    final buyer = ref.read(buyerloginProvider);
    Map<String, String> data = {"year": year.toString()};

    final response = await ApiMethod(ref: ref).putDioRequest(
        buyer == false
            ? Url.farmer_record_counts_per_Year
            : Url.buyer_record_counts_per_Year,
        data: data);

    if (response.success == true) {
      ref.read(listCountProvider.notifier).state = response.data;
      return response.data;
    } else {
      ref.read(listCountProvider.notifier).state = [];
      errorSnacMsg(response);
    }
  }

  Future getRecordsInfo(int year, month) async {
    final buyer = ref.read(buyerloginProvider);
    Map<String, String> data = {"year": year.toString(), "month": month};
    final response = await ApiMethod(ref: ref).putDioRequest(
        buyer == false ? Url.farmer_record_detailed : Url.buyer_record_detailed,
        data: data);
    if (response.success == true) {
      List<dynamic> dataList = response.data;
      return dataList.map((e) => e as Map<String, dynamic>).toList();
    } else {
      return [];
    }
  }
}

final selectedYearProvider = StateProvider.autoDispose<int>((ref) {
  return DateTime.now().year;
});
