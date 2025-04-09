import 'package:flutter/material.dart';
// import 'package:breadcrumbs/modules/tracker/view_model/tracket_home_view_model.dart';
// import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
// import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/widgets/chart/custom_pie_chart.dart';

class CaloriesChart extends StatelessWidget {
  const CaloriesChart(
      {super.key,
      required this.consumedAmount,
      required this.caloriesLimit,
      Color? color})
      : color = color ?? const Color.fromARGB(255, 173, 214, 126);

  final double consumedAmount;
  final Color color;
  final double caloriesLimit;

  @override
  Widget build(BuildContext context) {
    double calc = (consumedAmount / caloriesLimit) * 100;
    double eatenPercentage = calc <= 100 ? calc : 100;
    double leftPercentage = 100 - eatenPercentage;

    return SizedBox(
      width: 180,
      height: 180,
      child: CustomPieChart(
        data: leftPercentage == 100
            ? [
                PieChartData(
                    Colors.grey.withValues(alpha: 0.15), leftPercentage),
              ]
            : [
                PieChartData(
                    Colors.grey.withValues(alpha: 0.15), leftPercentage),
                PieChartData(color, eatenPercentage)
              ],
        radius: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              consumedAmount.toStringAsFixed(2),
              style: const TextStyle(color: Colors.black),
            ),
            const Text(
              "Consumed",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
