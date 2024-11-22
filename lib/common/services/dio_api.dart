import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mydairy/export.dart';

import '../widgets/function.dart';
import '../widgets/respond.dart';

final errorProvider = StateProvider.autoDispose<String>((ref) => '');
BaseOptions dioOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    contentType: 'application/json; charset=utf-8',
    responseType: ResponseType.json);

class ApiMethod {
  Ref? ref;
  ApiMethod({required this.ref});
  Dio dio = Dio();

  Future<Respond> postDioRequest(String url) async {
    try {
      bool result = await InternetConnection().hasInternetAccess;
      if (result) {
        final token = await tokenWatch(ref!);

        Response response =
            await dio.post(url, options: Options(headers: token));

        log("response success ${response.statusCode}\n response success ${response.data}");

        return checkStatus(response);
      } else {
        ref!.read(internetProvider.notifier).state = true;
        noInernet();
        return Respond(success: false, message: Msg.somethingWrong, data: null);
      }
    } on DioException catch (err) {
      log("Url....${err.response!.realUri}");
      String error = (err.response == null)
          ? "Something went wrong"
          : err.response!.data['message'].toString();
      ref!.read(errorProvider.notifier).state = error;
      checkStatus(err.response!);
      snackBarMessage(msg: error, color: AppColor.redClr);

      return Respond(success: false, message: error, data: null);
    } finally {
      ref!.invalidate(loadingProvider);
    }
  }

  Future<Respond> putDioRequest(String url, {data}) async {
    try {
      Loadingbtn(ref!).enable();
      bool result = await InternetConnection().hasInternetAccess;
      final token = await tokenWatch(ref!);
      if (result) {
        Response response =
            await dio.post(url, data: data, options: Options(headers: token));
        log("response success ${response.statusCode} \n response success ${response.data}");

        return await checkStatus(response);
      } else {
        ref!.read(internetProvider.notifier).state = true;
        noInernet();

        return Respond(success: false, message: Msg.somethingWrong, data: null);
      }
    } on DioException catch (err) {
      log("Url....${err.response!.realUri}");
      log("exception data....${err.response!.data}");
      String error = (err.response == null)
          ? "Something went wrong"
          : err.response!.data['message'].toString();

      ref!.read(errorProvider.notifier).state = error;
      snackBarMessage(msg: error, color: AppColor.redClr);
      Future(() => checkStatus(err.response!));
      return Future(() => Respond(success: false, message: error));
    } finally {
      Loadingbtn(ref!).disable();
    }
  }

//!TODO   =================== token write ======================

  Future<Respond> postTokenWrite(String url, {data}) async {
    try {
      Loadingbtn(ref!).enable();
      bool result = await InternetConnection().hasInternetAccess;
      if (result) {
        Response response = await dio.post(url, data: data);
        print("status code   ::  ${response.statusCode}");
        log("data....... $data ");
        log("response success ${response.data}");
        if (response.statusCode == 200) {
          return Respond.fromJson(response.data);
        } else {
          return Respond(
              success: false, message: Msg.somethingWrong, data: null);
        }
      } else {
        noInernet();

        return Respond(success: false, message: Msg.noInternet, data: null);
      }
    } on DioException catch (err) {
      print("erro $err");
      String error = (err.response == null)
          ? "Something went wrong"
          : err.response!.data['message'].toString();

      ref!.read(errorProvider.notifier).state = error;
      snackBarMessage(msg: error, color: AppColor.redClr);
      Future(() => checkStatus(err.response!));

      return Future(() => Respond(success: false, message: error));
    } finally {
      Loadingbtn(ref!).disable();
    }
  }
}
