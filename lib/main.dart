import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'App/Notification/local_notification.dart';
import 'App/Route/route.dart';
import 'App/Utils/theme_styles.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  PushLocalNotifications.localNotiInit();
  runApp( const ProviderScope( child: TestApp(),));
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {

  @override
  Widget build(BuildContext context) {

    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: ThemeStyles.whiteColor,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: false);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    return OverlaySupport.global(
      child: MaterialApp.router(
        routerConfig:routeFunction ,
        builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
              ),
        debugShowCheckedModeBanner: false,
        theme: ThemeStyles.lightTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}