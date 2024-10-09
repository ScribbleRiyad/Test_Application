import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:test_app/App/Provider/Home/home_provider.dart';
import 'package:test_app/App/Utils/theme_styles.dart';
import 'package:test_app/App/Widgets/custom_button.dart';
import 'package:test_app/App/Widgets/custom_form_field.dart';
import 'package:test_app/App/Widgets/custom_text_widget.dart';
import '../../Model/Task/task_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  dynamic homeScreenProvider;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeScreenProvider = ref.watch(homeScreenController);
  }


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
            text: 'To-Do List',
            color: ThemeStyles.primaryTextColor,
            fontSize: 20,
          ),
        ),
        body: ref
            .watch(homeScreenController)
            .tasks
            .isNotEmpty
            ? ListView.builder(
          itemCount: ref
              .watch(homeScreenController)
              .tasks
              .length,
          itemBuilder: (context, index) {
            final task = ref
                .watch(homeScreenController)
                .tasks[index];
            return Padding(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [

                                SvgPicture.asset("assets/Svg/align-left.svg",
                                  colorFilter: const ColorFilter.mode(
                                      ThemeStyles.primaryTextColor,
                                      BlendMode.srcIn),),
                                const SizedBox(width: 5,),
                                LimitedBox(
                                    maxWidth: 150,
                                    child: CustomTextWidget(text: task.heading,
                                      maxLines: 1,
                                      color: ThemeStyles.primaryTextColor,
                                      fontWeight: FontWeight.bold,)),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextWidget(text: "Completed",
                                  color: ThemeStyles.primaryTextColor,),
                                Switch(
                                  value: task.isCompleted,
                                  onChanged: (value) {
                                    ref.watch(homeScreenController)
                                        .completeTask(task, context: context);
                                  },
                                ),

                              ],
                            ),


                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            Row(
                              children: [
                                CustomTextWidget(text: "Delete",
                                  color: ThemeStyles.primaryTextColor,),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => showSimpleDialog(
                                      task: task, context: context),

                                ),
                              ],
                            ),
                          ],
                        ),


                      ],
                    ),
                  )
              ),
            );
          },
        )
            : Center(
          child: CustomTextWidget(
            text: 'No Task Found',
            color: ThemeStyles.primaryTextColor,
            fontSize: 18,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: ThemeStyles.primary,
          ),
          onPressed: () => _addTaskDialog(context),
        ),
      ),
    );
  }

  void _addTaskDialog(BuildContext context) {
    final headingController = TextEditingController();
    final detailsController = TextEditingController();
    dynamic selectedDateTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CustomTextWidget(
            text: 'Add A Task',
            color: ThemeStyles.primaryTextColor,
            textAlign: TextAlign.center,
          ),
          content: StatefulBuilder( // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFormField(
                      hintColor: ThemeStyles.primaryTextColor,
                      fillColor: ThemeStyles.scaffoldBackgroundAccentColor,
                      controller: headingController,
                      hint: 'Enter Heading',
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      obscureText: false,
                      enabled: true,
                    ),
                    SizedBox(height: 7),
                    CustomTextFormField(
                      hintColor: ThemeStyles.primaryTextColor,
                      fillColor: ThemeStyles.scaffoldBackgroundAccentColor,
                      controller: detailsController,
                      hint: 'Enter Details',
                      textInputType: TextInputType.text,
                      maxLines: 2,
                      obscureText: false,
                      enabled: true,
                    ),
                    SizedBox(height: 7),
                    CustomButton(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          TimeOfDay? selectedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (selectedTime != null) {
                            DateTime combinedDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );

                            selectedDateTime = DateFormat('dd-MM-yyyy, HH:mm a')
                                .format(combinedDateTime);
                          }
                        }
                      },
                      buttonText: "Add Date & Time",
                      isLoading: false,
                      iconColor: ThemeStyles.whiteColor,
                      assetName: "assets/Svg/calendar.svg",
                      buttonHeight: 50,
                      borderRadius: 16,
                      buttonColor: ThemeStyles.primary,
                    )
                  ],

                );
              }
          ),
          actions: [
            CustomButton(
              onTap: () {
                ref.watch(homeScreenController).addTask(
                  TaskModel(
                    heading: headingController.text,
                    details: detailsController.text,
                    dueDate: selectedDateTime,
                  ),
                );
                Navigator.of(context).pop();
              },
              buttonText: "Add Task",
              isLoading: false,
              iconColor: ThemeStyles.whiteColor,
              assetName: "assets/Svg/add.svg",
              buttonHeight: 50,
              borderRadius: 16,
              buttonColor: ThemeStyles.primary,
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  void showSimpleDialog(
      { required TaskModel task, required BuildContext context})
  {
    showModalBottomSheet(
      context: context,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (ctx) =>
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                    const CustomTextWidget(text:
                    'Are You Sure To Delete This Task',
                      fontSize: 14.0,
                      color: ThemeStyles.greenColor,
                    ),
                    const SizedBox(height: 60.0),
                    CustomButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonText: "Cancel",
                        borderRadius: 7,
                        buttonColor: ThemeStyles
                            .redColor,
                        isLoading: false,
                        iconColor: ThemeStyles.whiteColor,
                        assetName: "assets/Svg/cancel.svg"),
                    const SizedBox(height: 20.0),
                    CustomButton(
                        onTap: () {
                          Navigator.pop(context);
                          ref.watch(homeScreenController).removeTask(
                              task, context: context);
                        },

                        buttonText: "Delete",
                        buttonColor: ThemeStyles.primary,
                        isLoading: false,
                        borderRadius: 7,
                        iconColor: ThemeStyles.whiteColor,
                        assetName: "assets/Svg/delete.svg"),


              ],
            ),
          ),
    );
  }

}