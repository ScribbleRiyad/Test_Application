import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:test_app/App/Utils/utils.dart';
import '../../Model/Task/task_model.dart';
import '../../Notification/local_notification.dart';
final homeScreenController =
ChangeNotifierProvider((ref) => HomeProvider());



class HomeProvider extends ChangeNotifier {
  final List<TaskModel> tasks = [];
  final storage = GetStorage();




  HomeProvider() {
    loadTasksFromStorage();
    // checkForDueTasks();
    notifyListeners();
  }

  // Load tasks from GetStorage
  void loadTasksFromStorage() {
    List<dynamic> storedTasks = storage.read('tasks') ?? [];
    tasks.clear(); // Clear any existing tasks
    tasks.addAll(storedTasks.map((e) => TaskModel.fromJson(e)).toList());
    notifyListeners(); // Notify listeners about changes
  }

  // Save tasks to GetStorage
  void saveTasksToStorage() {
    storage.write('tasks', tasks.map((e) => e.toJson()).toList());
  }

  // Add a new task
  void addTask(TaskModel task) {
    tasks.add(task);
    scheduleTaskNotification(task);
    notifyListeners();
  }

  // Remove a task
  void removeTask(TaskModel task, { context}) {
    tasks.remove(task);
    Utils.customSnackBar(context: context, snackText: "Task Deleted Successfully");
    saveTasksToStorage();
    notifyListeners();
  }

  // Mark a task as completed
  void completeTask(TaskModel task, { context}) {
    task.isCompleted = !task.isCompleted;
    if(task.isCompleted == true){
      Utils.customSnackBar(context: context, snackText: "Task completed");
    }else if(task.isCompleted == false){
      Utils.customSnackBar(context: context, snackText: "Task not completed yet");
    }// Toggle completion status
    saveTasksToStorage();
    notifyListeners();
  }



  // void checkForDueTasks() {
  //   final DateFormat formatter = DateFormat('dd-MM-yyyy, HH:mm a');  // Adjust to your format
  //   final DateTime now = DateTime.now();
  //
  //   for (var task in tasks) {
  //     try {
  //       // Parse the stored date string into DateTime
  //       final DateTime taskDueDate = formatter.parse(task.dueDate);
  //
  //       // Check if task is due today (same date, ignoring time) and not completed
  //       if (_isSameDay(taskDueDate, now) && !task.isCompleted) {
  //         _showNotification(task.heading);
  //       }
  //     } catch (e) {
  //       // Handle parse error, in case the stored date is invalid
  //       print('Error parsing task due date: ${task.dueDate}. Error: $e');
  //     }
  //   }
  // }

// // Helper method to compare if two DateTime objects are on the same day
//   bool _isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }



  // Schedule notification for task due date
  void scheduleTaskNotification(TaskModel task) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy, HH:mm a');
    PushLocalNotifications.scheduleNotification(
      title: 'Task Reminder',
      body: 'Your task "${task.heading}" is due.',
      payload: task.details,
      scheduledTime: formatter.parse(task.dueDate), // Assume task has a dueDate field
    );
  }
}


