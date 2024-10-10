
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/App/Utils/theme_styles.dart';
import 'package:test_app/App/Widgets/custom_text_widget.dart';

import '../../Provider/Sensor/sensor_provider.dart';




class SensorScreen extends ConsumerStatefulWidget {
  const SensorScreen({super.key});

  @override
  ConsumerState<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends ConsumerState<SensorScreen> {

  @override
  Widget build(BuildContext context) {

    final sensorNotifier = ref.watch(sensorScreenController);

    return Scaffold(
      backgroundColor: ThemeStyles.scaffoldBackgroundAccentColor,
      appBar: AppBar(
          backgroundColor: ThemeStyles.whiteColor,
          elevation: 0,
          iconTheme: IconThemeData(
              color: ThemeStyles.primaryTextColor
          ),
          title: CustomTextWidget( text: "Sensor Tracking",  fontSize: 20, fontWeight: FontWeight.bold, color: ThemeStyles.primaryTextColor,)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildGraphSection("Gyro", sensorNotifier.gyroX, sensorNotifier.gyroY, sensorNotifier.gyroZ),
            _buildGraphSection("Accelerometer", sensorNotifier.accelX, sensorNotifier.accelY, sensorNotifier.accelZ),
          ],
        ),
      ),
    );
  }


  Widget _buildGraphSection(String title, List<double> xData, List<double> yData, List<double> zData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomTextWidget(text:
          '$title Sensor Data',
            color: ThemeStyles.primary,
            fontSize: 18, fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  _buildLineChartData(xData, Colors.red, 'X'),
                  _buildLineChartData(yData, Colors.green, 'Y'),
                  _buildLineChartData(zData, Colors.blue, 'Z'),
                ],
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: true),
              ),
            ),
          ),
        ],
      ),
    );
  }


  LineChartBarData _buildLineChartData(List<double> data, Color color, String axisLabel) {
    return LineChartBarData(
      spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
      isCurved: false,
      color: color,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: true, color: color.withOpacity(0.1)),
    );
  }
}




