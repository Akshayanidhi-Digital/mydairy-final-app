// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mydairy/dairy_users_dashboard/home/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import '../common/services/splash_screen.dart';
import '../dairy_users_dashboard/qr_screens/qr_scan_screen.dart';
import 'auth_model.dart';
import 'create_password.dart';
import 'otp_screen.dart';
import 'package:mydairy/export.dart';

Timer? timer;
final minuteProvider = StateProvider.autoDispose<int>((ref) => 3);
final secondProvider = StateProvider.autoDispose<int>((ref) => 0);
final boolTimerProver = StateProvider.autoDispose<bool>((ref) => false);
final buttonEnabledProvider = StateProvider<bool>((ref) => true);

final authProvider = Provider.autoDispose<Authentication>((ref) {
  return Authentication(ref);
});

class Authentication {
  Ref ref;
  Authentication(this.ref);

  Future checkUser(String mobile) async {
    Map body = OtpAndResetModel(mobile: mobile).toJson();
    final response =
        await ApiMethod(ref: ref).postTokenWrite(Url.checkUser, data: body);
    if (response.success == true) {
      showPopup(mobile, response.data);
    } else {
      errorSnacMsg(response);
    }
  }

  Future login(LoginModel data) async {
    final response = await ApiMethod(ref: ref)
        .postTokenWrite(Url.login, data: data.toJson());

    print("-------------------{${data.accountType}}");

    if (response.success == true) {
      successMsg(response);
      if (data.type == "2") {
        navigationTo(OtpScreen(
            type: '1', mobile: data.mobile, account_type: data.accountType!));
      } else {
        if (data.type == "0") {
          navigationTo(OtpScreen(
              type: '1', mobile: data.mobile, account_type: data.accountType!));
        } else {
          for (SplashNavigator element in splashNavigat) {
            if (element.type == data.accountType) {
              Future(() => navigationRemoveUntil(element.screen));
              Secure.token_write(ref,
                  response: response, value: data.accountType!);
            }
          }
        }
      }
      //!@
    } else {
      errorSnacMsg(response);
    }
  }

  Future otp(LoginModel data) async {
    print("data::::::::::::::::::: ${data.toJson()}");
    final response =
        await ApiMethod(ref: ref).postTokenWrite(Url.otp, data: data.toJson());
    print("response data :::::::::::::: ${response.data}");
    if (response.success == true) {
      log("type :: ${data.type}");
      successMsg(response);
      if (data.type == "2") {
        navigationTo(CreatePasswordScreen(
            resetToken: response.data['reset_token'].toString(),
            accounttype: data.accountType!,
            mobile: data.mobile!));
      } else if (data.type == "1") {
        Secure.token_write(ref, response: response, value: data.accountType!);
        navigationRemoveUntil(const HomeScreenPage());
      } else {
        for (SplashNavigator element in splashNavigat) {
          if (element.type == data.accountType) {
            successMsg(response);
            Future(() => navigationRemoveUntil(element.screen));
            Secure.token_write(ref,
                response: response, value: data.accountType!);
          }
        }
      }
    } else {
      errorSnacMsg(response);
    }
  }

  Future signUp(SignUpModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.signUp, data: data.toJson());
    print("response ${response.data}");
    if (response.success == true) {
      navigationTo(OtpScreen(type: "1", mobile: data.mobile));
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future on_board(OnBoardModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.onboard_dairy, data: data.toJson());
    print("response data ::::::: ${response.data}");
    if (response.success == true) {
      navigationRemoveUntil(const HomeScreenPage());

      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future fotgetPassword({String? mobile, required String accounttype}) async {
    Map data =
        OtpAndResetModel(mobile: mobile, account_type: accounttype).toJson();
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.forget, data: data);
    if (response.success == true) {
      successMsg(response);
      navigationTo(
          OtpScreen(mobile: mobile, type: "2", account_type: accounttype));

      return response.data;
    } else {
      return errorSnacMsg(response);
    }
  }

  Future resendOtp({String? mobile, required String account_type}) async {
    Map data =
        OtpAndResetModel(mobile: mobile, account_type: account_type).toJson();
    final response =
        await ApiMethod(ref: ref).putDioRequest(Url.resendOtp, data: data);
    if (response.success == true) {
      ref.read<StateController<bool>>(boolTimerProver.notifier).state = true;
      successMsg(response);
      return response.data;
    } else if (response.success == false) {
      return errorSnacMsg(response);
    }
  }

  Future passwordUpdate(
      {CreatePasswordModel? data,
      required String accounttype,
      required String mobile}) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.passwordUpdate, data: data!.toJson());
    if (response.success == true) {
      // navigationTo(
      //     OtpScreen(mobile: mobile, type: "2", account_type: accounttype));
      navigationRemoveUntil(
          LogInScreen(accounttype: accounttype, mobile: mobile));

      successMsg(response);
      return response.data;
    } else if (response.success == false) {
      return errorSnacMsg(response);
    }
  }

  startTimer() {
    ref.read(buttonEnabledProvider.notifier).state = false;
    ref.read(minuteProvider.notifier).state = 3;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (ref.read(secondProvider.notifier).state > 0) {
        ref.read(secondProvider.notifier).state--;
      } else {
        if (ref.read(minuteProvider.notifier).state > 0) {
          ref.read(minuteProvider.notifier).state--;
          ref.read(secondProvider.notifier).state = 59;
        } else {
          timer.cancel();
          ref.read(buttonEnabledProvider.notifier).state = true;
        }
      }
    });
  }
}

final qrLoginProvider = Provider.autoDispose<QrAuth>((ref) {
  return QrAuth(ref: ref);
});

class QrAuth {
  Ref? ref;
  QrAuth({this.ref});
  qrLoginFn(QrModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.qrLogin, data: data.toJson());

    if (response.success == true) {
      ref!.read(qrValuesProvider.notifier).update((state) => 1);
      HapticFeedback.vibrate();
      navigationRemoveUntil(const HomeScreenPage());
      ref!.read(qrValuesProvider.notifier).update((state) => 1);
      ref!.invalidateSelf();
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}

final locationlsProvider = StateProvider.autoDispose<List>((ref) => []);

final locationProvider = StateNotifierProvider.autoDispose((ref) {
  return LocationNotifier(ref: ref);
});

class LocationNotifier extends StateNotifier {
  Ref ref;
  LocationNotifier({required this.ref}) : super([]);
  List location = [];

  Future getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      await Permission.location.request();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // state =
      ref.read(locationlsProvider.notifier).state = [
        position.latitude,
        position.longitude
      ];
    } catch (e) {
      await Geolocator.requestPermission();
      await Permission.location.request();
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      // openAppSettings();

      print("state      err*********************   $e");
    }
  }

  @override
  void dispose() {
    state = '';
    super.dispose();
  }
}
