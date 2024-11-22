import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mydairy/export.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/widgets/function.dart';
import 'upload_chart_screen.dart';

final valueSnfProvider = StateProvider<int>((ref) {
  return 0;
});
final getBuyChartProvider = FutureProvider.family((ref, milkType) async {
  final value = ref.watch(valueSnfProvider);
  final res =
      ref.watch(chartApiProvider).getBuyChart(milkType: milkType, value: value);
  return res;
});

final chartApiProvider = Provider<ChartApiMethod>((ref) {
  return ChartApiMethod(ref);
});

class ChartApiMethod {
  Ref ref;
  ChartApiMethod(this.ref);
  Future getBuyChart({required milkType, value}) async {
    Map data = {
      "milk_type": milkType,
      "rate_type": value == 0 ? "Sell" : "Purchase"
    };
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.get_chart, data: data);

    if (response.success == true) {
      return response.data;
    } else if (response.success == false) {
      errorSnacMsg(response);
    }
  }

  Future rate_chart_update(Map data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.rate_chart_update, data: data);
    if (response.success == true) {
      navigationPop();
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future uploadChart(UploadChartModel mydata) async {
    FormData data = FormData.fromMap(mydata.toJson());
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.uploadChart, data: data);
    if (response.success == true) {
      navigationPop();
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future sample_chart() async {
    try {
      final token = await tokenWatch(ref);
      Response<List<int>> response = await Dio().post<List<int>>(
        Url.sample_chart,
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
        final fullPath = '${tempDir.path}/sample.xls';
        File file = File(fullPath);
        await file.writeAsBytes(response.data!, flush: true);

        OpenFile.open(fullPath);
        print('File opened: $fullPath');
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load Excel');
      }
    } catch (err) {
      snackBarMessage(msg: "Failed to download Excel", color: AppColor.redClr);
      print('Excel download error: $err');
    }
  }

  Future chart_download(Map data) async {
    try {
      final token = await tokenWatch(ref);
      Response<List<int>> response = await Dio().post<List<int>>(
        Url.chart_download,
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
      print("data >>>>>>>>>>>>>>>>>>>> ......... ${data}");

      if (response.statusCode == 200) {
        print("res:::::::::::::::::${response.data}");
        final tempDir = await getDownloadsDirectory();
        print("path::::::::::::::: ${tempDir}");

        final fullPath = '${tempDir!.path}/milk_rate.xls';
        File file = File(fullPath);
        await file.writeAsBytes(response.data!, flush: true);

        OpenFile.open(fullPath);
        print('File opened: $fullPath');
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load Excel');
      }
    } catch (err) {
      snackBarMessage(msg: "Failed to download Excel", color: AppColor.redClr);
      print('Excel download error: $err');
    }
  }
}
