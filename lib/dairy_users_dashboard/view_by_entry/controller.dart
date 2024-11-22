import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mydairy/export.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../common/widgets/function.dart';
import '../milk_buy_sell/sift_time_m_e/controller.dart';

final morningValueProvider = StateProvider.autoDispose<String>((ref) => '');

final mornigTimeListprovider =
    StateProvider.autoDispose<List<MilkType>>((ref) => [
          MilkType(title: "Both", value: ""),
          MilkType(title: "Morning", value: "M"),
          MilkType(title: "Evening", value: "E")
        ]);

final dataProvider = StateProvider.autoDispose<Map>((ref) => {});

final viewByEntryApiProvider = FutureProvider.autoDispose((ref) async {
  final data = ref.watch(dataProvider);
  return ViewByEntryApi(ref: ref).viewByEntryApi(data: data);
});

final viewByDateProvider = Provider.autoDispose<ViewByEntryApi>((ref) {
  return ViewByEntryApi(ref: ref);
});

class ViewByEntryApi {
  Ref ref;
  ViewByEntryApi({required this.ref});

  Future viewByEntryApi({required Map data}) async {
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.entryByDate, data: data);

    if (response.success == true) {
      print("res.....${response.data}");
      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  Future<void> pdfDownload(Map data) async {
    try {
      print("data........... $data");
      final token = await tokenWatch(ref);
      Response<List<int>> response = await Dio().post<List<int>>(
        Url.entryByDatePrint,
        data: data,
        options: Options(
          headers: token,
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("url >>>>>>>>>>>>>>>>>>>> ......... ${response.realUri}");

      if (response.statusCode == 200) {
        print("res:::::::::::::::::${response.data}");
        final tempDir = await getTemporaryDirectory();
        final fullPath = '${tempDir.path}/milkslip.pdf';
        File file = File(fullPath);
        await file.writeAsBytes(response.data!, flush: true);

        OpenFile.open(fullPath);
        print('File opened: $fullPath');
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load PDF');
      }
    } catch (err) {
      snackBarMessage(msg: "Failed to download PDF", color: AppColor.redClr);
      print('PDF download error: $err');
    }
  }
}
