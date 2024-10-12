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
    notifyListeners();
  }


  void loadTasksFromStorage() {
    List<dynamic> storedTasks = storage.read('tasks') ?? [];
    tasks.clear(); // Clear any existing tasks
    tasks.addAll(storedTasks.map((e) => TaskModel.fromJson(e)).toList());
    notifyListeners(); // Notify listeners about changes
  }


  void saveTasksToStorage() {
    storage.write('tasks', tasks.map((e) => e.toJson()).toList());
  }


  void addTask(TaskModel task) {
    tasks.add(task);
    saveTasksToStorage();
    scheduleTaskNotification(task);
    notifyListeners();
  }


  void removeTask(TaskModel task, { context}) {
    tasks.remove(task);
    Utils.customSnackBar(context: context, snackText: "Task Deleted Successfully");
    saveTasksToStorage();
    notifyListeners();
  }


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

