

import '../../Utils/theme_styles.dart';
import '../../Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
        backgroundColor: ThemeStyles.whiteColor,
      
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(

                children: [

                  CustomButton(
                    onTap: (){
                    context.push('/toDoScreen');
                  },
                    iconColor: ThemeStyles.blackColor,
                    buttonText: "A To-Do List",
                    assetName:'assets/Svg/task.svg' ,
                    isLoading: false,
                    borderColor: ThemeStyles.whiteColor,
                    borderRadius: 16,
                    buttonHeight: 76,
                 buttonWidth: 328,
                    buttonColor: Color(0xff36E0E0),
                    textColor: ThemeStyles.blackColor,),
                  const SizedBox(height: 20,),
                  CustomButton(
                    onTap: (){
                      context.push('/sensorScreen');
                    },
                    iconColor: ThemeStyles.whiteColor,
                    buttonText: "Sensor Tracking",
                    borderColor: ThemeStyles.whiteColor,
                    assetName:'assets/Svg/tracking.svg' ,
                    isLoading: false,
                    borderRadius: 16,
                    buttonHeight: 76,
                    buttonWidth: 328,
                    buttonColor: Color(0xff3F69FF),
                    textColor: ThemeStyles.whiteColor,),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}