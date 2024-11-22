import '../../authentication/auth_controller.dart';
import '../../authentication/auth_model.dart';
import '../../export.dart';
import '../home/home_screen.dart';
import 'otp_screen.dart';

final eyeProvider = StateProvider.autoDispose<bool>((ref) => false);
final eye2Provider = StateProvider.autoDispose<bool>((ref) => false);

final transport_auth_Provider =
    Provider.autoDispose<TransportAuth>((ref) => TransportAuth(ref));

class TransportAuth {
  Ref ref;
  TransportAuth(this.ref);

  Future login(LoginModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_login, data: data.toJson());

    if (response.success == true) {
      successMsg(response);
      if (response.data == null) {
        navigationTo(TransportOtpScreen(mobile: data.mobile));
      } else {
        Secure.token_write(ref, response: response, value: "4");
        navigationRemoveUntil(const TransPortHomeScreen());
      }
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future verify(LoginModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_verify, data: data.toJson());

    if (response.success == true) {
      Secure.token_write(ref, response: response, value: "4");
      navigationRemoveUntil(const TransPortHomeScreen());
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future forget(LoginModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_forget, data: data.toJson());

    if (response.success == true) {
      navigationPop();
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }

  Future resend_otp(LoginModel data) async {
    final response = await ApiMethod(ref: ref)
        .putDioRequest(Url.transport_resend_otp, data: data.toJson());

    if (response.success == true) {
      ref.read<StateController<bool>>(boolTimerProver.notifier).state = true;
      successMsg(response);
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}
