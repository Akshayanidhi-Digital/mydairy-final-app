import 'dart:developer';
import 'package:razorpay_web/razorpay_web.dart';

import '../../../export.dart';

final paymentProvider = Provider.autoDispose((ref) => PaymentGateway(ref));

class PaymentGateway {
  final Ref ref;
  final Razorpay _razorpay = Razorpay();
  PaymentGateway(this.ref);
  intialGataway() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successFun);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorFun);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletFun);
  }

  successFun(PaymentSuccessResponse response) async {
    log("success payment response => ${response.orderId}");
    log("success payment response PAYMENT ID => ${response.paymentId}");
    // Future.delayed(Duration(microseconds: 1), () async {
    //   log(" success payment response => $response");
    //   return await ref
    //       .read(createOrderProvider)
    //       .createOrder(cartId: id, paymentMethod: 2);
    // });
  }

  errorFun(PaymentSuccessResponse response) {
    log("error payment response => ${response.orderId}");
    log("error payment response => ${response.paymentId}");
    // return navigatorKey.currentState?.push(MaterialPageRoute(
    //   builder: (context) => const CheckoutPage(),
    // ));
  }

  externalWalletFun(PaymentSuccessResponse response) {
    log("wallet payment response => $response");
    return '';
  }

  paymentWinodowOpen(
      {required double ammount, String? phone, String? email, cartId}) {
    final _options = {
      'key': 'rzp_test_Gr4MFnNE0YOwvD',
      // 'key': 'rzp_live_S2LhMzvohsSb9g', // key
      'amount': '$ammount',
      'name': '',
      'cart_id': '$cartId',
      'description': '',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      "currency": "INR",
      'prefill': {'contact': '$phone', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      return _razorpay.open(_options);
    } catch (e) {
      log(" open error $e");
      return e.toString();
    }
  }
}
