// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/services/splash_screen.dart';
import 'export.dart';
import 'firebase_options.dart';
import 'notification/notification_services.dart';

@pragma('vm:entry-point')
Future _firebase_message_handle(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  _main_initial_function();
  runApp(ProviderScope(
      child: EasyLocalization(
          startLocale: const Locale('en', 'US'),
          supportedLocales: const [Locale('en', 'US'), Locale('ta', 'IN')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          saveLocale: true,
          child: const MyApp())));
}

 class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(360, 797),
        ensureScreenSize: true,
        minTextAdapt: true,
        splitScreenMode: true,
        
        builder: (context, child) {
          return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              scaffoldMessengerKey: Keys.scaffoldkey(),
              navigatorKey: Keys.navigatorKey(),
              debugShowCheckedModeBanner: false,
              title: 'My Dairy',
              theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: AppColor.appColor),
                  useMaterial3: true),
              home: const SplashScreen());
        });
  }
}

Future _main_initial_function() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebase_message_handle);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.transparent,
      systemNavigationBarColor: AppColor.transparent));
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
}
