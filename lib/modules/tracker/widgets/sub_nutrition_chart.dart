import 'package:breadcrumbs/widgets/progress/progress_bar.dart';
import 'package:flutter/material.dart';

class SubNutritionChart extends StatelessWidget {
  const SubNutritionChart({
    super.key,
    required this.subNutritionLimit,
    required this.color,
    required this.consumedAnount,
    required this.subNutritionText,
    required this.subNutritionUnit,
  });

  final String subNutritionText;
  final double consumedAnount;
  final double subNutritionLimit;
  final String subNutritionUnit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double calc = consumedAnount > 0 ? (consumedAnount / subNutritionLimit) : 0;
    double eatenPercentage = calc <= 1.0 ? calc : 1.0;
    double leftPercentage = 100 - eatenPercentage;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          subNutritionText,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // ProgressBar(
        //   progressValue: eatenPercentage,
        //   height: 5,
        //   color: color,
        // ),
        Text("${consumedAnount} / $subNutritionLimit $subNutritionUnit",
            style: TextStyle(color: Colors.black))
      ],
    );
  }
}
