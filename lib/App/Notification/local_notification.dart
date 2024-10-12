import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class PushLocalNotifications {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Initialize timezone data
    tz.initializeTimeZones();
  }

  // Schedule a notification with a unique ID
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required String payload,
    required DateTime scheduledTime,
    int? notificationId, // Optional notification ID
  }) async {
    try {
      // Convert DateTime to TZDateTime
      final tz.TZDateTime scheduledTZDateTime = tz.TZDateTime.from(
          scheduledTime,
          tz.local // Use local timezone
      );

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId ?? DateTime.now().millisecondsSinceEpoch, // Unique ID
        title,
        body,
        scheduledTZDateTime, // The time at which to schedule the notification
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id', // Replace with your channel ID
            'your_channel_name', // Replace with your channel name
            channelDescription: 'Your channel description', // Replace with your channel description
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      // Handle any errors
      print('Error scheduling notification: $e');
    }
  }
}
