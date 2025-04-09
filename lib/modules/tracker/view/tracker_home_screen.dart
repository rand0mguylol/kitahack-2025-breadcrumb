import 'package:breadcrumbs/modules/tracker/view_model/tracket_home_view_model.dart';
import 'package:breadcrumbs/modules/tracker/widgets/calories_chart.dart';
import 'package:breadcrumbs/modules/tracker/widgets/nutrition_chart.dart';
import 'package:breadcrumbs/modules/tracker/widgets/sub_nutrition_chart.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:breadcrumbs/widgets/button/custom_button.dart';
import 'package:breadcrumbs/widgets/chart/custom_bar_chart.dart';
import 'package:breadcrumbs/widgets/chart/custom_pie_chart.dart';
import 'package:breadcrumbs/widgets/progress/progress_bar.dart';
import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

class TrackerHomeScreen extends StatelessWidget {
  const TrackerHomeScreen(
      {super.key, required TrackerHomeViewModel trackerHomeViewModel})
      : _trackerHomeViewModel = trackerHomeViewModel;

  final TrackerHomeViewModel _trackerHomeViewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Tracker",
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
                    children: [
                      _buildDateSelection(context),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildMainNutritionChart(context),
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
          LayoutBuilder(builder: (builder, constraints) {
            final maxWidth = constraints.maxWidth;

            return Wrap(
              spacing: maxWidth * 0.15, // Horizontal spacing between children
              runSpacing: 20, // Vertical spacing between rows
              alignment:
                  WrapAlignment.spaceBetween, // Align children to the start
              runAlignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(
                _trackerHomeViewModel.mainNutrition.length, // Number of items
                (index) {
                  final nutrition = _trackerHomeViewModel.mainNutrition[index];
                  return NutritionChart(
                    nutritionText: nutrition.text,
                    nutritionConsumed: nutrition.consumed,
                    nutritionLimit: nutrition.limit,
                    nutritionUnit: nutrition.unit,
                    color: Colors.deepOrangeAccent,
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildSubNutrtionChart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      // child: LayoutBuilder(
      //   builder: (context, constraints) {
      //     final maxWidth = constraints.maxWidth;

      //     return Wrap(
      //       alignment: WrapAlignment.spaceBetween,
      //       // runAlignment: WrapAlignment.start,
      //       // crossAxisAlignment: WrapCrossAlignment.start,
      //       // spacing: maxWidth * 0.2, // Adjust spacing based on width
      //       runSpacing: 28, //
      //       children: List.generate(_trackerHomeViewModel.subNutrition.length,
      //           (index) {
      //         final nutrition = _trackerHomeViewModel.subNutrition[index];

      //         return Center(
      //             child: SubNutritionChart(
      //                 subNutritionLimit: nutrition.limit,
      //                 color: Colors.brown,
      //                 consumedAnount: nutrition.consumed,
      //                 subNutritionText: nutrition.text,
      //                 subNutritionUnit: nutrition.unit));
      //       }),
      //     );
      //   },

      // )
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 15, // Horizontal spacing
          mainAxisSpacing: 15, // Vertical spacing
          childAspectRatio: 2, // Width-to-height ratio of each item
        ),
        itemCount: _trackerHomeViewModel.subNutrition.length, // Number of items
        itemBuilder: (context, index) {
          final nutrition = _trackerHomeViewModel.subNutrition[index];
          return Center(
              child: SubNutritionChart(
                  subNutritionLimit: nutrition.limit,
                  color: Colors.brown,
                  consumedAnount: nutrition.consumed,
                  subNutritionText: nutrition.text,
                  subNutritionUnit: nutrition.unit));
        },
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
      child: CustomBarChart(
        vitaminList: _trackerHomeViewModel.vitaminList,
      ),
    );
  }

  Widget _buildDateSelection(BuildContext context) {
    return Column(
      spacing: 12.0,
      children: [
        Text(
          "${_trackerHomeViewModel.date.day}/${_trackerHomeViewModel.date.month}/${_trackerHomeViewModel.date.year}",
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12.0,
          children: [
            Expanded(
                child: CustomButton(
              text: "Select Date",
              textColor: Colors.black,
              backgroundColor: Colors.white,
              onPressed: () async {
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
            )),
            // Expanded(child: CustomButton(text: "Search")),
          ],
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


      // child: GridView.builder(
      //   shrinkWrap: true,
      //   physics: const NeverScrollableScrollPhysics(),
      //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //     maxCrossAxisExtent: 200,
      //     crossAxisSpacing: 15, // Horizontal spacing
      //     mainAxisSpacing: 15, // Vertical spacing
      //     childAspectRatio: 2, // Width-to-height ratio of each item
      //   ),
      //   itemCount: 2, // Number of items
      //   itemBuilder: (context, index) {
      //     return const Center(
      //         child: SubNutritionChart(
      //             subNutritionLimit: 100,
      //             color: Colors.red,
      //             consumedAnount: 50,
      //             subNutritionText: "Sugar",
      //             subNutritionUnit: 'g'));
      //   },
      // ),

                // GridView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //     // crossAxisCount: 2, // Number of items per row
          //     maxCrossAxisExtent: 250,
          //     // crossAxisSpacing: 8, // Horizontal spacing
          //     mainAxisSpacing: 15, // Vertical spacing
          //     childAspectRatio: 3, // Width-to-height ratio of each item
          //   ),
          //   itemCount:
          //       _trackerHomeViewModel.mainNutrition.length, // Number of items
          //   itemBuilder: (context, index) {
          //     final nutrition = _trackerHomeViewModel.mainNutrition[index];
          //     return Center(
          //       child: NutritionChart(
          //           nutritionText: nutrition.text,
          //           nutritionConsumed: nutrition.consumed,
          //           nutritionLimit: nutrition.limit,
          //           nutritionUnit: nutrition.unit,
          //           color: Colors.deepOrangeAccent),
          //     );
          //   },
          // ),
          // SizedBox(
          //   width: double.infinity,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     scrollDirection:
          //         Axis.horizontal, // Set the scroll direction to horizontal
          //     itemCount:
          //         _trackerHomeViewModel.mainNutrition.length, // Number of items
          //     itemBuilder: (context, index) {
          //       final nutrition = _trackerHomeViewModel.mainNutrition[index];
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(
          //             horizontal: 8.0), // Add spacing between items
          //         child: NutritionChart(
          //           nutritionText: nutrition.text,
          //           nutritionConsumed: nutrition.consumed,
          //           nutritionLimit: nutrition.limit,
          //           nutritionUnit: nutrition.unit,
          //           color: Colors.deepOrangeAccent,
          //         ),
          //       );
          //     },
          //   ),
          // )