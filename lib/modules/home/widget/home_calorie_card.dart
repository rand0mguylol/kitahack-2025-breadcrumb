import 'package:breadcrumbs/widgets/progress/progress_bar.dart';
import 'package:flutter/material.dart';

class HomeCalorieCard extends StatelessWidget {
  const HomeCalorieCard(
      {Key? key,
      required this.calorieEaten,
      required this.calorieLeft,
      required this.progressValue})
      : super(key: key);

  final double calorieEaten;
  final double calorieLeft;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(254, 202, 47, 1),
                Color.fromRGBO(254, 202, 47, 0.8),
              ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Calories eaten today',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16)),
          const SizedBox(height: 16),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(255, 255, 255, 0.25)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${calorieEaten.toStringAsFixed(0)} kcal",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 38)),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Text("Left: $calorieLeft",
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.black)),
                    ),
                    const SizedBox(height: 8),
                    ProgressBar(
                      progressValue: progressValue,
                      color: Color.fromRGBO(254, 202, 47, 1),
                    )
                  ]))
        ],
      ),
    );
  }
}
