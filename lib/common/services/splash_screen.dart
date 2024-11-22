// ignore_for_file: file_names, unused_result

import 'package:flutter/material.dart';
import 'package:mydairy/export.dart';
import 'package:mydairy/dairy_users_dashboard/home/home_screen.dart';
import 'package:mydairy/transport_dashboard/home/home_screen.dart';
import '../../authentication/check_user.dart';
import '../../driver_dashboard/home/home_screen.dart';
import '../../farmer_buyer_dashboard/home/farmer_home_screen.dart';
import '../../notification/controller.dart';

//! =================================== Splace Screen ========================
final splashProvider = StateProvider.autoDispose((ref) => _getLoginData(ref));
String fcm_token = '';
List<SplashNavigator> splashNavigat = [
  SplashNavigator(type: "2", screen: const FarmerHome(buyer: false)),
  SplashNavigator(type: "1", screen: const HomeScreenPage()),
  SplashNavigator(type: "3", screen: const FarmerHome(buyer: true)),
  SplashNavigator(type: "0", screen: const HomeScreenPage(childDairy: true)),
  SplashNavigator(type: "4", screen: const TransPortHomeScreen()),
  SplashNavigator(type: "5", screen: const DriverHomeScreen()),
];

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    ref.read(splashProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Img.splace), fit: BoxFit.cover))));
  }
}

_getLoginData(AutoDisposeStateProviderRef<Object?> ref) async {
  Future.delayed(const Duration(seconds: 3), () async {
    FirebaseMessage().request_permission();
    FirebaseMessage().refresh_token();
    FirebaseMessage().firebase_init();
    FirebaseMessage().get_token().then((value) {
      fcm_token = value;
      print("fcm token $value");
    });
    final token1 = await ref.watch(storageProvider).readData(Secure.token);
    final type = await ref.watch(storageProvider).readData(Secure.type());
    print("............type..........{$type}");
    print("............token..........{$token1}"); 

    if (token1 != null && token1.isNotEmpty) {
      for (SplashNavigator element in splashNavigat) {
        print("elemet....${element.type}");
        if (element.type == type) {
          Future(() => navigationRemoveUntil(element.screen));
        } else {
          navigationRemoveUntil(const UserCheckLoginScreen());
        }
      }
    } else {
      navigationRemoveUntil(const UserCheckLoginScreen());
    }
  });
}

//! splash
class SplashNavigator {
  final String type;
  final Widget screen;
  SplashNavigator({required this.type, required this.screen});
}
