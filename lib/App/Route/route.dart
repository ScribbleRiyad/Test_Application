
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/App/Route/route_name.dart';

import '../Application/application_screen.dart';
import '../Presentations/Home/home_screen.dart';
import '../Presentations/Splash/splash_screen.dart';




final GoRouter routeFunction =GoRouter (

    initialLocation: '/',
    navigatorKey: GlobalKey<NavigatorState>(),

    routes: [
      GoRoute(name : RouteName.splashScreen,            path: "/", builder: (context, state) => const SplashScreen(),),
      GoRoute(name : RouteName.homeScreen,              path: "/homeScreen", builder: (BuildContext context, GoRouterState state) => const HomeScreen(),),
      GoRoute(name : RouteName.applicationScreen,       path: "/applicationScreen", builder: (BuildContext context, GoRouterState state) => const ApplicationScreen(),),



    ]

);