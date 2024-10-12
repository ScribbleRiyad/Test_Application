
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Model/Task/task_model.dart';
import '../../Utils/theme_styles.dart';
import '../../Widgets/custom_text_widget.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeStyles.scaffoldBackgroundAccentColor,
        appBar: AppBar(
          backgroundColor: ThemeStyles.whiteColor,
          elevation: 0,
          iconTheme: IconThemeData(color: ThemeStyles.primaryTextColor),
          title: CustomTextWidget(
            text: task.heading,
            color: ThemeStyles.primaryTextColor,
            fontSize: 20,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Card(

              color: ThemeStyles.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(07)
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        SvgPicture.asset("assets/Svg/align-left.svg",
                          colorFilter: const ColorFilter.mode(
                              ThemeStyles.primaryTextColor,
                              BlendMode.srcIn),),
                        const SizedBox(width: 5,),
                        CustomTextWidget(text: task.heading,
                          maxLines: 5,
                          color: ThemeStyles.primaryTextColor,
                          fontWeight: FontWeight.bold,),
                      ],
                    ),
                    Row(
                      children: [

                        SvgPicture.asset("assets/Svg/align-left.svg",
                          colorFilter: const ColorFilter.mode(
                              ThemeStyles.primaryTextColor,
                              BlendMode.srcIn),),
                        const SizedBox(width: 5,),
                        CustomTextWidget(text: task.details,
                          maxLines: 100,
                          color: ThemeStyles.primaryTextColor,
                          fontWeight: FontWeight.bold,),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/Svg/calendar.svg",
                          colorFilter: const ColorFilter.mode(
                              ThemeStyles.primary, BlendMode.srcIn),),
                        const SizedBox(width: 5,),
                        CustomTextWidget(text: task.dueDate,
                          color: ThemeStyles.secondaryTextColor,),
                      ],
                    ),




                  ],
                ),
              )
          ),
        )


      ),
    );
  }
}
