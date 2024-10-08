import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import '../../Model/Task/task_model.dart';
import '../../Repository/Home/home_repo.dart';
final homeScreenController =
ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  HomeRepository homeRepository = HomeRepository();



  final List<TaskModel> _tasks = [];
  final storage = GetStorage();

  List<TaskModel> get tasks => _tasks;


  void _loadTasksFromStorage() {
  List<dynamic> storedTasks = storage.read('tasks') ?? [];
  _tasks.addAll(storedTasks.map((e) => TaskModel.fromJson(e)).toList());
  notifyListeners();
  }

  void addTask(TaskModel task) {
  _tasks.add(task);
  _saveTasksToStorage();
  notifyListeners();
  }

  void removeTask(TaskModel task) {
  _tasks.remove(task);
  _saveTasksToStorage();
  notifyListeners();
  }

  void completeTask(TaskModel task) {
  task.isCompleted = true;
  _saveTasksToStorage();
  notifyListeners();
  }

  void _saveTasksToStorage() {
  storage.write('tasks', _tasks.map((e) => e.toJson()).toList());
  }

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialize notifications
  TaskNotifier() {
    _initializeNotifications();
    _loadTasksFromStorage();
    _checkForDueTasks();
  }

  void _initializeNotifications() {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    _notificationsPlugin.initialize(initializationSettings);
  }

  // Schedule notification for tasks due today
  void _checkForDueTasks() {
    for (var task in _tasks) {
      if (task.dueDate.isAtSameMomentAs(DateTime.now()) && !task.isCompleted) {
        _showNotification(task.heading);
      }
    }
  }

  void _showNotification(String taskHeading) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your_channel_id', 'your_channel_name',
        importance: Importance.max, priority: Priority.high);
    const platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await _notificationsPlugin.show(
      0,
      'Task Due Today',
      'You have a task "$taskHeading" due today!',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }



}

