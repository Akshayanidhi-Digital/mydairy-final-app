// ignore_for_file: non_constant_identifier_names, unused_result, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mydairy/dairy_users_dashboard/view_by_entry/view_entry_screen.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../../common/widgets/function.dart';
import '../../../export.dart';
import '../../model/Costumer_list_model.dart';
import '../../model/profile_model.dart';
import '../../profile/controller.dart';
import '../../view_by_entry/controller.dart';

final userCustomerProvider =
    StateProvider.autoDispose<List<Costumers>>((ref) => []);
final amountlistProvider = StateProvider.autoDispose<Map>((ref) => {});
final milkentryRadioProvider = StateProvider.autoDispose<int>((ref) => 0);
final timeProvider = StateProvider<String>((ref) => '');
final shiftProvider = StateProvider<String>((ref) => '');
final backDataProvider =
    StateProvider.autoDispose<List<CostumerModel>>((ref) => []);
final getListProvider = StateProvider.autoDispose((ref) => []);

final milkTypeValueprovider = StateProvider.autoDispose<String>((ref) => '');
// final milkTypetitleprovider = StateProvider.autoDispose<String>((ref) => '');
final milkTypeListDataprovider = StateProvider.autoDispose<List<Map>>((ref) => [
      {"title": listTypes == true ? "Milk-Type" : "All", "value": ""},
      {"title": "Cow", "value": 'Cow'},
      {"title": "Buffalo", "value": 'Buffalo'},
      {"title": "Mix", "value": 'Mix'}
    ]);

class MilkType {
  String title;
  String value;
  MilkType({required this.title, required this.value});
}

final valueChangeProvider = StateProvider<bool>((ref) => false);

final milkentryApiProvider = FutureProvider.autoDispose((ref) async {
  final times = ref.watch(timeProvider);
  final shift = ref.watch(shiftProvider);
  final value = ref.watch(valueChangeProvider);

  return await SiftControllerNotifier(ref: ref)
      .milkEntryApi(shift: shift, times: times, value: value);
});

// final milksellEntryApiProvider = FutureProvider.autoDispose((ref) async {
//   final times = ref.watch(timeProvider);
//   final shift = ref.watch(shiftProvider);
//   return await SiftControllerNotifier(ref: ref)
//       .milkEntryApi(shift: shift, times: times, value: true);
// });

final siftControllerProvider = StateNotifierProvider.autoDispose((ref) {
  final user = ref.watch(dairyListProvider);

  return SiftControllerNotifier(ref: ref, users: user);
});

class SiftControllerNotifier extends StateNotifier {
  Ref ref;
  ProfileModel? users;
  SiftControllerNotifier({required this.ref, this.users}) : super('');

  TextEditingController idController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController fatController = TextEditingController();
  TextEditingController snfController = TextEditingController();
  List<Costumers>? customerlist(type) {
    ref.read(userCustomerProvider.notifier).state.clear();

    for (int i = 0; i < users!.costumers!.length; i++) {
      ref.read(userCustomerProvider.notifier).state.add(users!.costumers![i]);
    }

    if (type == true) {
      ref.read(userCustomerProvider.notifier).state.removeAt(0);
      return ref.read(userCustomerProvider.notifier).state;
    } else {
      ref.read(userCustomerProvider.notifier).state.removeAt(1);
      print(
          " customer list $type falase ${ref.read(userCustomerProvider.notifier).state.length}");
      return ref.read(userCustomerProvider.notifier).state;
    }
  }

  milkEntryApi(
      {required String shift,
      required String times,
      required bool value}) async {
    Map data = {"shift": shift, "date": times.split(" ").first};
    final response = await ApiMethod(ref: ref).putDioRequest(
        value == false ? Url.milkbuyEntryList : Url.milksellList,
        data: data);
    if (response.success == true) {
      var totalAmount =
          response.data.fold(0, (sum, item) => sum + item['total_price']);
      var _totalWeight =
          response.data.fold(0, (sum, item) => sum + item['quantity']);
      var _avgFat = (response.data.fold(0, (sum, item) => sum + item['fat'])) /
          data.length;
      ref.read(amountlistProvider.notifier).state.addAll({
        "totalAmount": totalAmount,
        "totalWeight": _totalWeight,
        "avgFat": _avgFat
      });

      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  milkEntryDelete({required String id, required String value}) async {
    Map data = {"record_id": id};
    final response = await ApiMethod(ref: ref).putDioRequest(
        value == "buy" ? Url.milksellDelete : Url.milkbuyDelete,
        data: data);

    if (response.success == true) {
      ref.refresh(viewByEntryApiProvider);
      successMsg(response);
      navigationPop();
      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  milkEntryAddApi({required Map data, required bool valutype}) async {
    final response = await ApiMethod(ref: ref).putDioRequest(
        valutype == false ? Url.milkEntryAddList : Url.milksellAdd,
        data: data);

    if (response.success == true) {
      ref.refresh(milkentryApiProvider);
      idController.clear();
      weightController.clear();
      fatController.clear();
      snfController.clear();
      ref.read(backDataProvider.notifier).state.clear();
      ref.read(getListProvider.notifier).state.clear();

      ref.read(milkTypeValueprovider.notifier).state = '';

      snackBarMessage(
          msg: response.message.toString(), color: AppColor.greenClr);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future<void> pdfDownload({required id, required bool valueType}) async {
    try {
      String finalUrl =
          valueType == false ? Url.milkbuyprintPdf : Url.milksellprintPdf;
      print("id::::=>   $id");
      final token = await tokenWatch(ref);
      Response<List<int>> response = await Dio().post<List<int>>(
        finalUrl,
        data: {"record_id": id},
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
      snackBarMessage(msg: "Failed to download PDF");
      print('PDF download error: $err');
    }
  }

  // List getPriceList = [];
  getMilkPrice({required Map data, required bool type}) async {
    final response = await ApiMethod(ref: ref).putDioRequest(
        type == false ? Url.milkEntryAddRate : Url.milksellgetPriceList,
        data: data);
    if (response.data != null) {
      if (response.success == true) {
        // getPriceList.clear();
        ref.refresh(getListProvider);
        ref.read(getListProvider.notifier).state.clear();
        ref.read(getListProvider.notifier).state.add(response.data);
        // ref.refresh(farmerListProvider);

        return response.data;
      } else if (response.success == false) {
        return errorSnacMsg(response);
      }
    } else {
      return errorSnacMsg(response);
    }
  }

  farmerMilkAddORRateCalculate(valueType, type, CostumerModel farmer, shift,
      date, milktype, weight, fat, snf, customer_type) {
    var msg = "Please enter data.";
    if (milktype != '') {
      if (farmer.isFixedRate == 1) {
        if (farmer.fixedRateType == 0) {
          if (weight != "") {
            if (type == 0) {
              ref
                  .read(siftControllerProvider.notifier)
                  .milkEntryAddApi(valutype: valueType, data: {
                valueType == false ? "supplier" : "buyer": farmer.costumer_id,
                valueType == false ? "supplier_type" : "buyer_type":
                    customer_type,
                "shift": shift,
                "date": date,
                "quantity": weight,
                "milk_type": milktype
              });
              print("***************Call Api $snf $fat $weight");
            } else {
              Future.delayed(
                  const Duration(seconds: 1),
                  () => ref
                          .read(siftControllerProvider.notifier)
                          .getMilkPrice(type: valueType, data: {
                        valueType == false ? "supplier" : "buyer":
                            farmer.costumer_id,
                        valueType == false ? "supplier_type" : "buyer_type":
                            customer_type,
                        "quantity": weight,
                        "milk_type": milktype
                      }));
              print("***************Call Api $snf $fat $weight");
            }
          } else {
            if (type == 0) {
              snackBarMessage(
                  msg: "Please enter weight.");
            }
          }
        } else {
          if ((weight != "") && (fat != null && fat != "")) {
            if (type == 0) {
              ref
                  .read(siftControllerProvider.notifier)
                  .milkEntryAddApi(valutype: valueType, data: {
                valueType == false ? "supplier" : "buyer": farmer.costumer_id,
                valueType == false ? "supplier_type" : "buyer_type":
                    customer_type,
                "shift": shift,
                "date": date,
                "quantity": weight,
                "fat": fat,
                "milk_type": milktype
              });
            } else {
              Future.delayed(
                  const Duration(seconds: 1),
                  () => ref
                          .read(siftControllerProvider.notifier)
                          .getMilkPrice(type: valueType, data: {
                        valueType == false ? "supplier" : "buyer":
                            farmer.costumer_id,
                        valueType == false ? "supplier_type" : "buyer_type":
                            customer_type,
                        "quantity": weight,
                        "fat": fat,
                        "milk_type": milktype
                      }));
            }
          } else {
            if (type == 0) {
              msg = (weight == null || weight == "")
                  ? "Please enter weight."
                  : "Please enter fat.";
              snackBarMessage(msg: msg);
            }
          }
        }
      } else {
        if ((weight != "") &&
            (fat != null && fat != "") &&
            (snf != null && snf != "")) {
          if (type == 0) {
            ref
                .read(siftControllerProvider.notifier)
                .milkEntryAddApi(valutype: valueType, data: {
              valueType == false ? "supplier" : "buyer": farmer.costumer_id,
              valueType == false ? "supplier_type" : "buyer_type":
                  customer_type,
              "shift": shift,
              "milk_type": milktype,
              "date": date,
              "quantity": weight,
              "fat": fat,
              "snf": snf,
              "clr": 9
            });
          } else {
            Future.delayed(
                const Duration(seconds: 1),
                () => ref
                        .read(siftControllerProvider.notifier)
                        .getMilkPrice(type: valueType, data: {
                      valueType == false ? "supplier" : "buyer":
                          farmer.costumer_id,
                      valueType == false ? "supplier_type" : "buyer_type":
                          customer_type,
                      "quantity": weight,
                      "fat": fat,
                      "snf": snf,
                      "clr": 9,
                      "milk_type": milktype
                    }));
          }
        } else {
          if (type == 0) {
            msg = (weight == null || weight == "")
                ? "Please enter weight."
                : (fat == null || fat == "")
                    ? "Please enter fat."
                    : "please enter snf.";

            snackBarMessage(msg: msg);
          }
        }
      }
    } else {
      snackBarMessage(
          msg: "Please Select milk type first");
    }
  }

  @override
  void dispose() {
    state = '';
    super.dispose();
  }
}
