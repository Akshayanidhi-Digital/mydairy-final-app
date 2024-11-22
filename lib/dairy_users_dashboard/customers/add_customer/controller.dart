// ignore_for_file: unused_result
import 'package:mydairy/export.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'add_customerAnd_Profile_screen.dart';

final pickContectCustomerProvider = Provider.autoDispose((ref) {
  return AddCustomerNotifier(ref: ref);
});

class AddCustomerNotifier {
  Ref ref;
  AddCustomerNotifier({required this.ref});
  PhoneContact? _phoneConetct;
  pickContactFn() async {
    try {
      bool permission = await FlutterContactPicker.requestPermission();
      if (permission) {
        if (await FlutterContactPicker.hasPermission()) {
          _phoneConetct = await FlutterContactPicker.pickPhoneContact();
          if (_phoneConetct != null) {
            if (_phoneConetct!.phoneNumber!.number!.isNotEmpty) {
              snackBarMessage(
                  color: AppColor.greenClr,
                  msg:
                      "Select Contect No. ${_phoneConetct!.phoneNumber!.number.toString()}");
              return ref.read(pickNumberProvider.notifier).state =
                  _phoneConetct!.phoneNumber!.number.toString();
              // log(pickNumberProvider.notifier.toString());
            }
          }
        }
      } else {
        showDialog(
          context: Keys.navigatorKey().currentState!.context,
          builder: (context) => AlertDialogBox(
            title: "Allow My Dairy access to your Contects",
            onPressed1: () => navigationPop(),
            onPressed2: () => openAppSettings(),
            setting: "Setting",
          ),
        );
        // openAppSettings();
      }
    } catch (e) {
      snackBarMessage(msg: "No Select Contect");
      log(e.toString());
    }
  }
}

// final farmerListProvider = FutureProvider.autoDispose((ref) async {
//   // ref.keepAlive();
//   return await CustomerApiNotifier(ref).farmerList();
// });
final typelstProvider = StateProvider.autoDispose<String>((ref) => "");
// final typemilkProvider = StateProvider.autoDispose<String>((ref) => "");
final customerListProvider = FutureProvider.autoDispose((ref) async {
  final type = ref.watch(typelstProvider);
  // ref.keepAlive();
  return await CustomerApiNotifier(ref).customerList(type);
});

final farmerApiProvider = Provider.autoDispose((ref) {
  return CustomerApiNotifier(ref);
});

class CustomerApiNotifier {
  Ref ref;

  CustomerApiNotifier(this.ref);

  addCustomers({required Map data, required BuildContext context}) async {
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.customerAdd, data: data);

    if (response.success == true) {
      // await ref!.refresh(farmerListProvider);
      showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
            icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Icon(Icons.task_alt, size: 30.w, color: AppColor.appColor)),
            actions: const [Text("")],
            content: "Customer Added Successfully"),
      );

      Future.delayed(const Duration(seconds: 2), () {
        navigationPop();
        navigationPop();
      });
      successMsg(response);

      return response.data;
    } 
  }

  Future customerList(type) async {
    Map data = {"costumer_type": type};
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.customerList, data: data);

    if (response.success == true) {
      return response.data;
    }
   
  }

  Future deleteCustomer({required Map data}) async {
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.cutomerDelete, data: data);

    if (response.success == true) {
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialogBox(
      //     icon: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Icon(
      //         Icons.task_alt,
      //         size: 30.w,
      //         color: AppColor.appColor,
      //       ),
      //     ),
      //     actions: const [Text("")],
      //     content: "Entry Deleted Successfully",
      //   ),
      // );

      // Future.delayed(const Duration(seconds: 1), () {
      navigationPop();
      // navigationPop();
      // });
      return response;
    } else if (response.success == false) {
      return errorSnacMsg(response);
    }
  }

  Future customerUpdate({required Map data}) async {
    final response = await ApiMethod(ref: ref).putDioRequest(Url.cutomerUpdate,
        // idUpdate == false ? Url.farmerProfileUpdate : Url.buyerUpdate,
        data: data);
    print(" data ::::: $data");
    if (response.success == true) {
      ref.refresh(customerListProvider);
      successMsg(response);
      navigationPop();
      return response.data;
    } else if (response.success == false) {
      errorSnacMsg(response);
    }
  }

  // Future buyerRateUpdate({required data}) async {
  //   final response = await ApiMethod(ref: ref)
  //       .putDioRequest(Url.buyerRateUpdate, data: data);

  //   if (response.success == true) {
  //     // ref.refresh(buyerListProvider);
  //     successMsg(response);
  //     return response.data;
  //   } else if (response.success == false) {
  //     return errorSnacMsg(response);
  //   }
  // }
}
