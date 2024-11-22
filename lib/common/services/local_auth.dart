// import 'dart:developer';

// import 'package:local_auth/local_auth.dart';
// import 'package:mydairy/dairy_users_dashboard/home/home_screen.dart';

// import '../widgets/navigation.dart';

// class LocalAuth {
//   static final LocalAuthentication _auth = LocalAuthentication();
//   // var context = navigatorKey.currentState;
//   checkAuth({required context}) async {
//     try {
//       bool isAvailable;
//       // final names = await _auth.isDeviceSupported();
   
//       isAvailable = await _auth.canCheckBiometrics;
//       print("Availables  $isAvailable");
//       if (isAvailable == true) {
       
//         bool result = await _auth.authenticate(
//             options: const AuthenticationOptions(
//                 sensitiveTransaction: true,
//                 stickyAuth: true,
//                 useErrorDialogs: true),
//             localizedReason: 'Scan Your fingerprint to Proceed');
//         if (result == true) {
//           navigationTo(const HomeScreenPage());
//         } else {
//           log("RRR");
//         }
//       } else {
//         log('No Biometric sensor detected');
//       }
//     } catch (err) {
//   
//       log(err.toString());
//     }
//   }
// }
