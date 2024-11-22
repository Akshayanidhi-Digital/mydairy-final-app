import '../../authentication/auth_controller.dart';
import '../../authentication/auth_model.dart';
import '../../export.dart';
import '../../transport_dashboard/authentication/otp_screen.dart';
import '../home/home_screen.dart';

final driver_auth_Provider = Provider.autoDispose<DriverAuth>((ref) {
  return DriverAuth(ref);
});

class DriverAuth {
  final Ref ref;
  const DriverAuth(this.ref);
  Future login(LoginModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.driver_login, data: data.toJson());

    if (response.success == true) {
      successMsg(response);
      if (response.data == null) {
        navigationTo(TransportOtpScreen(mobile: data.mobile));
      } else {
        Secure.token_write(ref, response: response, value: "5");
        navigationRemoveUntil(const DriverHomeScreen());
      }
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future verify(LoginModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.driver_verify, data: data.toJson());

    if (response.success == true) {
      Secure.token_write(ref, response: response, value: "5");
      navigationRemoveUntil(const DriverHomeScreen());
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future forget(LoginModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.driver_forget, data: data.toJson());
    if (response.success == true) {
      navigationPop();
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future resend_otp(LoginModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.driver_resend_otp, data: data.toJson());

    if (response.success == true) {
      ref.read<StateController<bool>>(boolTimerProver.notifier).state = true;
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}
