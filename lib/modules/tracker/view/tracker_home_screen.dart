import 'package:breadcrumbs/modules/tracker/view_model/tracket_home_view_model.dart';
import 'package:breadcrumbs/modules/tracker/widgets/calories_chart.dart';
import 'package:breadcrumbs/modules/tracker/widgets/nutrition_chart.dart';
import 'package:breadcrumbs/modules/tracker/widgets/sub_nutrition_chart.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/widgets/chart/custom_bar_chart.dart';
import 'package:breadcrumbs/widgets/chart/custom_pie_chart.dart';
import 'package:breadcrumbs/widgets/date/scrollable_day_picker.dart';
import 'package:breadcrumbs/widgets/progress/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
// import 'package:fl_chart/fl_chart.dart';

const List<Color> colorsList = [
  Color.fromRGBO(38, 70, 83, 1),
  Color.fromRGBO(45, 157, 143, 1),
  Color.fromRGBO(233, 196, 106, 1),
  Color.fromRGBO(244, 162, 97, 1),
  Color.fromRGBO(231, 111, 81, 1),
];

class TrackerHomeScreen extends StatelessWidget {
  const TrackerHomeScreen(
      {super.key, required TrackerHomeViewModel trackerHomeViewModel})
      : _trackerHomeViewModel = trackerHomeViewModel;

  final TrackerHomeViewModel _trackerHomeViewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tracker",
        actions: [
          InkWell(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _trackerHomeViewModel.date,
                firstDate: DateTime(2023),
                lastDate: DateTime(2026),
              );

              if (pickedDate != null) {
                _trackerHomeViewModel.onChangeDate(pickedDate);
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.calendar_month),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: ListenableBuilder(
              listenable: _trackerHomeViewModel,
              builder: (context, child) {
                if (_trackerHomeViewModel.isError) {
                  return const Center(
                    child: Text(
                      "Something went wrong",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }

                if (_trackerHomeViewModel.userNutrition == null) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 24),
                    child: Column(
                      children: [
                        _buildDateSelection(context),
                        const SizedBox(
                          height: 16,
                        ),
                        const Center(
                          child: Text(
                            "No Data",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDateSelection(context),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildMainNutritionChart(context),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildMacroSection(context),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildSubNutrtionChart(context),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildVitaminChart(context)
                    ],
                  ),
                );
              })),
    );
  }

  Widget _buildMainNutritionChart(BuildContext context) {
    final limit = _trackerHomeViewModel.userDetail!.nutrition!.calories!;
    final consumed = _trackerHomeViewModel.userNutrition!.nutrition!.calories!;
    final diff = limit - consumed;
    final left = diff < 0 ? 0.toDouble() : diff;

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Calories",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _caloriesInfoText(
                context,
                const Color.fromRGBO(4, 176, 0, 1),
                'Left',
                left,
              ),
              _caloriesInfoText(context, const Color.fromRGBO(255, 1, 1, 100),
                  'Limit', limit),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CaloriesChart(consumedAmount: consumed, caloriesLimit: limit),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildMacroSection(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemWidth = (size.width - 16 - 12) / 2;
    final double itemHeight = itemWidth * (1.5 / 3);

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 16,
      childAspectRatio: itemWidth / itemHeight,
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: List.generate(
        _trackerHomeViewModel.mainNutrition.length, // Number of items
        (index) {
          final nutrition = _trackerHomeViewModel.mainNutrition[index];
          return Container(
            padding: const EdgeInsets.only(left: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: NutritionChart(
              nutritionText: nutrition.text,
              nutritionConsumed: nutrition.consumed,
              nutritionLimit: nutrition.limit,
              nutritionUnit: nutrition.unit,
              color: colorsList[index],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubNutrtionChart(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemWidth = (size.width - 16 - 12) / 2;
    final double itemHeight = itemWidth * (1.5 / 3);

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Mirconutrients",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 16,
            padding: const EdgeInsets.only(top: 12),
            childAspectRatio: itemWidth / itemHeight,
            children: _trackerHomeViewModel.subNutrition
                .map((nutrition) => SubNutritionChart(
                    subNutritionLimit: nutrition.limit,
                    color: Colors.brown,
                    consumedAnount: nutrition.consumed,
                    subNutritionText: nutrition.text,
                    subNutritionUnit: nutrition.unit))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVitaminChart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Vitamins",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          CustomBarChart(
            vitaminList: _trackerHomeViewModel.vitaminList,
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection(BuildContext context) {
    return Column(
      spacing: 24.0,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${DateFormat('MMM').format(_trackerHomeViewModel.date)} ${DateFormat('d').format(_trackerHomeViewModel.date)}, ${_trackerHomeViewModel.date.year}",
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () {
                    context.push(Routes.trackerRoute.trackerAnalytics);
                  },
                  child: Icon(
                    Icons.auto_graph,
                    color: Colors.orangeAccent,
                  ),
                ))
          ],
        ),
        ResponsiveScrollableDayPicker(
          selectedDate: _trackerHomeViewModel.date,
          onClickCallback: (DateTime date) {
            _trackerHomeViewModel.onChangeDate(date);
          },
        )
      ],
    );
  }

  Widget _caloriesInfoText(
      BuildContext context, Color color, String text, double value) {
    return Column(
      spacing: 4,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 10, color: color, fontWeight: FontWeight.w400),
        ),
        Text(
          value.toString(),
          style: TextStyle(
              fontSize: 16, color: color, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
