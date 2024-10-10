

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';


final sensorScreenController =
ChangeNotifierProvider((ref) => SensorNotifier());


class SensorNotifier extends ChangeNotifier {

  List<double> gyroX = [];
  List<double> gyroY = [];
  List<double> gyroZ = [];

  List<double> accelX = [];
  List<double> accelY = [];
  List<double> accelZ = [];


  final double movementThreshold = 10.0;

  // Timer for sensor updates
  Timer? timer;

  SensorNotifier() {
    startListening();
  }

  void startListening() {



      gyroscopeEventStream().listen((GyroscopeEvent event) {
        if (!validateSensorData(event.x, event.y, event.z)) return;

        gyroX.add(event.x);
        gyroY.add(event.y);
        gyroZ.add(event.z);
        checkForAlert(event.x, event.y, event.z, 'gyro');


        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      });


      accelerometerEventStream().listen((AccelerometerEvent event) {
        if (!validateSensorData(event.x, event.y, event.z)) return;

        accelX.add(event.x);
        accelY.add(event.y);
        accelZ.add(event.z);
        checkForAlert(event.x, event.y, event.z, 'accel');


        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      });


      timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
        trimData(); // Trim data to keep it manageable


        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      });
    }

    bool validateSensorData(double x, double y, double z) {
      return x.isFinite && y.isFinite && z.isFinite;
    }

  void trimData() {

    if (gyroX.length > 50) {
      gyroX.removeAt(0);
      gyroY.removeAt(0);
      gyroZ.removeAt(0);
    }
    if (accelX.length > 50) {
      accelX.removeAt(0);
      accelY.removeAt(0);
      accelZ.removeAt(0);
    }
  }


  void checkForAlert(double x, double y, double z, String sensorType) {
    if ((x.abs() > movementThreshold && y.abs() > movementThreshold) ||
        (y.abs() > movementThreshold && z.abs() > movementThreshold)) {
      showAlert(sensorType);
    }
  }


  void showAlert(String sensorType) {

    print('High movement detected on $sensorType sensor!');

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
