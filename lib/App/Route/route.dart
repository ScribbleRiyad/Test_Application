
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/App/Presentations/Sensor/sensor_screen.dart';
import 'package:test_app/App/Route/route_name.dart';
import '../Presentations/Home/home_screen.dart';
import '../Presentations/Splash/splash_screen.dart';
import '../Presentations/Welcome/welcome_screen.dart';




final GoRouter routeFunction =GoRouter (

    initialLocation: '/',
    navigatorKey: GlobalKey<NavigatorState>(),

    routes: [
      GoRoute(name : RouteName.splashScreen,            path: "/", builder: (context, state) => const SplashScreen(),),
      GoRoute(name : RouteName.homeScreen,              path: "/homeScreen", builder: (BuildContext context, GoRouterState state) => const HomeScreen(),),
      GoRoute(name : RouteName.welcomeScreen,              path: "/welcomeScreen", builder: (BuildContext context, GoRouterState state) => const WelcomeScreen(),),
      GoRoute(name : RouteName.sensorScreen,              path: "/sensorScreen", builder: (BuildContext context, GoRouterState state) => const SensorScreen(),),



    ]

);