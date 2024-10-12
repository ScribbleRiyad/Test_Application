
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/App/Presentations/Sensor/sensor_screen.dart';
import 'package:test_app/App/Route/route_name.dart';

import '../Presentations/Splash/splash_screen.dart';
import '../Presentations/ToDo Screen/todo_details_screen.dart';
import '../Presentations/ToDo Screen/todo_screen.dart';
import '../Presentations/Welcome/welcome_screen.dart';




final GoRouter routeFunction =GoRouter (

    initialLocation: '/',
    navigatorKey: GlobalKey<NavigatorState>(),

    routes: [
      GoRoute(name : RouteName.splashScreen,            path: "/", builder: (context, state) => const SplashScreen(),),
      GoRoute(name : RouteName.toDoScreen,              path: "/toDoScreen", builder: (BuildContext context, GoRouterState state) => const ToDoScreen(),),
      GoRoute(name : RouteName.welcomeScreen,              path: "/welcomeScreen", builder: (BuildContext context, GoRouterState state) => const WelcomeScreen(),),
      GoRoute(name : RouteName.sensorScreen,              path: "/sensorScreen", builder: (BuildContext context, GoRouterState state) => const SensorScreen(),),



    ]

);