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
          iconTheme: IconThemeData(color: ThemeStyles.primaryTextColor),
          title: CustomTextWidget(
            text: "Sensor Tracking",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ThemeStyles.primaryTextColor,
          )),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                buildGraphSection(
                    "Gyro", sensorNotifier.gyroX, sensorNotifier.gyroY, sensorNotifier.gyroZ),
                buildGraphSection("Accelerometer", sensorNotifier.accelX,
                    sensorNotifier.accelY, sensorNotifier.accelZ),
              ],
            ),
          ),

          // Alert box overlay logic
          if (sensorNotifier.isCooldownActive) buildAlertBox(),
        ],
      ),
    );
  }


  Widget buildGraphSection(
      String title, List<double> xData, List<double> yData, List<double> zData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomTextWidget(
            text: '$title Sensor Data',
            color: ThemeStyles.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  buildLineChartData(xData, Colors.red, 'X'),
                  buildLineChartData(yData, Colors.green, 'Y'),
                  buildLineChartData(zData, Colors.blue, 'Z'),
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


  LineChartBarData buildLineChartData(List<double> data, Color color, String axisLabel) {
    return LineChartBarData(
      spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
      isCurved: false,
      color: color,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: true, color: color.withOpacity(0.1)),
    );
  }


  Widget buildAlertBox() {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning, color: ThemeStyles.whiteColor, size: 30),
              const SizedBox(height: 10),
              const CustomTextWidget( text:
                'High Movement Detected!',
                 fontSize: 16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
