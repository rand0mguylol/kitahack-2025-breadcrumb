// import 'package:breadcrumbs/modules/tracker/view_model/tracket_home_view_model.dart';
// import 'package:breadcrumbs/modules/tracker/widgets/calories_chart.dart';
// import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
// import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/widgets/chart/custom_pie_chart.dart';
import 'package:flutter/material.dart';

class NutritionChart extends StatelessWidget {
  const NutritionChart(
      {super.key,
      required this.nutritionText,
      required this.nutritionConsumed,
      required this.nutritionLimit,
      required this.nutritionUnit,
      required this.color});

  final String nutritionText;
  final double nutritionLimit;
  final double nutritionConsumed;
  final Color color;
  final String nutritionUnit;

  @override
  Widget build(BuildContext context) {
    double calc = (nutritionConsumed / nutritionLimit) * 100;
    double eatenPercentage = calc <= 100 ? calc : 100;
    double leftPercentage = 100 - eatenPercentage;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        SizedBox(
          width: 30,
          height: 30,
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
            strokeWidth: 5,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nutritionText,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Text('$nutritionConsumed / $nutritionLimit $nutritionUnit',
                style: const TextStyle(color: Colors.black, fontSize: 10))
          ],
        )
      ],
    );
  }
}
