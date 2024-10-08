import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  @override
  Widget build(BuildContext context) {
    final taskNotifier = ref.watch(homeScreenController);

    return Scaffold(
      backgroundColor: ThemeStyles.whiteColor,
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
      body: ref.watch(homeScreenController).tasks.isNotEmpty
          ? ListView.builder(
        itemCount: ref.watch(homeScreenController).tasks.length,
        itemBuilder: (context, index) {
          final task = ref.watch(homeScreenController).tasks[index];
          return ListTile(
            title: Text(task.heading),
            subtitle: Text('Due: ${task.dueDate}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(
                  value: task.isCompleted,
                  onChanged: (value) {
                    ref.watch(homeScreenController).completeTask(task);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      ref.watch(homeScreenController).removeTask(task),
                ),
              ],
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
          content:      StatefulBuilder(// You need this, notice the parameters below:
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
              assetName: "assets/Svg/Calendar.svg",
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
}
