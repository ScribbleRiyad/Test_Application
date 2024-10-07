
import 'package:go_router/go_router.dart';

import '../../Route/route_name.dart';
import '../../Utils/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Widgets/custom_text_widget.dart';




class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {







  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {

    Future.delayed(const Duration(seconds: 2), () {

        context.goNamed(RouteName.applicationScreen);

    });


  }


  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: ThemeStyles.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextWidget(text: "Welcome to ", color: ThemeStyles.primaryTextColor,fontSize: 18, fontWeight:FontWeight.bold),
                CustomTextWidget(text: "Test App", color: ThemeStyles.primaryTextColor,fontSize: 18,fontWeight:FontWeight.bold),
              ],
            )
        ),
      ),
    );
  }
}